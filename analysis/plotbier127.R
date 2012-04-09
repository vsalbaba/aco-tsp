### code chunk number 3: Rxsalba00.Rnw:282-302
###################################################
bier127.aggr <- observations.aggr[observations.aggr$Instance == "bier127",]

plot(bier127.aggr$aco[bier127.aggr$Opt == "noopt"],
    type='l',
    xlab="Iterace",
    ylab="Průměrná cena cesty",
    ylim=c(bier127.optimum - 300, max(bier127.aggr$aco)),
    col=c("red"))

# vykreslit optimalizovanou
lines(bier127.aggr$aco[bier127.aggr$Opt == "twoopt"], col=c("blue"))

legend("topright",
    c("Bez optimalizace", "2-opt"),# "RandomSearch"),
    title="Legenda",
    inset = .02,
    fill=c("red", "blue"))#, "green"))

abline(h=bier127.optimum, lty=2)
###################################################
