bier.results.noopt <- bier127.results[bier127.results$opt == "noopt",]$aco
histogram <- hist(bier.results.noopt, 
  xlab="Cena", 
  ylab="Četnost",
  main="Bier127 bez optimalizace"
  )
rug(jitter(bier.results.noopt))
histogram.break <- histogram$breaks[2] - histogram$breaks[1]
