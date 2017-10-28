library(astro)
library(tidyverse)
cb58 = read.fitstab("cb58_Lyman_break.fit")
cb58_wavelength	= 10^cb58[,1]
cb58_flux = cb58[,2]
cb58 = data.frame(cb58, wavelength = cb58_wavelength)

# make a graph showing the spectrum (x=wavelength, y=flux) of cb58            
pdf("cb58_spectrum.pdf")
plot(cb58_wavelength, cb58_flux, type = "l", col = "red", xlab = "wavelength", ylab = "flux")
dev.off()

# Find the 3 SDSS spectra closest to cb58 by a measure of your choice           

## read .fits files and save as rdata                                                            
files =	list.files("./data") # "/Users/wenyanzhou/course/STAT679/hw2/2/data"
SDSSlist = files
SDSSlist = sub(pattern = ".fits", replacement = "", SDSSlist)
SDSSlist = gsub(pattern = "-", replacement = "_", SDSSlist)
files = gsub(pattern = "spec", replacement = "data/spec", files)
dir.create("SDSS")
for (i in 1:length(SDSSlist)) {
  spec = assign(paste(SDSSlist[i]), as_tibble(read.fitstab(files[i])) %>% mutate(wavelength = 10^loglam, var = 1/ivar) %>% filter(and_mask == 0))
  save(spec, file = paste("SDSS/",SDSSlist[i],".RData", sep = ""))
}

## prof's method (Euclidean distance)
### compute Euclidean distance
cb58_flux_nm = (cb58_flux - mean(cb58_flux))/sd(cb58_flux) # normalize cb58 
SDSSspecfiles = list.files("SDSS")
bestdislist = rep(0,100)
bestdisloc = rep(0,100)
for (i in 1:length(SDSSspecfiles)) { # loop through 100 fits
  load(paste("SDSS/",SDSSspecfiles[i],sep = ""))
  spec_flux_nm = (spec$flux - mean(spec$flux))/sd(spec$flux) # normalize spec
  spec_len = length(spec_flux_nm)
  cb58_len = length(cb58_flux_nm)
  bestdistance = Inf
  if (spec_len >= cb58_len) {
    for (j in 1:(spec_len+1-cb58_len)) { # shift cb58 flux in one spec flux 
      spec_part = spec_flux_nm[j:(j+cb58_len-1)]
      distance = sqrt(sum((spec_part - cb58_flux_nm)^2))
      if (distance < bestdistance) {
        bestdistance = distance
        bestlocation = j
      }
    }
  }
  bestdislist[i] = bestdistance
  bestdisloc[i] = bestlocation
}

### sort spectra in distance from low to high
sortedspectra1 = SDSSlist[order(bestdislist)]

### Add the 3 aligned spectra to your graph. Include a legend identifying cb58 and the other spectra. (e.g. Identify"data/spec-2359-53826-0199.fits" as "2359-53826-0199".)
#### rank "spec_5324_55947_0886"(1), "spec_5328_55982_0218"(2), "spec_4242_55476_0780"(3)
spec_5324_55947_0886_flux_nm = (spec_5324_55947_0886$flux - mean(spec_5324_55947_0886$flux))/sd(spec_5324_55947_0886$flux)
spec_5328_55982_0218_flux_nm = (spec_5328_55982_0218$flux - mean(spec_5328_55982_0218$flux))/sd(spec_5328_55982_0218$flux)
spec_4242_55476_0780_flux_nm = (spec_4242_55476_0780$flux - mean(spec_4242_55476_0780$flux))/sd(spec_4242_55476_0780$flux)
best1_1 = bestdisloc[which(SDSSspecfiles == "spec_5324_55947_0886.RData")]
best1_2 = bestdisloc[which(SDSSspecfiles == "spec_5328_55982_0218.RData")]
best1_3 = bestdisloc[which(SDSSspecfiles == "spec_4242_55476_0780.RData")]
pdf("method1_1.pdf")
plot(spec_5324_55947_0886$wavelength, spec_5324_55947_0886_flux_nm, type = "l", col = "blue", xlab = "wavelength", ylab = "flux")
lines(spec_5324_55947_0886$wavelength[best1_1]:(spec_5324_55947_0886$wavelength[best1_1]+cb58_len-1), cb58_flux_nm, type = "l", col = "red", xlab = "wavelength", ylab = "flux")
legend("topright", legend = c("cb58", "5324-55947-0886"), lty = c(1,1), col = c("red", "blue"))
dev.off()
pdf("method1_2.pdf")
plot(spec_5328_55982_0218$wavelength, spec_5328_55982_0218_flux_nm, type = "l", col = "blue", xlab = "wavelength", ylab = "flux")
lines(spec_5328_55982_0218$wavelength[best1_2]:(spec_5328_55982_0218$wavelength[best1_2]+cb58_len-1), cb58_flux_nm, type = "l", col = "red", xlab = "wavelength", ylab = "flux")
legend("topright", legend = c("cb58", "5328_55982_0218"), lty = c(1,1), col = c("red", "blue"))
dev.off()
pdf("method1_3.pdf")
plot(spec_4242_55476_0780$wavelength, spec_4242_55476_0780_flux_nm, type = "l", col = "blue", xlab = "wavelength", ylab = "flux")
lines(spec_4242_55476_0780$wavelength[best1_3]:(spec_4242_55476_0780$wavelength[best1_3]+cb58_len-1), cb58_flux_nm, type = "l", col = "red", xlab = "wavelength", ylab = "flux")
legend("topright", legend = c("cb58", "4242_55476_0780"), lty = c(1,1), col = c("red", "blue"))
dev.off()

## method 2 (Mahalanobis distance) 
### compute Mahalanobis distance
MahalanobisDistance <- function(x, y) {
  diff = mean(x) - mean(y)
  n1 = length(x);n2 = length(y);n = n1 + n2
  xvar = var(x)*(n1-1)/n1
  yvar = var(y)*(n2-1)/n2
  s = (n1/n)*xvar + (n2/n)*yvar
  dist = sqrt(diff^2/s)
  return(dist)
}
bestdislist2 = rep(0,100)
bestdisloc2 = rep(0,100)
for (i in 1:length(SDSSspecfiles)) { # loop through 100 fits
  load(paste("SDSS/",SDSSspecfiles[i],sep = ""))
  spec_flux_nm = (spec$flux - mean(spec$flux))/sd(spec$flux) # normalize spec
  spec_len = length(spec_flux_nm)
  cb58_len = length(cb58_flux_nm)
  bestdistance = Inf
  if (spec_len >= cb58_len) {
    for (j in 1:(spec_len+1-cb58_len)) { # shift cb58 flux in one spec flux 
      spec_part = spec_flux_nm[j:(j+cb58_len-1)]
      distance =  MahalanobisDistance(spec_part, cb58_flux_nm)
      if (distance < bestdistance) {
        bestdistance = distance
        bestlocation = j
      }
    }
  }
  bestdislist2[i] = bestdistance
  bestdisloc2[i] = bestlocation
}

### consider specs with low distance and see their plots
sortedspectra2 = SDSSlist[order(bestdislist2)]

### Add the 3 aligned spectra to your graph. Include a legend identifying cb58 and the other spectra. (e.g. Identify"data/spec-2359-53826-0199.fits" as "2359-53826-0199".)
#### rank "spec_5324_55947_0886"(1), "spec_5047_55833_0214"(2), "spec_7257_56658_0239"(3)
spec_5324_55947_0886_flux_nm = (spec_5324_55947_0886$flux - mean(spec_5324_55947_0886$flux))/sd(spec_5324_55947_0886$flux)
spec_5047_55833_0214_flux_nm = (spec_5047_55833_0214$flux - mean(spec_5047_55833_0214$flux))/sd(spec_5047_55833_0214$flux)
spec_7257_56658_0239_flux_nm = (spec_7257_56658_0239$flux - mean(spec_7257_56658_0239$flux))/sd(spec_7257_56658_0239$flux)
best2_1 = bestdisloc[which(SDSSspecfiles == "spec_5324_55947_0886.RData")]
best2_2 = bestdisloc[which(SDSSspecfiles == "spec_5047_55833_0214.RData")]
best2_3 = bestdisloc[which(SDSSspecfiles == "spec_7257_56658_0239.RData")]
pdf("method2_1.pdf")
plot(spec_5324_55947_0886$wavelength, spec_5324_55947_0886_flux_nm, type = "l", col = "blue", xlab = "wavelength", ylab = "flux")
lines(spec_5324_55947_0886$wavelength[best2_1]:(spec_5324_55947_0886$wavelength[best2_1]+cb58_len-1), cb58_flux_nm, type = "l", col = "red", xlab = "wavelength", ylab = "flux")
legend("topright", legend = c("cb58", "5324-55947-0886"), lty = c(1,1), col = c("red", "blue"))
dev.off()
pdf("method2_2.pdf")
plot(spec_5047_55833_0214$wavelength, spec_5047_55833_0214_flux_nm, type = "l", col = "blue", xlab = "wavelength", ylab = "flux")
lines(spec_5047_55833_0214$wavelength[best2_2]:(spec_5047_55833_0214$wavelength[best2_2]+cb58_len-1), cb58_flux_nm, type = "l", col = "red", xlab = "wavelength", ylab = "flux")
legend("topright", legend = c("cb58", "5047_55833_0214"), lty = c(1,1), col = c("red", "blue"))
dev.off()
pdf("method2_3.pdf")
plot(spec_7257_56658_0239$wavelength, spec_7257_56658_0239_flux_nm, type = "l", col = "blue", xlab = "wavelength", ylab = "flux")
lines(spec_7257_56658_0239$wavelength[best2_3]:(spec_7257_56658_0239$wavelength[best2_3]+cb58_len-1), cb58_flux_nm, type = "l", col = "red", xlab = "wavelength", ylab = "flux")
legend("topright", legend = c("cb58", "7257_56658_0239"), lty = c(1,1), col = c("red", "blue"))
dev.off()

## method 3 (correlation coefficient)
### compute pearson correlation coefficient
bestcorrlist = rep(0,100)
bestcorrloc = rep(0,100)
for (i in 1:length(SDSSspecfiles)) { # loop through 100 fits
  load(paste("SDSS/",SDSSspecfiles[i],sep = ""))
  spec_flux_nm = (spec$flux - mean(spec$flux))/sd(spec$flux) # normalize spec
  spec_len = length(spec_flux_nm)
  cb58_len = length(cb58_flux_nm)
  bestcorr = 0
  if (spec_len >= cb58_len) {
    for (j in 1:(spec_len+1-cb58_len)) { # shift cb58 flux in one spec flux 
      spec_part = spec_flux_nm[j:(j+cb58_len-1)]
      corr = cor(spec_part, cb58_flux_nm)
      if (corr > bestcorr) {
        bestcorr = corr
        bestlocation = j
      }
    }
  }
  bestcorrlist[i] = bestcorr
  bestcorrloc[i] = bestlocation
}

### consider specs with high correlation and see their plots
sortedspectra3 = SDSSlist[order(-bestcorrlist)]

### Add the 3 aligned spectra to your graph. Include a legend identifying cb58 and the other spectra. (e.g. Identify"data/spec-2359-53826-0199.fits" as "2359-53826-0199".)
#### rank "spec_5328_55982_0218"(1), "spec_5324_55947_0886"(2), "spec_1353_53083_0579"(3)
spec_5328_55982_0218_flux_nm = (spec_5328_55982_0218$flux - mean(spec_5328_55982_0218$flux))/sd(spec_5328_55982_0218$flux)
spec_5324_55947_0886_flux_nm = (spec_5324_55947_0886$flux - mean(spec_5324_55947_0886$flux))/sd(spec_5324_55947_0886$flux)
spec_1353_53083_0579_flux_nm = (spec_1353_53083_0579$flux - mean(spec_1353_53083_0579$flux))/sd(spec_1353_53083_0579$flux)
best3_1 = bestdisloc[which(SDSSspecfiles == "spec_5328_55982_0218.RData")]
best3_2 = bestdisloc[which(SDSSspecfiles == "spec_5324_55947_0886.RData")]
best3_3 = bestdisloc[which(SDSSspecfiles == "spec_1353_53083_0579.RData")]
pdf("method3_1.pdf")
plot(spec_5328_55982_0218$wavelength, spec_5328_55982_0218_flux_nm, type = "l", col = "blue", xlab = "wavelength", ylab = "flux")
lines(spec_5328_55982_0218$wavelength[best3_1]:(spec_5328_55982_0218$wavelength[best3_1]+cb58_len-1), cb58_flux_nm, type = "l", col = "red", xlab = "wavelength", ylab = "flux")
legend("topright", legend = c("cb58", "5328_55982_0218"), lty = c(1,1), col = c("red", "blue"))
dev.off()
pdf("method3_2.pdf")
plot(spec_5324_55947_0886$wavelength, spec_5324_55947_0886_flux_nm, type = "l", col = "blue", xlab = "wavelength", ylab = "flux")
lines(spec_5324_55947_0886$wavelength[best3_2]:(spec_5324_55947_0886$wavelength[best3_2]+cb58_len-1), cb58_flux_nm, type = "l", col = "red", xlab = "wavelength", ylab = "flux")
legend("topright", legend = c("cb58", "5324_55947_0886"), lty = c(1,1), col = c("red", "blue"))
dev.off()
pdf("method3_3.pdf")
plot(spec_1353_53083_0579$wavelength, spec_1353_53083_0579_flux_nm, type = "l", col = "blue", xlab = "wavelength", ylab = "flux")
lines(spec_1353_53083_0579$wavelength[best3_3]:(spec_1353_53083_0579$wavelength[best3_3]+cb58_len-1), cb58_flux_nm, type = "l", col = "red", xlab = "wavelength", ylab = "flux")
legend("topright", legend = c("cb58", "1353_53083_0579"), lty = c(1,1), col = c("red", "blue"))
dev.off()
