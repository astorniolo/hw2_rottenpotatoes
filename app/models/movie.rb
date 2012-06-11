class Movie < ActiveRecord::Base
   @@ratings=['G','PG','PG-13','R','NC-17']
   
   def self.all_ratings
     @@ratings
   end
end
