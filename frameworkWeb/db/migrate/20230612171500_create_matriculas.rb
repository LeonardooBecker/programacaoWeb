class CreateMatriculas < ActiveRecord::Migration[7.0]
  def change
    create_table :matriculas do |t|
      t.integer :ano
      t.integer :complemento
      t.belongs_to :aluno, null: false, foreign_key: true

      t.timestamps
    end
  end
end
