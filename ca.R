source("run.R")

## For version of 2017-03-24
options(kasim="./KaSim/KaSim-76a8b98")
kafile <- "maguk-v2.ka"

## For version of 2018-03-09
## options(kasim="./KaSim/KaSim")
## kafile <- "maguk4.ka"

sims <- run.kasims(c("volume.ka", "ca.ka"), record=c("Ca"=1), l=0.4, p=0.001)

## Plot simulations
## png(file="stg-psd95.png", width=1000, height=800)
par(mar=c(2.4, 2.2, 1.5, 2),
    mgp=c(1.3, 0.4, 0),
    oma=c(0, 0, 2, 0))

plot.ts(sims[["Ca"]], ylab="#", hue=0.5, xlim=c(0, 0.4),  main="5Hz/5sec", offset=0, time.units="s")
mtext("Ca", line=2)
