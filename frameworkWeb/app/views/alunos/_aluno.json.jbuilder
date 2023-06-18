json.extract! aluno, :id, :nome, :sobrenome, :estado_id, :created_at, :updated_at
json.url aluno_url(aluno, format: :json)
