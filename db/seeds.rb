# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup)

I18n.reload!

def critics_for(criticable, users)
  rand(3..7).times do
    puts "Creating critic for #{criticable.name}"
    user = users.sample
    critic = criticable.critics.new(
      title: Faker::Lorem.sentence,
      body: Faker::Quote.famous_last_words,
      user_id: user.id,
      approved: user.admin? ? true : false
    )
    puts "Critic not created. Errors: #{critic.errors.full_messages}" unless critic.save
  end
end

require "json"

companies_data = JSON.parse(File.read("db/data/companies.json"))
games_data = JSON.parse(File.read("db/data/games.json"))
genres_data = JSON.parse(File.read("db/data/genres.json"))
platforms_data = JSON.parse(File.read("db/data/platforms.json"))

puts "Start Seedind"

Company.destroy_all
Platform.destroy_all
Genre.destroy_all
Game.destroy_all
User.destroy_all


puts "Seeding Users"

puts "Creating admin"
admin = User.new(
  username: "admin",
  email: "admin@test.com",
  password: "letmein",
  role: "admin"
)

puts "User not created. Errors: #{admin.errors.full_messages}" unless admin.save

usernames = %w[ximena claudia tommy ricardo]
usernames.each do |username|
  puts "Creating user for #{username}"
  user = User.new(
    username: username,
    email: "#{username}@test.com",
    password: "letmein"
  )

  puts "User not created. Errors: #{user.errors.full_messages}" unless user.save
end

users = User.all

puts "Seeding companies"
companies_data.first(10).each do |company_data|
  puts "Creating company #{company_data["name"]}"
  new_company = Company.new(company_data)
  new_company.cover.attach(
    io: URI.open(Faker::LoremFlickr.image(size: "400x400", search_terms: company_data["name"].split.first(2))),
    filename: "#{company_data["name"].downcase.split.join("_")}.jpeg"
  )
  puts "Company not created. Errors: #{new_company.errors.full_messages}" unless new_company.save

  critics_for(new_company, users) if new_company.persisted?
end

puts "Seeding platforms"
platforms_data.each do |platform_data|
  puts "Creating platform #{platform_data["name"]}"
  new_platform = Platform.new(platform_data)
  puts "Platform not created. Errors: #{new_platform.errors.full_messages}" unless new_platform.save
end

puts "Seeding genres"
genres_data.each do |name|
  puts "Creating genre #{name}"
  new_genre = Genre.new(name: name)
  puts "Genre not created. Errors: #{new_genre.errors.full_messages}" unless new_genre.save
end

puts "Seeding main games and relationships"

main_games_data = games_data.select {|game| game["parent"].nil? }

main_games_data.first(5).each do |game|
  puts "Creating main game #{game["name"]}"
  game_data = game.slice("name", "summary", "release_date", "category", "rating")
  new_game = Game.new(game_data)
  new_game.cover.attach(
    io: URI.open(Faker::LoremFlickr.image(size: "400x400", search_terms: game["name"].split.first(2))),
    filename: "#{game["name"].downcase.split.join("_")}.jpeg"
  )
  puts "Game not created. Errors: #{new_game.errors.full_messages}" unless new_game.save

  critics_for(new_game, users) if new_game.persisted?

  game["genres"].each do |genre_name|
    puts "Creating genre relation"
    new_game.genres << Genre.find_by(name: genre_name)
  end

  game["platforms"].each do |platform|
    puts "Creating platform relation"
    new_game.platforms << Platform.find_by(name: platform["name"])
  end

  game["involved_companies"].each do |involved_company_data|
    puts "Creating involved company relation"
    company = Company.find_by(name: involved_company_data["name"])

    new_involved_company = InvolvedCompany.new( game: new_game,
                                                company: company,
                                                publisher: involved_company_data["publisher"], 
                                                developer: involved_company_data["developer"]
                                              )
    puts "Involved Company not created. Errors: #{new_involved_company.errors.full_messages}" unless new_involved_company.save
  end
end

puts "Seeding expansion games and relationships"
expansions_games_data = games_data.select {|game| !game["parent"].nil? }

expansions_games_data.first(5).each do |game|
  puts "Creating expansion game #{game["name"]}"
  parent_game = Game.find_by(name: game["parent"])

  game_data = game.slice("name", "summary", "release_date", "category", "rating")
  new_game = Game.new(game_data)
  new_game.parent = parent_game
  new_game.cover.attach(
    io: URI.open(Faker::LoremFlickr.image(size: "400x400", search_terms: game["name"].split.first(2))),
    filename: "#{game["name"].downcase.split.join("_")}.jpeg"
  )
  puts "Game not created. Errors: #{new_game.errors.full_messages}" unless new_game.save

  critics_for(new_game, users) if new_game.persisted?

  game["genres"].each do |genre_name|
    puts "Creating genre relation"
    new_game.genres << Genre.find_by(name: genre_name)
  end

  game["platforms"].each do |platform|
    puts "Creating platform relation"
    new_game.platforms << Platform.find_by(name: platform["name"])
  end

  game["involved_companies"].each do |involved_company_data|
    puts "Creating involved company relation"
    company = Company.find_by(name: involved_company_data["name"])

    new_involved_company = InvolvedCompany.new( game: new_game,
                                                company: company,
                                                publisher: involved_company_data["publisher"], 
                                                developer: involved_company_data["developer"]
                                              )
    puts "Involved Company not created. Errors: #{new_involved_company.errors.full_messages}" unless new_involved_company.save
  end
end
