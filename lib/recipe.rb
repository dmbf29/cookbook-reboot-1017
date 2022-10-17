class Recipe
  attr_reader :name, :description, :rating, :prep_time

  def initialize(attributes = {})
    @name = attributes[:name]
    @description = attributes[:description]
    @rating = attributes[:rating]
    @prep_time = attributes[:prep_time]
    @done = attributes[:done] || false
  end

  def done?
    @done
  end

  def mark_as_done!
    @done = !@done
  end
end


# p Recipe.new.done?
# recipe =  Recipe.new(done: true).done?
# recipe.done = true
# Recipe.new('pizza', 'dough with sauce', 5, '15 min')
# p Recipe.new(
#   name: 'pizza',
#   description: 'dough with sauce',
#   rating: 7
# )
