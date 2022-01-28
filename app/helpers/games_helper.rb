module GamesHelper
  def categories_collection
    [
      ["Main Game", Game.categories.keys[0]],
      ["Expansion", Game.categories.keys[1]]
    ]
  end
end
