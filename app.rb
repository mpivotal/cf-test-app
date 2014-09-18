require 'sinatra'
require 'mongo'
require 'json/ext'

include Mongo

class HelloWorldApp < Sinatra::Base

  configure :development do
    uri = ENV["MONGO_URI"]
    client = MongoClient.from_uri(uri)
    db = client.db(ENV["MONGO_DB"])
    set :mongo_connection, client
    set :mongo_db, db
    set :coll, "development"
  end

  collection = mongo_db.collection(coll)

  ['/', '/collections/?'].each do |path|
    get path do
      content_type :json
      collection.name.to_json
    end
  end

  get '/hello' do
    "Hello, world!"
  end
end
