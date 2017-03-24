library(dplyr)

source("../../KappaTutorial/kasim.R")
options(kasim="KaSim")

read.carletal <- function(file="fig3a_wt.csv", dir="../../data/CarlEtal08oppo/") {
  return(read.csv(file.path(dir, file), skip=1
                  ))
}

plot.ts <- function(dat, ylim=c(0, 200), add=FALSE, hue=1, alpha=0.5, ...) {
  if (!add) {
    plot(NA, NA, 
         xlim=range(dat$time), ylim=ylim,
         xlab="Time (minutes)", ylab="Strength (% Baseline)", ...)
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

run.kasims <- function(files="maguk.ka", l=67*60, p=10, n=10) {
  kasim <- lapply(1:n, function(x) {run.kasim(files=files, l=l, p=p)})
  stg.psd95 <- data.frame(time=kasim[[1]][,"[T]"]/60 - 20,
                          do.call(cbind,
                                  lapply(kasim,
                                         function(x) {return(x[,"stargazin-PSD95"])}))/10*100)
  return(list(kasim=kasim, stg.psd95=stg.psd95))
}
                       
## Plot simulations
par(mfcol=c(2, 2),
    mar=c(2.4, 3, 1.5, 0.5),
    mgp=c(1.3, 0.4, 0))

## Fig A - 5Hz/5 sec
plot.ts(read.carletal("fig3a_wt.csv"), main="A: 5Hz/5 sec")
sims.a <- run.kasims(c("par-a.ka", "maguk.ka"), l=67*60, p=10)
plot.ts(sims.a$stg.psd95, add=TRUE, hue=0.5)

## Fig B - 5Hz/1 min
plot.ts(read.carletal("fig3b_wt.csv"), main="B: 5Hz/15 sec")
sims.b <- run.kasims(c("par-b.ka", "maguk.ka"), l=67*60, p=10)
plot.ts(sims.b$stg.psd95, add=TRUE, hue=0.5)

## Fig C - 5Hz/15 second
plot.ts(read.carletal("fig3c_wt.csv"), main="C: 5Hz/1 min")
sims.c <- run.kasims(c("par-c.ka", "maguk.ka"), l=67*60, p=10)
plot.ts(sims.c$stg.psd95, add=TRUE, hue=0.5)

#matplot(select(dat, time), select(dat, -time), pch=19, ylim=c(0, 200))

# plot.kasim(sims[[1]])




# plot.ts(stg.psd95.sim, add=TRUE, hue=0.5)
