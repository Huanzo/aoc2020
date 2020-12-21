$allergens = {}
$count_map = {}

input = File.readlines('./input').map do |line|
  ingredients = line.match(/\A(.*)\(/).captures
  ingredients = ingredients.first.split.compact

  allergenes = line.match(/\(contains (.*)\)/)&.captures
  allergenes = allergenes&.first&.split(', ') || []

  allergenes.each do |allergen|
    $allergens[allergen] = if $allergens.key?(allergen)
                             $allergens[allergen] & ingredients
                           else
                             ingredients
                           end.uniq
  end

  ingredients.each do |ingre|
    $count_map[ingre] = 0 unless $count_map[ingre]
    $count_map[ingre] += 1
  end
end

$allergens.each do |_, ingredients|
  ingredients.each do |ingredient|
    $count_map.delete ingredient
  end
end

puts $count_map.values.sum

# Part 2

$dangerous = []

until $allergens.empty?
  $allergens.each do |allergen, ingredients|
    if ingredients.size == 1
      $dangerous.push([allergen, ingredients.first])
      $allergens.delete allergen
    end
  end

  $allergens.values.each do |ingredients|
    $dangerous.map(&:last).each do |ingredient|
      ingredients.delete ingredient
    end
  end
end

puts $dangerous.sort.map(&:last).join ','
