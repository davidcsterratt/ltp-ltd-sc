library(dplyr)

source("kasim.R")
## For version of 2017-03-24
options(kasim="./KaSim/KaSim-76a8b98")
kafile <- "maguk.ka"

## For version of 2018-03-09
## options(kasim="./KaSim/KaSim")
## kafile <- "maguk4.ka"


read.carletal <- function(file="fig3a_wt.csv", dir="CarlEtal08oppo/") {
  return(read.csv(file.path(dir, file), skip=1
                  ))
}

plot.ts <- function(dat, ylim=c(0, 200), add=FALSE, hue=1, alpha=0.5,
                    ylab="Strength (% Baseline)", xlim=NA, ...) {
  if (is.na(xlim)) {
    xlim <- range(dat$time)
  }
  if (!add) {
    plot(NA, NA, 
         xlim=xlim, ylim=ylim,
         xlab="Time (minutes)", ylab=ylab, ...)
  }
  n <- length(dat$time)
  polygon(c(dat$time, dat$time[n:1]),
          c(apply(select(dat, -time), 1, max),
            apply(select(dat, -time), 1, min)[n:1]),
          col=hsv(hue, 0.5, 1, alpha), border=hsv(hue, 1, 1, alpha))
  lines(dat$time, rowMeans(select(dat, -time), na.rm=TRUE), col=hsv(hue, 1, 0.5))
  #lines(, apply(select(dat, -time), 1, max), type='l', ylim=ylim)
  # lines(dat$time, apply(select(dat, -time), 1, min), type='l', ylim=ylim)
}

run.kasims <- function(files="maguk.ka", l=67*60, p=10, n=10,
                       record=c("stargazin-PSD95"=100/15, "Phos CaMKII"=1, "Active PP1"=1, "PP3-Ca"=1, "Phos stargazin"=1)) {
  kasim <- parallel::mclapply(1:n, function(x) {run.kasim(files=files, l=l, p=p,
                                                          flags="--gluttony")})

  i <- which.max(sapply(kasim, function(x) { length(x[,"[T]"])} ))
  Tvec <- kasim[[i]][,"[T]"]
  N <- length(Tvec)
  
  out <- list(kasim=kasim)
  for (r in names(record)) {
    out[[r]] <- data.frame(time=Tvec/60 - 20,
                           do.call(cbind,
                                   lapply(kasim,
                                          function(x) {
                                            return(c(x[,r], rep(NA, N - length(x[,r]))))
                                          }))*record[r])
  }
  return(out)
}
