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
                    ylab="Strength (% Baseline)", ...) {
  if (!add) {
    plot(NA, NA, 
         xlim=range(dat$time), ylim=ylim,
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
                       record=c("stargazin-PSD95", "Phos CaMKII", "Active PP1")) {
  kasim <- parallel::mclapply(1:n, function(x) {run.kasim(files=files, l=l, p=p,
                                                          flags="--gluttony")})

  i <- which.max(sapply(kasim, function(x) { length(x[,"[T]"])} ))
  Tvec <- kasim[[i]][,"[T]"]
  N <- length(Tvec)
  
  out <- list(kasim=kasim)
  for (r in record) {
    out[[r]] <- data.frame(time=Tvec/60 - 20,
                           do.call(cbind,
                                   lapply(kasim,
                                          function(x) {
                                            return(c(x[,r], rep(NA, N - length(x[,r]))))
                                          }))/10*100)
  }
  return(out)
}


sims.a <- run.kasims(c("par-a.ka", kafile), l=67*60, p=10)
sims.b <- run.kasims(c("par-b.ka", kafile), l=67*60, p=10)
sims.c <- run.kasims(c("par-c.ka", kafile), l=67*60, p=10)


## Plot simulations
## png(file="stg-psd95.png", width=1000, height=800)
par(mfcol=c(3, 3),
    mar=c(2.4, 3, 1.5, 0.5),
    mgp=c(1.3, 0.4, 0))

## Fig A - 5Hz/5sec
plot.ts(read.carletal("fig3a_wt.csv"), main="A: 5Hz/5sec")
plot.ts(sims.a[["stargazin-PSD95"]], add=TRUE, hue=0.5)
mtext("Stargazin-PSD95", line=2)

## Fig B - 5Hz/15sec
plot.ts(read.carletal("fig3b_wt.csv"), main="B: 5Hz/15sec")
plot.ts(sims.b[["stargazin-PSD95"]], add=TRUE, hue=0.5)

## Fig C - 5Hz/1min
plot.ts(read.carletal("fig3c_wt.csv"), main="C: 5Hz/1min")
plot.ts(sims.c[["stargazin-PSD95"]], add=TRUE, hue=0.5)
## dev.off()
## plot(NA, NA, xlab="", ylab="", xaxt="", yaxt="")

#matplot(select(dat, time), select(dat, -time), pch=19, ylim=c(0, 200))
# plot.kasim(sims[[1]])

## x11()
## par(mfcol=c(2, 4),
##     mar=c(2.4, 3, 1.5, 0.5),
##     mgp=c(1.3, 0.4, 0),
##     oma=c(0, 0, 2, 0))
plot.ts(sims.a[["Phos CaMKII"]], ylab="#", ylim=c(0, 1000), hue=0.5, main="5Hz/5sec")
mtext("Phos CaMKII", line=2)
plot.ts(sims.b[["Phos CaMKII"]], ylab="#", ylim=c(0, 1000), hue=0.5, main="5Hz/15sec")
plot.ts(sims.c[["Phos CaMKII"]], ylab="#", ylim=c(0, 1000), hue=0.5, main="5Hz/1min")
                                        ## mtext("PhosCaMKII", outer=TRUE)
## plot(NA, NA, xlab="", ylab="", xaxt="", yaxt="")

plot.ts(sims.a[["Active PP1"]], ylab="#", hue=0.5, main="5Hz/5sec")
mtext("Active PP1", line=2)
plot.ts(sims.b[["Active PP1"]], ylab="#", hue=0.5, main="5Hz/15sec")
plot.ts(sims.c[["Active PP1"]], ylab="#", hue=0.5, main="5Hz/1min")

## plot(NA, NA, xlab="", ylab="", xaxt="", yaxt="")
## mtext("ActivePP1", outer=TRUE)
