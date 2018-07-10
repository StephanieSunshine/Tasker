# Tasker
## Requirements
- Ruby
- Postgresql
- Redis

## Recomendations

### Postgresql
Postgres needs a DATABASE_URL envrionmental variable set when doing development.  Don't forget to create the database before starting the application.

### Redis
Redis needs either a REDIS_URL environmental variable or a Redis server running on localhost with the default port.

## Quickstart
```bash
git clone git@github.com:StephanieSunshine/Tasker.git && cd Tasker
bin/bundle install --path vendor/bundle
DATABASE_URL="postgres://postgres:postgres@localhost/tasker" bin/rails db:migrate
DATABASE_URL="postgres://postgres:postgres@localhost/tasker" bin/rails s
```

## Production
If one were to use this in production I would suggest using Heroku as your provider

## Example
Demo Tasker at: https://sunshine-tasker-demo.herokuapp.com/

## License
MIT License

Copyright (c) 2018 Stephanie Sunshine

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

