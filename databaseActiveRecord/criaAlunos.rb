require 'active_record'

ActiveRecord::Base.establish_connection:adapter=>"sqlite3",
                                        :database=>"Tabelas.sqlite3"


ActiveRecord::Base.connection.create_table :alunos do |t|
    t.string :nome
    t.string :sobrenome
    t.references :estado, foreign_key: true
end
