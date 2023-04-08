def a_method(a,b)
    if block_given?
        5+yield(a,b)
    else
        a+b
    end
end
puts a_method(1,2){|x,y| (x+y)*3}


require 'rubygems'
require 'active_record'

ActiveRecord::Base.establish_connection :adapter => "sqlite3", :database => "Tabelas.sqlite3"

# ActiveRecord::Base.connection.create_table :estados do |t|
# t.string :sigla, limit: 2
# t.string :nome
# end

class Estado < ActiveRecord::Base;
end