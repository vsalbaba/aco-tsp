require './problem.rb'
require './export.rb'
require './optimizations.rb'
require 'logger'

OPTIMIZATION = ARGV[0] || 'noopt'
PROBLEM = ARGV[1] || 'berlin52'

@distances = {}
@costs = {}
@two_point_gains = {}
def euclidean_distance(c1, c2)
  @distances[[c1, c2]] ||= Math.sqrt((c1[0] - c2[0])**2.0 + (c1[1] - c2[1])**2.0).round
end

def cost(permutation, cities)
  distance = 0
  permutation.each_with_index do |c1, i|
    c2 = (i==permutation.size-1) ? permutation[0] : permutation[i+1]
    distance += euclidean_distance(cities[c1], cities[c2])
  end
  distance
end

# Vrati nahodnou permutaci problemu. Tim muze mravenec zacinat na indexu nula a nahodne probehnout
def random_permutation(cities)
  perm = Array.new(cities.size){|i| i}
  perm.each_index do |i|
    r = rand(perm.size-i) + i
    perm[r], perm[i] = perm[i], perm[r] #swap
  end
  return perm
end

#vytvori dvourozmerne pole feromonu
def initialise_pheromone_matrix(num_cities, solution_score)
  pheromone_value = num_cities.to_f / solution_score
  return Array.new(num_cities){|i| Array.new(num_cities, pheromone_value)}
end

def calculate_choices(cities, last_city, partial_solution, pheromone, c_heur, c_hist)
  choices = []
  cities.each_with_index do |coord, i|
    next if partial_solution.include?(i)
    prob = {:city=>i}
    prob[:history] = pheromone[last_city][i] ** c_hist
    prob[:distance] = euclidean_distance(cities[last_city], coord)
    prob[:heuristic] = (1.0/prob[:distance]) ** c_heur
    prob[:prob] = prob[:history] * prob[:heuristic]
    choices << prob
  end
  choices
end

def select_next_city(choices)
  sum = choices.inject(0.0){|sum,element| sum + element[:prob]}
  return choices[rand(choices.size)][:city] if sum == 0.0
  v = rand()
  choices.each_with_index do |choice, i|
    v -= (choice[:prob]/sum)
    return choice[:city] if v <= 0.0
  end
  return choices.last[:city]
end

def stepwise_const(cities, phero, c_heur, c_hist)
  partial_solution = []
  partial_solution << rand(cities.size) #zacatek v nahodnem meste
  begin
    choices = calculate_choices(cities,partial_solution.last,partial_solution,phero,c_heur,c_hist)
    next_city = select_next_city(choices)
    partial_solution << next_city
  end until partial_solution.size == cities.size
  return partial_solution
end

def decay_pheromone(pheromone, decay_factor)
  decay = 1.0 - decay_factor
  pheromone.each do |array|
    array.each_with_index do |pheromone_value, i|
      array[i] = decay * pheromone_value
    end
  end
end

def update_pheromone(pheromone, solutions)
  solutions.each do |other|
    pheromone_update = (1.0 / other[:cost])
    other[:vector].each_with_index do |x, i|
      y=(i==other[:vector].size-1) ? other[:vector][0] : other[:vector][i+1]
      pheromone[x][y] += pheromone_update
      pheromone[y][x] += pheromone_update
    end
  end
end

def optimize(candidate, cities)
  case OPTIMIZATION
  when 'twoopt'
    two_opt candidate, cities
  when 'noopt'
    no_opt candidate, cities
  end
end

def search(cities, max_iterations, num_ants, decay_factor, c_heur, c_hist)
  best = {:vector=>random_permutation(cities)}
  best_random = best
  best_random[:cost] = best[:cost] = cost(best[:vector], cities)
  pheromone = initialise_pheromone_matrix(cities.size, best[:cost])
  max_iterations.times do |iter|
    solutions = []
    num_ants.times do

      new_random = {:vector => random_permutation(cities)}
      new_random[:cost] = cost(new_random[:vector], cities)
      best_random = new_random if new_random[:cost] < best_random[:cost]

      candidate = {}
      candidate[:vector] = stepwise_const(cities, pheromone, c_heur, c_hist)
      optimize(candidate, cities)
      candidate[:cost] ||= cost(candidate[:vector], cities)
      best = candidate if candidate[:cost] < best[:cost]
      solutions << candidate
    end
    decay_pheromone(pheromone, decay_factor)
    update_pheromone(pheromone, solutions)
    @log << "#{iter},#{best[:cost]},#{best_random[:cost]}\n"
    puts " > iteration #{(iter+1)}, best=#{best[:cost]}, random=#{best_random[:cost]}"
  end
  return {:as => best, :random => best_random}
end

if __FILE__ == $0
  # problem configuration
  berlin52 = Problem.send PROBLEM
  # algorithm configuration
  max_iterations = 50
  num_ants = 30
  decay_factor = 0.6
  c_heur = 2.5
  c_hist = 1.0
  # execute the algorithm
  puts "Solving #{PROBLEM} using #{OPTIMIZATION} optimization, random as reference (same #no of solutions)"
  @log = Logger.new("logs/#{PROBLEM}/" + PROBLEM + "-" + OPTIMIZATION + "-" + Time.now.to_s)
  best = search(berlin52, max_iterations, num_ants, decay_factor, c_heur, c_hist)
  puts "Done. Best Solution: aco=#{best[:as][:cost]}, random=#{best[:random][:cost]}"
  export best
end
