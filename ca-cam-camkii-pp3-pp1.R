source("run.R")

## For version of 2017-03-24
options(kasim="./KaSim/KaSim-76a8b98")

## For version of 2018-03-09
options(kasim="./KaSim/KaSim")

tstop <- 200
dt <- 0.002
sims.a <- run.kasims(c("volume4.ka", "agents4.ka", "ca4.ka", "cam4.ka", "cb4.ka", "camkii4.ka", "pp34.ka", "pp1-camkii4.ka"),
                     record=c("Ca"=1, "kCa"=1, "CaM"=1, "CaMCa4"=1, "CB"=1, "TotCa"=1, "CaMKIIp"=1,
                              "CaMKIIhexp"=1, "CaPP3"=1, "PP1"=1, "CaMKIICaM"=1,
                              "CaMKIICaMCa4"=1),
                     l=tstop, p=dt, n=6, var=c(npulse=15))

sims.b <- run.kasims(c("volume4.ka", "agents4.ka", "ca4.ka", "cam4.ka", "cb4.ka", "camkii4.ka", "pp34.ka", "pp1-camkii4.ka"),
                     record=c("Ca"=1, "kCa"=1, "CaM"=1, "CaMCa4"=1, "CB"=1, "TotCa"=1, "CaMKIIp"=1,
                              "CaMKIIhexp"=1, "CaPP3"=1, "PP1"=1, "CaMKIICaM"=1,
                              "CaMKIICaMCa4"=1),
                     l=tstop, p=dt, n=6, var=c(npulse=75))

sims.c <- run.kasims(c("volume4.ka", "agents4.ka", "ca4.ka", "cam4.ka", "cb4.ka", "camkii4.ka", "pp34.ka", "pp1-camkii4.ka"),
                     record=c("Ca"=1, "kCa"=1, "CaM"=1, "CaMCa4"=1, "CB"=1, "TotCa"=1, "CaMKIIp"=1,
                              "CaMKIIhexp"=1, "CaPP3"=1, "PP1"=1, "CaMKIICaM"=1,
                              "CaMKIICaMCa4"=1),
                     l=tstop, p=dt, n=6, var=c(npulse=300))


## Plot simulations
## png(file="stg-psd95.png", width=1000, height=800)
par(mfcol=c(8, 3),
    mar=c(2.2, 1.8, 2, 2),
    mgp=c(1.3, 0.4, 0),
    oma=c(0, 0, 0, 0))

plot.ts(sims.a[["Ca"]],     ylab="#", hue=0.5, xlim=c(0, tstop), main="Free Ca", offset=0, time.units="s")
plot.ts(sims.a[["TotCa"]],  ylab="#", hue=0.5, xlim=c(0, tstop), main="Total Ca", offset=0, time.units="s")
plot.ts(sims.a[["CaM"]],    ylab="#", hue=0.5, xlim=c(0, tstop), main="Free CaM", offset=0, time.units="s")
plot.ts(sims.a[["CaMCa4"]], ylab="#", hue=0.5, xlim=c(0, tstop), main="CaMCa4", offset=0, time.units="s")
                                        # plot.ts(sims.a[["CB"]],     ylab="#", hue=0.5, xlim=c(0, tstop), main="CB", offset=0, time.units="s")
CaMKIIplim <- c(0, 360)
plot.ts(sims.a[["CaMKIIp"]],ylab="#", hue=0.5, xlim=c(0, tstop), ylim=CaMKIIplim, main="CaMKIIp", offset=0, time.units="s")
CaMKIIhexplim <- c(0, 60)
plot.ts(sims.a[["CaMKIIhexp"]],ylab="#", hue=0.5, xlim=c(0, tstop), ylim=CaMKIIhexplim, main="CaMKIIhexp", offset=0, time.units="s")
CaPP3lim <- c(0, 150)
plot.ts(sims.a[["CaPP3"]],ylab="#", hue=0.5, xlim=c(0, tstop), ylim=CaPP3lim, main="CaPP3", offset=0, time.units="s")
CaPP1lim <- c(0, 30)
plot.ts(sims.a[["PP1"]],ylab="#", hue=0.5, xlim=c(0, tstop), ylim=CaPP1lim, main="PP1", offset=0, time.units="s")
# plot((sims.a[["TotCa"]]/sims[["Ca"]])[,2], type='l', xlim=c(0, 1000), ylim=c(0,100))

plot.ts(sims.b[["Ca"]],     ylab="#", hue=0.5, xlim=c(0, tstop), main="Free Ca", offset=0, time.units="s")
plot.ts(sims.b[["TotCa"]],  ylab="#", hue=0.5, xlim=c(0, tstop), main="Total Ca", offset=0, time.units="s")
plot.ts(sims.b[["CaM"]],    ylab="#", hue=0.5, xlim=c(0, tstop), main="Free CaM", offset=0, time.units="s")
plot.ts(sims.b[["CaMCa4"]], ylab="#", hue=0.5, xlim=c(0, tstop), main="CaMCa4", offset=0, time.units="s")
# plot.ts(sims.b[["CB"]],     ylab="#", hue=0.5, xlim=c(0, tstop), main="CB", offset=0, time.units="s")
plot.ts(sims.b[["CaMKIIp"]],ylab="#", hue=0.5, xlim=c(0, tstop), ylim=CaMKIIplim, main="CaMKIIp", offset=0, time.units="s")
plot.ts(sims.b[["CaMKIIhexp"]],ylab="#", hue=0.5, xlim=c(0, tstop), ylim=CaMKIIhexplim, main="CaMKIIhexp", offset=0, time.units="s")
plot.ts(sims.b[["CaPP3"]],ylab="#", hue=0.5, xlim=c(0, tstop), ylim=CaPP3lim, main="CaPP3", offset=0, time.units="s")
plot.ts(sims.b[["PP1"]],ylab="#", hue=0.5, xlim=c(0, tstop), ylim=CaPP1lim, main="PP1", offset=0, time.units="s")
# plot((sims.b[["TotCa"]]/sims[["Ca"]])[,2], type='l', xlim=c(0, 1000), ylim=c(0,100))

plot.ts(sims.c[["Ca"]],     ylab="#", hue=0.5, xlim=c(0, tstop), main="Free Ca", offset=0, time.units="s")
plot.ts(sims.c[["TotCa"]],  ylab="#", hue=0.5, xlim=c(0, tstop), main="Total Ca", offset=0, time.units="s")
plot.ts(sims.c[["CaM"]],    ylab="#", hue=0.5, xlim=c(0, tstop), main="Free CaM", offset=0, time.units="s")
plot.ts(sims.c[["CaMCa4"]], ylab="#", hue=0.5, xlim=c(0, tstop), main="CaMCa4", offset=0, time.units="s")
# plot.ts(sims.c[["CB"]],     ylab="#", hue=0.5, xlim=c(0, tstop), main="CB", offset=0, time.units="s")
plot.ts(sims.c[["CaMKIIp"]],ylab="#", hue=0.5, xlim=c(0, tstop), ylim=CaMKIIplim, main="CaMKIIp", offset=0, time.units="s")
plot.ts(sims.c[["CaMKIIhexp"]],ylab="#", hue=0.5, xlim=c(0, tstop), ylim=CaMKIIhexplim, main="CaMKIIhexp", offset=0, time.units="s")
plot.ts(sims.c[["CaPP3"]],ylab="#", hue=0.5, xlim=c(0, tstop), ylim=CaPP3lim, main="CaPP3", offset=0, time.units="s")
plot.ts(sims.c[["PP1"]],ylab="#", hue=0.5, xlim=c(0, tstop), ylim=CaPP1lim, main="PP1", offset=0, time.units="s")
# plot((sims.c[["TotCa"]]/sims[["Ca"]])[,2], type='l', xlim=c(0, 1000), ylim=c(0,100))
