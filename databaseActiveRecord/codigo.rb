require 'active_record'

ActiveRecord::Base.establish_connection:adapter=>"sqlite3",
                                        :database=>"Tabelas.sqlite3"



class Codigo < ActiveRecord::Base
    validates_presence_of :disciplina
    belongs_to :disciplina
    validates :disciplina, uniqueness: true
end