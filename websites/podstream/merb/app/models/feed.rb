class Feed
  include DataMapper::Resource
  
  property :id, Serial
  property :uri, String, :nullable => false


end
