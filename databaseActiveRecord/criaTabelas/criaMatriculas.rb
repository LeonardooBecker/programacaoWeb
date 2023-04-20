require 'active_record'

ActiveRecord::Base.establish_connection:adapter=>"sqlite3",
                                        :database=>"Tabelas.sqlite3"


ActiveRecord::Base.connection.create_table :matriculas do |t|
    t.integer :ano
    t.integer :complemento
    t.references :aluno, foreign_key: true, :unique => true
end

