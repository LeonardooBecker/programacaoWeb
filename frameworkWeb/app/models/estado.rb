class Estado < ApplicationRecord
    has_many :alunos, dependent: :destroy
end
