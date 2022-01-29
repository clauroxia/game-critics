module GamesHelper
<<<<<<< HEAD
  def show_errors(record, attribute)
    errors = record.errors.full_messages_for(attribute).map do |message|
      content_tag(:span, message, class: "input__error-message")
    end

    safe_join(errors)
=======
  def categories_collection
    [
      ["Main Game", Game.categories.keys[0]],
      ["Expansion", Game.categories.keys[1]]
    ]
>>>>>>> main
  end
end
