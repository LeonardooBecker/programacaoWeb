require 'active_record'

ActiveRecord::Base.establish_connection:adapter=>"sqlite3",
                                        :database=>"Tabelas.sqlite3"

class Aluno < ActiveRecord::Base
    belongs_to :estado
    validates_presence_of :estado
    has_one :matricula, dependent: :destroy
    has_and_belongs_to_many :departamentos, dependent: :destroy
end
