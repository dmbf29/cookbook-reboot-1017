require_relative 'view'
require_relative 'recipe'
require_relative 'scrape_bbc_service'

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
    rating = @view.ask_for('rating').to_f
    prep_time = @view.ask_for('prep time')
    # Create a new instance of Recipe
    recipe = Recipe.new(
      name: name,
      description: description,
      rating: rating,
      prep_time: prep_time
    )
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

  def import
    # tell the view to ask user for the keyword/ingredient
    keyword = @view.ask_for('keyword')
    # give the keyword to the scraper -> an array of recipes
    recipes = ScrapeBbcService.new(keyword).call
    # tell the view to display the recipes
    @view.display(recipes)
    # ask user which number (index) they want to import
    index = @view.ask_for_index
    # get a single recipe from the recipes
    recipe = recipes[index]
    # give that recipe to the cookbook
    @cookbook.add_recipe(recipe)
  end

  def mark_as_done
    display_recipes
    # ask user for index
    index = @view.ask_for_index
    # give the index to the cookbook
    @cookbook.mark_as_done(index)
  end

  private

  def display_recipes
    # Get all the recipes from the cookbook
    recipes = @cookbook.all
    # Ask the view to display the recipes
    @view.display(recipes)
  end
end
