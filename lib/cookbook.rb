require 'csv'

class Cookbook
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @recipes = [] # array of instances of Recipe
    load_csv
  end

  def all
    @recipes
  end

  def add_recipe(recipe) # `recipe` is an instance of Recipe
    @recipes << recipe
    save_csv
  end

  def remove_recipe(index)
    @recipes.delete_at(index)
    save_csv
  end

  def mark_as_done(index)
    recipe = @recipes[index]
    recipe.mark_as_done!
    save_csv
  end

  private

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |attributes|
      # p attributes come as a hash
      attributes[:done] = attributes[:done] == 'true'
      # before we give attributes to the Recipe, we need to convert data types
      @recipes << Recipe.new(attributes)
      # @recipes << Recipe.new(row[0], row[1])

    end
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << ['name', 'description', 'rating', 'done', 'prep_time']
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.rating, recipe.done?, recipe.prep_time]
      end
    end
  end
end
