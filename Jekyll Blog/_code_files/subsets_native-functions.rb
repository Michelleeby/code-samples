def subsets(set)
  # Initialize accumulator with empty set.
  acc = [ [] ]
  # Push remaining combinations into accumulator
  set.each_index{ |i| set.combination(i + 1){ 
    |combination| acc.push(combination) } }
  return acc
end