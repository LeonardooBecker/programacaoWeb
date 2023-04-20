require 'active_record'

ActiveRecord::Base.establish_connection:adapter=>"sqlite3",
                                        :database=>"Tabelas.sqlite3"


ActiveRecord::Base.connection.create_table :codigos do |t|
    t.string :codigo
    t.references :disciplina, foreign_key: true, :unique => true
end
