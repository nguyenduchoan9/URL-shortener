# URL Shortener

### Prerequisites

Ruby 2.7.2

### Install

```ruby
bundle
```

### Start server

```ruby
bin/rails s
```

### API endpoint

#### Encode

```bash
curl --location 'http://localhost:3000/api/urls/encode' \
--header 'Content-Type: application/json' \
--data '{
    "url": "your-url"
}'
```

#### Decode

```bash
curl --location 'http://localhost:3000/api/urls/decode' \
--header 'Content-Type: application/json' \
--data '{
    "url": "your-shorten-url"
}'
```

### How Do I solve the collision problem

#### Implementation
I generate the unique ID. Then I convert the ID to shortURL with base62

#### How do I generate the unique ID
I choose gem **druuid** for generating unique ID. The gem inspired by [Twitter Snowflake](https://en.wikipedia.org/wiki/Snowflake_ID). This technique also help to generate uniq ID in distributed system 