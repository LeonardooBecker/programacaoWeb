require 'active_record'

ActiveRecord::Base.establish_connection:adapter=>"sqlite3",
                                        :database=>"Tabelas.sqlite3"


class Departamento < ActiveRecord::Base
    has_many :disciplinas, dependent: :destroy
    has_and_belongs_to_many :alunos, dependent: :destroy
end
