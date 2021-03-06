library(dplyr)

source("kasim.R")
## For version of 2017-03-24
options(kasim="./KaSim/KaSim-76a8b98")
kafile <- "maguk.ka"

## For version of 2018-03-09
## options(kasim="./KaSim/KaSim")
## kafile <- "maguk4.ka"


read.carletal <- function(file="fig3a_wt.csv", dir="CarlEtal08oppo") {
  dat <- read.csv(file.path(dir, file), skip=1)
  dat$time <- dat$time*60
  return(dat)
}

plot.ts <- function(dat, ylim=NULL, add=FALSE, hue=1, alpha=0.5,
                    ylab="Strength (% Baseline)", xlim=NA, time.units="min",
                    offset=20, scale=1, ...) {
  if (is.null(ylim)) {
    ylim <- range(na.omit(select(dat, -time)))
  }
  Time <- dat$time
  if (time.units == "min") {
    message("Time uints are minutes")
    Time <- Time/60
  } else {
    if (time.units != "s") {
      stop("time.units must be min or s")
    }
  }
  Time <- Time - offset
  if (is.na(xlim[1])) {
    xlim <- range(Time)
  }
  if (!add) {
    plot(NA, NA, 
         xlim=xlim, ylim=ylim,
         xlab=paste0("Time (", time.units, ")"), ylab=ylab, ...)
    if (!is.null(attr(dat, "agconc"))) {
      ticklabs <- axisTicks(ylim*attr(dat, "agconc")*1000, log=FALSE)
      axis(4, at=ticklabs/attr(dat, "agconc")/1000, labels=ticklabs)
      mtext("uM", side=4, line=1, cex=0.66)
    }
  }
  n <- length(Time)
  polygon(c(Time, Time[n:1]),
          scale*c(apply(select(dat, -time), 1, max),
            apply(select(dat, -time), 1, min)[n:1]),
          col=hsv(hue, 0.5, 1, alpha), border=hsv(hue, 1, 1, alpha))
  lines(Time, scale*rowMeans(select(dat, -time), na.rm=TRUE), col=hsv(hue, 1, 0.5))
  #lines(, apply(select(dat, -time), 1, max), type='l', ylim=ylim)
  # lines(Time, apply(select(dat, -time), 1, min), type='l', ylim=ylim)
}

run.kasims <- function(files="maguk.ka", l=67*60, p=10, n=10,
                       record=c("stargazin-PSD95"=100/15, "Phos CaMKII"=1, "Active PP1"=1, "PP3-Ca"=1, "Phos stargazin"=1),
                       vars=c()) {
  kasim <- parallel::mclapply(1:n, function(x) {run.kasim(files=files, l=l, p=p, vars=vars,
                                                          flags="--gluttony")})

  i <- which.max(sapply(kasim, function(x) { length(x[,"[T]"])} ))
  Tvec <- kasim[[i]][,"[T]"]
  N <- length(Tvec)
  
  out <- list(kasim=kasim)
  if ("agconc" %in% names(kasim[[1]])) {
    out$agconc <- kasim[[1]][1,"agconc"]
  }
  for (r in names(record)) {
    if (!(r %in% colnames(kasim[[1]]))) {
      warning(paste(r, "was not recorded during simulations"))
    } else {
      out[[r]] <- data.frame(time=Tvec,
                             do.call(cbind,
                                     lapply(kasim,
                                            function(x) {
                                              return(c(x[,r], rep(NA, N - length(x[,r]))))
                                            }))*record[r])
    }
    if (!is.null(out$agconc)) {
      attr(out[[r]], "agconc") <- out$agconc
    }
  }
  return(out)
}
