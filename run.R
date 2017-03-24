library(dplyr)

source("../../KappaTutorial/kasim.R")
options(kasim="KaSim")

read.carletal <- function(file="fig3a_wt.csv", dir="../../data/CarlEtal08oppo/") {
  return(read.csv(file.path(dir, file), skip=1
                  ))
}

plot.ts <- function(dat, ylim=c(0, 200), add=FALSE, hue=1, alpha=0.5) {
  if (!add) {
    plot(NA, NA, 
         xlim=range(dat$time), ylim=ylim,
         xlab="Time (minutes)", ylab="Strength %")
  }
  n <- length(dat$time)
  polygon(c(dat$time, dat$time[n:1]),
          c(apply(select(dat, -time), 1, max),
            apply(select(dat, -time), 1, min)[n:1]),
          col=hsv(hue, 0.5, 1, alpha), border=hsv(hue, 1, 1, alpha))
  lines(dat$time, rowMeans(select(dat, -time)), col=hsv(hue, 1, 0.5))
  #lines(, apply(select(dat, -time), 1, max), type='l', ylim=ylim)
  # lines(dat$time, apply(select(dat, -time), 1, min), type='l', ylim=ylim)
}

sims <- lapply(1:20, function(x) {run.kasim("maguk.ka", l=67*60, p=10)})
par(mfrow=c(2, 1),
    mar=c(2.4, 3, 1.5, 0.5),
    mgp=c(1.3, 0.4, 0))
plot.kasim(sims[[1]])

dat <- read.carletal("fig3a_wt.csv")

#matplot(select(dat, time), select(dat, -time), pch=19, ylim=c(0, 200))


stg.psd95.sim <- data.frame(time=sims[[1]][,"[T]"]/60 - 20,
                       do.call(cbind,
                               lapply(sims,
                                      function(x) {return(x[,"stargazin-PSD95"])}))/10*100)

plot.ts(dat)
plot.ts(stg.psd95.sim, add=TRUE, hue=0.5)
