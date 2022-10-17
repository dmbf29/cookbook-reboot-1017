class View
  def display(recipes) # array of instances
    recipes.each_with_index do |recipe, index|
      x_mark = recipe.done? ? "X" : " "
      puts "#{index + 1}. [#{x_mark}] #{recipe.name} - #{recipe.description} - Rating: #{recipe.rating} - Prep: #{recipe.prep_time}"
    end
  end

  def ask_for(thing)
    puts "What is the #{thing} of the recipe?"
    print '> '
    gets.chomp
  end

  def ask_for_index
    puts "Which recipe?"
    print '> '
    gets.chomp.to_i - 1
  end
end
