require 'dm-core'
require 'dm-migrations'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/mydatabase.db")

class Person
  include DataMapper::Resource
  property(:id, Serial)
  property(:firstname, String)
  property(:lastname, String)
  property(:age, Integer)
  property(:birthday, Date)
end

DataMapper.finalize
