require 'active_record'

ActiveRecord::Base.establish_connection:adapter=>"sqlite3",
                                        :database=>"Tabelas.sqlite3"


class Matricula < ActiveRecord::Base
    belongs_to :aluno
    validates :aluno, uniqueness: true
end

