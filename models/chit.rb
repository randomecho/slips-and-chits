class Chit
  include DataMapper::Resource

  property :id, Serial
  property :purchase_date, DateTime, :required => true
  property :amount, Decimal, :required => true
  property :category, String, :required => true
  property :location, String, :required => true
  property :notes, Text, :required => false
  property :deleted, Boolean, :default => false
  property :created_at, DateTime
  property :updated_at, DateTime
end
