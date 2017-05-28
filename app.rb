require 'data_mapper'
require 'dm-timestamps'
require 'sinatra'
require 'slim'

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/slips.db")
require_relative 'models/chit'
DataMapper.finalize

Slim::Engine.set_options format: :html

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
  @chits = Chit.all(:limit => 21, :order => [:purchase_date.desc, :created_at.desc])
  @categories = categories
  slim :index
end

get '/edit/:id' do
  @chit = Chit.get(params['id'])
  @dollar_amount = sprintf("%.2f", @chit.amount)
  @categories = categories
  slim :edit
end

post '/' do
  Chit.create params[:chit]
  redirect to('/')
end

put '/edit/:id' do
  @chit = Chit.get(params['id'])
  @chit.update params[:chit]
  redirect to('/')
end
