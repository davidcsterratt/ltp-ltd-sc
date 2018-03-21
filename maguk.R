source("run.R")

## For version of 2017-03-24
options(kasim="./KaSim/KaSim-76a8b98")
kafile <- "maguk.ka"

## For version of 2018-03-09
## options(kasim="./KaSim/KaSim")
## kafile <- "maguk4.ka"

sims.a <- run.kasims(c("par-a.ka", kafile), l=67*60, p=1)
sims.b <- run.kasims(c("par-b.ka", kafile), l=67*60, p=1)
sims.c <- run.kasims(c("par-c.ka", kafile), l=67*60, p=1)


## Plot simulations
## png(file="stg-psd95.png", width=1000, height=800)
par(mfcol=c(3, 5),
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
plot.ts(sims.a[["Phos CaMKII"]], ylab="#", xlim=c(0, 3), ylim=c(0, 1000), hue=0.5, main="5Hz/5sec")
mtext("Phos CaMKII", line=2)
plot.ts(sims.b[["Phos CaMKII"]], ylab="#", xlim=c(0, 3), ylim=c(0, 1000), hue=0.5, main="5Hz/15sec")
plot.ts(sims.c[["Phos CaMKII"]], ylab="#", xlim=c(0, 3), ylim=c(0, 1000), hue=0.5, main="5Hz/1min")
                                        ## mtext("PhosCaMKII", outer=TRUE)
## plot(NA, NA, xlab="", ylab="", xaxt="", yaxt="")

plot.ts(sims.a[["Active PP1"]], ylab="#", xlim=c(0, 3), ylim=c(0, 100), hue=0.5, main="5Hz/5sec")
mtext("Active PP1", line=2)
plot.ts(sims.b[["Active PP1"]], ylab="#", xlim=c(0, 3), ylim=c(0, 100), hue=0.5, main="5Hz/15sec")
plot.ts(sims.c[["Active PP1"]], ylab="#", xlim=c(0, 3), ylim=c(0, 100), hue=0.5, main="5Hz/1min")

plot.ts(sims.a[["PP3-Ca"]], ylab="#", hue=0.5, xlim=c(0, 3), ylim=c(0, 20), main="5Hz/5sec")
mtext("PP3-Ca", line=2)
plot.ts(sims.b[["PP3-Ca"]], ylab="#", hue=0.5, xlim=c(0, 3), ylim=c(0, 20), main="5Hz/15sec")
plot.ts(sims.c[["PP3-Ca"]], ylab="#", hue=0.5, xlim=c(0, 3), ylim=c(0, 20), main="5Hz/1min")

plot.ts(sims.a[["Phos stargazin"]], ylab="#", hue=0.5, ylim=c(0, 20), main="5Hz/5sec")
mtext("Phos stargazin", line=2)
plot.ts(sims.b[["Phos stargazin"]], ylab="#", hue=0.5, ylim=c(0, 20), main="5Hz/15sec")
plot.ts(sims.c[["Phos stargazin"]], ylab="#", hue=0.5, ylim=c(0, 20), main="5Hz/1min")


## plot(NA, NA, xlab="", ylab="", xaxt="", yaxt="")
## mtext("ActivePP1", outer=TRUE)
