require 'active_record'

ActiveRecord::Base.establish_connection:adapter=>"sqlite3",
                                        :database=>"Tabelas.sqlite3"


class Disciplina < ActiveRecord::Base
    belongs_to :departamento
    validates_presence_of :departamento
    has_one :codigo, dependent: :destroy
end
