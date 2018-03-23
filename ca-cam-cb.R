source("run.R")

## For version of 2017-03-24
options(kasim="./KaSim/KaSim-76a8b98")

## For version of 2018-03-09
options(kasim="./KaSim/KaSim")

sims <- run.kasims(c("volume4.ka", "agents4.ka", "ca4.ka", "cam4.ka", "cb4.ka"),
                   record=c("Ca"=1, "kCa"=1, "CaM"=1, "CaMCa4"=1, "CB"=1, "TotCa"=1),
                   l=5, p=0.001, n=1)

## Plot simulations
## png(file="stg-psd95.png", width=1000, height=800)
par(mfcol=c(5, 1),
    mar=c(2.4, 2.2, 3, 2),
    mgp=c(1.3, 0.4, 0),
    oma=c(0, 0, 0, 0))

plot.ts(sims[["Ca"]],     ylab="#", hue=0.5, xlim=c(0, 5), main="Free Ca", offset=0, time.units="s")
plot.ts(sims[["TotCa"]],     ylab="#", hue=0.5, xlim=c(0, 5), main="Total Ca", offset=0, time.units="s")
plot.ts(sims[["CaM"]],    ylab="#", hue=0.5, xlim=c(0, 5), main="Free CaM", offset=0, time.units="s")
plot.ts(sims[["CaMCa4"]], ylab="#", hue=0.5, xlim=c(0, 5), main="CaMCa4", offset=0, time.units="s")
plot.ts(sims[["CB"]],     ylab="#", hue=0.5, xlim=c(0, 5), main="CB", offset=0, time.units="s")

# plot((sims[["TotCa"]]/sims[["Ca"]])[,2], type='l', xlim=c(0, 1000), ylim=c(0,100))
