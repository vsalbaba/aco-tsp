### code chunk number 5: Rxsalba00.Rnw:316-320
###################################################
  cap = 'Statistické parametry výsledků běhu algoritmů na instanci bier127'
  stats = list("n", "min", "mean", "s", "iqr", "optimum \\%"=function(x){return(min(x)*100/bier127.optimum)})

  tableContinuous(vars = bier127.results, longtable=FALSE, cap = cap, stats = stats, )


