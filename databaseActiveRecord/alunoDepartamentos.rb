# -*- coding: utf-8 -*-
$:.push './'
require 'active_record'

ActiveRecord::Base.establish_connection:adapter=>"sqlite3",
                                        :database=>"Tabelas.sqlite3"

class AlunosDepartamento < ActiveRecord::Base
    belongs_to :aluno
    belongs_to :departamento
end