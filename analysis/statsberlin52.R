### code chunk number 4: Rxsalba00.Rnw:309-313
###################################################
  cap = 'Statistické parametry výsledků běhu algoritmů na instanci berlin52'
  stats = list("n", "min", "max", "mean", "median", "s", "iqr",  "optimum"=function(x){return(min(x)/berlin52.optimum)})
  tableContinuous(vars = list(berlin52.results$aco[berlin52.results$opt == "noopt"],
     berlin52.results$aco[berlin52.results$opt == "twoopt"],
     berlin52.results$random[berlin52.results$opt == "twoopt" || berlin52.results$opt == "noopt"]
     ),
  prec=3, 
  stats = stats,
  nams=c("Bez optimalizace", "Two-opt", "Random"),
  cap = cap,
  lab = "tab:berlin")


###################################################
