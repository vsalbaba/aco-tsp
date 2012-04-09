### code chunk number 1: Rxsalba00.Rnw:57-93
###################################################
  library(xtable)
  library(reporttools)
  
  berlin52.optimum = 7542
  bier127.optimum = 118282
 
  berlin52.noopt.file =  '../logs/berlin52/noopt/berlin52-noopt.csv'
  berlin52.twoopt.file = '../logs/berlin52/twoopt/berlin52-twoopt.csv'


  bier127.noopt.file =  '../logs/bier127/noopt/bier127-noopt.csv'
  bier127.twoopt.file =  '../logs/bier127/twoopt/bier127-twoopt.csv'

  berlin52.noopt <- read.csv(berlin52.noopt.file)
  berlin52.noopt$instance = "berlin52"
  berlin52.noopt$opt = "noopt"
  
  berlin52.twoopt <- read.csv(berlin52.twoopt.file, col.names=c('iterace', 'aco', 'random'))
  berlin52.twoopt$instance = "berlin52"
  berlin52.twoopt$opt = "twoopt"
  
  bier127.noopt <- read.csv(bier127.noopt.file, col.names=c('iterace','aco','random'))
  bier127.noopt$instance = "bier127"
  bier127.noopt$opt = "noopt"
  
  bier127.twoopt <- read.csv(bier127.twoopt.file, col.names=c('iterace', 'aco', 'random'))
  bier127.twoopt$instance = "bier127"
  bier127.twoopt$opt = "twoopt"

  observations <- rbind(bier127.noopt, bier127.twoopt, berlin52.noopt, berlin52.twoopt)
  attach(observations)
  observations.aggr <- aggregate(observations[2:3], list(Iterace = iterace, Opt = opt, Instance = instance ),mean)
  
  berlin52.results = observations[iterace == 49 & instance == "berlin52",]

  bier127.results = observations[iterace == 49 & instance == "bier127",]

###################################################
