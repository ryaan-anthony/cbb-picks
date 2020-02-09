# CBB Picks

### Dependencies:

* Ruby 2.7
* Mongo 4.0

### Install the app:
```
bundle install
bundle exec rake webpacker:install
```

### Configure the app:
```
bundle exec rails credentials:edit
```

Example config:
```
sports_radar:
  api_key: xxxxxxx
  host: https://api.sportradar.us/
```

### Run the server:
```
bundle exec rails s
```

### View the app:
http://localhost:3000/

