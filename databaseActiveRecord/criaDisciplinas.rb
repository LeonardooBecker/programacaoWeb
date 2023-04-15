require 'active_record'

ActiveRecord::Base.establish_connection:adapter=>"sqlite3",
                                        :database=>"Tabelas.sqlite3"

ActiveRecord::Base.connection.create_table :disciplinas do |t|
    t.string :nome
    t.string :professor
    t.references :departamento,foreign_key: true
end
