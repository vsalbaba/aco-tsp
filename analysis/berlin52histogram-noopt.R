berlin.results.noopt <- berlin52.results[berlin52.results$opt == "noopt",]$aco
histogram <- hist(berlin.results.noopt, 
  xlab="Cena", 
  ylab="Četnost",
  main="Berlin52 bez optimalizace",
  breaks = 7
  )
rug(jitter(berlin.results.noopt))
histogram.break <- histogram$breaks[2] - histogram$breaks[1]
