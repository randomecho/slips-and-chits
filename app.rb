require 'sinatra'
require 'data_mapper'

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/slips.db")
require_relative 'models/chit'
DataMapper.finalize

get '/' do
  @chits = Chit.all

  slim :index
end

post '/' do
  Chit.create params[:chit]
  redirect to('/')
end
