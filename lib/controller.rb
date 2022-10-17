require_relative 'view'
require_relative 'recipe'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    display_recipes
  end

  def create
    # Get the name and description of the recipe from the user (View)
    name = @view.ask_for('name')
    description = @view.ask_for('description')
    # Create a new instance of Recipe
    recipe = Recipe.new(name, description)
    # Put the recipe in the cookbook
    @cookbook.add_recipe(recipe)
  end

  def destroy
    # Display list
    display_recipes
    # Ask the user (view) for the index of the recipe to destroy
    index = @view.ask_for_index
    # Ask the cookbook to remove the recipe
    @cookbook.remove_recipe(index)
  end

  private

  def display_recipes
    # Get all the recipes from the cookbook
    recipes = @cookbook.all
    # Ask the view to display the recipes
    @view.display(recipes)
  end
end