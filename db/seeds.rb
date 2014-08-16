require 'csv'

# Seeding users

manager = User.create(username: 'kylerm42', first_name: 'Kyle', last_name: 'Moore',
            email: 'kylerm42@gmail.com', password: 'suns32')
user = User.create(username: 'user1', first_name: 'John', last_name: 'Doe',
            email: 'user1@gmail.com', password: '123456')

# Seeding leagues

league = manager.managed_leagues.create(name: 'Awesome League', password: '123456',
                               tagline: 'Yeah, this league is pretty cool...')

#Setting team owners

Team.find(2).update_attributes(owner: user)

# Seeding players

lines = CSV.open('lib/2013.csv', headers: true)

lines.each do |line|
  player = Player.new(first_name: line['name'].split('.').first,
                      last_name: line['name'].split('.').last)

  Player.attribute_names.each do |attr|
    next unless line[attr]
    player[attr] = line[attr]
  end

  player.save
end

players_info_json = JSON.parse(File.read('lib/players.json'))

Player.all.each do |player|
  next unless player.gsis_id && player_info = players_info_json[player.gsis_id]

  player.update_attributes(
    first_name: player_info['first_name'],
    last_name:  player_info['last_name'],
    college:    player_info['college'],
    birthdate:  Date.strptime(player_info['birthdate'], '%m/%d/%Y'),
    college:    player_info['college'],
    profile_id: player_info['profile_id'],
    height:     %Q[#{player_info['height'] / 12}' #{player_info['height'] % 12}"],
    weight:     player_info['weight'],
    years_pro:  player_info['years_pro']
  )
end