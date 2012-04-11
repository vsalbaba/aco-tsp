berlin.results.twoopt <- berlin52.results[berlin52.results$opt == "twoopt",]$aco
histogram <- hist(berlin.results.twoopt, 
  xlab="Cena", 
  ylab="Četnost",
  main="Berlin52 s optimalizací twoopt",
  breaks = 8
  ) 
rug(jitter(berlin.results.twoopt))
histogram.break <- histogram$breaks[2] - histogram$breaks[1]
