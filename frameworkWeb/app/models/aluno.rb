class Aluno < ApplicationRecord
  belongs_to :estado
  has_one :matricula, dependent: :destroy
  has_and_belongs_to_many :departamentos, dependent: :destroy
end
