require 'active_record'

ActiveRecord::Base.establish_connection:adapter=>"sqlite3",
                                        :database=>"Tabelas.sqlite3"


ActiveRecord::Base.connection.create_table :alunos_departamentos do |t|
    t.references :departamento, foreign_key: true
    t.references :aluno, foreign_key: true
end
