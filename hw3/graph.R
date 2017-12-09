library(astro)
rm(list = ls())

args = (commandArgs(trailingOnly=TRUE))
if(length(args) == 4){
  template_spectrum = args[1]
  data_directory = args[2]
  spectrum_name = args[3]
  position = args[4]
} else {
  cat('usage: R CMD BATCH "--args <template spectrum> <data directory> <spectrum_name> <position>" graph.R', file=stderr())
  stop()
}

cb58 = as.data.frame(read.fitstab(args[1]))
cb58_wavelength = 10^cb58$LOGLAM
cb58_flux = cb58$FLUX
cb58 = data.frame(cb58, wavelength = cb58_wavelength)
cb58_flux_nm = (cb58_flux - mean(cb58_flux))/sd(cb58_flux)
cb58_len = length(cb58_flux_nm)

specname = paste("spec-", args[3], ".fits", sep = "")
position = as.numeric(args[4])

spec = as.data.frame(read.fitstab(paste(data_directory, "/", specname, sep = "")))
spec$wavelength = 10^spec$loglam
spec = spec[spec$and_mask == 0,]
spec_flux_nm = (spec$flux - mean(spec$flux))/sd(spec$flux)

pdf(paste(args[3], ".pdf", sep = ""))
plot(spec$wavelength, spec_flux_nm, type = "l", col = "blue", xlab = "wavelength", ylab = "flux")
lines(spec$wavelength[position]:(spec$wavelength[position]+cb58_len-1), cb58_flux_nm, type = "l", col = "red", xlab = "wavelength", ylab = "flux")
legend("topright", legend = c("cb58", paste(args[3])), lty = c(1,1), col = c("red", "blue"))
dev.off()