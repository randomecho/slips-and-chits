require 'sinatra'
require 'data_mapper'
require 'dm-timestamps'

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/slips.db")
require_relative 'models/chit'
DataMapper.finalize

categories = {
  eat_out: 'Eating out',
  groceries: 'Groceries',
  car: 'Car',
  gas: 'Gas',
  pets: 'Pets',
  entertainment: 'Entertainment',
  health: 'Health',
  home: 'Home',
  clothes: 'Clothes',
  comms: 'Comms',
  toys: 'Toys',
  books: 'Books',
  travel: 'Travel',
  rent: 'Rent',
  gifts: 'Gifts',
  donations: 'Donations'
}

get '/' do
  @chits = Chit.all(:order => [:purchase_date.desc, :created_at.desc])
  @categories = categories
  slim :index
end

post '/' do
  Chit.create params[:chit]
  redirect to('/')
end
