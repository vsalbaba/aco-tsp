bier.results.twoopt <- bier127.results[bier127.results$opt == "twoopt",]$aco
histogram <- hist(bier.results.twoopt, 
  xlab="Cena", 
  ylab="Četnost",
  main="Bier127 s optimalizací twoopt"
  ) 
rug(jitter(bier.results.twoopt))
histogram.break <- histogram$breaks[2] - histogram$breaks[1]
