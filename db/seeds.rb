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

