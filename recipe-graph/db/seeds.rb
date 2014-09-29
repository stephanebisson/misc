# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

return

guac = Recipe.create name: 'Guacamole', url: 'guac.com'
avocado = Ingredient.create name: 'avocado'
tomato = Ingredient.create name: 'tomato'
guac.recipe_ingredients.create ingredient: avocado, quantity: '1 big'
guac.recipe_ingredients.create ingredient: tomato, quantity: '2 small'
guac.save!
