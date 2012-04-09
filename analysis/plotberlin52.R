### code chunk number 2: Rxsalba00.Rnw:252-272
###################################################
berlin52.aggr <- observations.aggr[observations.aggr$Instance == "berlin52",]

## Vykreslit bez optimalizace
plot(berlin52.aggr$aco[berlin52.aggr$Opt == "noopt"],
    type='l',
    xlab="Iterace",
    ylab="Průměrná cena cesty",
    ylim=c(berlin52.optimum - 300, max(berlin52.aggr$aco)),
    col=c("red"))

# vykreslit optimalizovanou
lines(berlin52.aggr$aco[berlin52.aggr$Opt == "twoopt"], col=c("blue"))

legend("topright",
    c("Bez optimalizace", "2-opt"),# "RandomSearch"),
    title="Legenda",
    inset = .02,
    fill=c("red", "blue"))#, "green"))

abline(h=berlin52.optimum, lty=2)


###################################################
