source("run.R")

## For version of 2017-03-24
options(kasim="./KaSim/KaSim-76a8b98")

## For version of 2018-03-09
options(kasim="./KaSim/KaSim")

sims <- run.kasims(c("volume4.ka", "agents4.ka", "ca4.ka"), record=c("Ca"=1, "kCa"=1), l=1, p=0.001, n=1)

## Plot simulations
## png(file="stg-psd95.png", width=1000, height=800)
par(mar=c(2.4, 2.2, 1.5, 2),
    mgp=c(1.3, 0.4, 0),
    oma=c(0, 0, 2, 0))

plot.ts(sims[["Ca"]], ylab="#", hue=0.5, xlim=c(0, 1),  main="5Hz/5sec", offset=0, time.units="s")
mtext("Ca", line=2)
