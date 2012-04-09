
def two_opt(candidate, cities)
  candidate[:cost] = cost(candidate[:vector], cities)
  best_cost = candidate[:cost]
  best_vector = candidate[:vector]
  solution = candidate[:vector]
  (0..(solution.size-1)).each do |first_split_point|
    (first_split_point..(solution.size-1)).each do |second_split_point|
      next if rand > 0.25 # x% sance ze bude otoceno. Zrychluje beh a do urcite miry nema vliv na vysledky
      #puts first_split_point, second_split_point
      head =  solution[0..first_split_point]
      body = solution[(first_split_point+1)..second_split_point]
      tail =   solution[(second_split_point+1)..-1]
      new_solution = [head, body.reverse, tail].flatten
      new_cost = cost(new_solution, cities)
      if new_cost < best_cost then
        best_vector = new_solution
        best_cost = new_cost
      end
    end
  end
  #puts "optimized #{candidate[:cost]} to #{best_cost}"

  {:vector => best_vector, :cost => best_cost} # optimized candidate
end

def no_opt candidate, cities
  candidate
end
