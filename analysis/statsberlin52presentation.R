### code chunk number 4: Rxsalba00.Rnw:309-313
###################################################
  cap = 'Statistické parametry výsledků běhu algoritmů na instanci berlin52'
  stats = list("n", "min", "mean", "s", "iqr",  "optimum \\%"=function(x){return(min(x)*100/berlin52.optimum)})

  tableContinuous(vars = berlin52.results, longtable=FALSE, cap = cap, stats = stats, )


###################################################
