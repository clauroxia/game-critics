module GamesHelper
  def categories_collection
    Game.categories.keys.map do |e|
      e.split("_").join(" ").titleize
    end
  end
end
