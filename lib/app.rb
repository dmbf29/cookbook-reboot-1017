require_relative 'cookbook'    # You need to create this file!
require_relative 'controller'  # You need to create this file!
require_relative 'router'

csv_file   = File.join(__dir__, 'recipes.csv')
cookbook   = Cookbook.new(csv_file)
controller = Controller.new(cookbook)

router = Router.new(controller)

# Start the app
router.run


# https://www.airbnb.com/homes
# homes controller -> #list
# load all the homes from the DB
# give them to the view

# https://www.airbnb.com/homes/39046984
# homes controller -> #show
# load the single home from the DB using the ID
# give that home to the view


# https://www.airbnb.com/users/1230981209381
# users controller -> #show
# load the user with the ID
# display
