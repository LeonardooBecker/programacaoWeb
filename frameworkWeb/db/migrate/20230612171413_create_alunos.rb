class CreateAlunos < ActiveRecord::Migration[7.0]
  def change
    create_table :alunos do |t|
      t.string :nome
      t.string :sobrenome
      t.belongs_to :estado, null: false, foreign_key: true

      t.timestamps
    end
  end
end
