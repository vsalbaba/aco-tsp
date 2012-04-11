### code chunk number 5: Rxsalba00.Rnw:316-320
###################################################
  cap = 'Statistické parametry výsledků běhu algoritmů na instanci bier127'
  stats = list("n", "min", "max", "median", "s", "optimum"=function(x){return(min(x)/bier127.optimum)})

  tableContinuous(vars = list(bier127.results$aco[bier127.results$opt == "noopt"],
     bier127.results$aco[bier127.results$opt == "twoopt"],
     bier127.results$random[bier127.results$opt == "twoopt" || bier127.results$opt == "noopt"]
     ),
    prec=3,
    stats = stats,
    longtable=FALSE,
    nams=c("Bez optimalizace", "Two-opt", "Random"),
    lab= "tab:bier",
    cap = cap)
