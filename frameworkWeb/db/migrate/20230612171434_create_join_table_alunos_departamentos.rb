class CreateJoinTableAlunosDepartamentos < ActiveRecord::Migration[7.0]
  def change
    create_join_table :alunos, :departamentos do |t|
      # t.index [:aluno_id, :departamento_id]
      # t.index [:departamento_id, :aluno_id]
    end
  end
end
