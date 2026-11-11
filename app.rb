require 'debug'
require "awesome_print"

class App < Sinatra::Base
    register Sinatra::Reloader

    def db
      return @db if @db

      @db = SQLite3::Database.new(DB_PATH)
      @db.results_as_hash = true

      return @db
    end

    get '/todos' do     
        @todos = db.execute("SELECT * FROM todos")   
        ap @todos
        erb(:'todos/index')
    end

    get '/todos/:id' do |id|
        @todo = db.execute("SELECT * FROM todos WHERE id=?", id).first
        erb(:'todos/show')
    end

end
