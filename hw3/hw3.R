# Run from the command line via, e.g.,
#   R CMD BATCH --no-save '--args <template spectrum> <data directory>' hw3.R
library(astro)

rm(list = ls())

args = (commandArgs(trailingOnly=TRUE))
if(length(args) == 2){
  template_spectrum = args[1]
  data_directory = args[2]
} else {
  cat('usage: R CMD BATCH "--args <template spectrum> <data directory>" hw3.R', file=stderr())
  stop()
}

template_spectrum  = as.data.frame(read.fitstab(paste(template_spectrum)))
template_spectrum_wavelength = 10^template_spectrum$LOGLAM
template_spectrum_flux = template_spectrum$FLUX
template_spectrum = data.frame(template_spectrum, wavelength = template_spectrum_wavelength)

files = list.files(paste(data_directory))
template_spectrum_flux_nm = (template_spectrum_flux - mean(template_spectrum_flux))/sd(template_spectrum_flux) # normalize template_spectrum

n = length(files)       # n = length(files)
bestdislist = rep(0, n)
specID = rep(0, n)
bestdisloc = rep(0, n)
for (i in 1:n) {
  spec = read.fitstab(paste(data_directory, "/", files[i], sep = ""))
  spec = as.data.frame(spec)
  spec$wavelength = 10^spec$loglam
  spec = spec[spec$and_mask == 0,]
  spec_flux_nm = (spec$flux - mean(spec$flux))/sd(spec$flux)
  spec_len = length(spec_flux_nm)
  template_spectrum_len = length(template_spectrum_flux_nm)
  bestdistance = Inf
  if (spec_len >= template_spectrum_len) {
    for (j in 1:(spec_len+1-template_spectrum_len)) {
      spec_part = spec_flux_nm[j:(j+template_spectrum_len-1)]
      distance = sqrt(sum((spec_part - template_spectrum_flux_nm)^2))
      if (distance < bestdistance) {
        bestdistance = distance
        bestlocation = j
      }
    }
  }
  bestdislist[i] = bestdistance
  specID[i] = files[i]
  bestdisloc[i] = bestlocation
} 
specID = gsub(pattern = "spec-", replacement = "", specID)
specID = gsub(pattern = ".fits", replacement = "", specID)

result = data.frame(distance = bestdislist, spectrumID = specID, i = bestdisloc)
result_sorted_by_distance = result[order(result$distance),]
write.table(result_sorted_by_distance, paste(args[2], ".csv", sep = ""), row.names = FALSE, col.names = F, quote = F, sep = ",")
