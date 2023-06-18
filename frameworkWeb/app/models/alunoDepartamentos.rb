class AlunosDepartamento < ActiveRecord::Base
    belongs_to :aluno
    belongs_to :departamento
end