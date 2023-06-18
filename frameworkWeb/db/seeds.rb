lista_estados = 
  [
   {:nome => "Amapá", :sigla => "AP"        },
   {:nome => "Amazonas", :sigla => "AM"     },
   {:nome => "Bahia", :sigla => "BA"        },
   {:nome => "Ceará", :sigla => "CE"        },
   {:nome => "Distrito Federal", :sigla => "DF"     },
   {:nome => "Espírito Santo", :sigla => "ES"       },
   {:nome => "Goiás", :sigla => "GO"        },
   {:nome => "Maranhão", :sigla => "MA"     },
   {:nome => "Mato Grosso", :sigla => "MT"          },
   {:nome => "Mato Grosso do Sul",:sigla => "MS"    },
   {:nome => "Minas Gerais", :sigla => "MG"         },
   {:nome => "Pará", :sigla => "PA"         },
   {:nome => "Paraíba", :sigla => "PB"      },
   {:nome => "Paraná", :sigla => "PR"       },
   {:nome => "Pernambuco", :sigla => "PE"   },
   {:nome => "Piauí", :sigla => "PI"        },
   {:nome => "Rio de Janeiro",:sigla => "RJ"        },
   {:nome => "Rio Grande do Norte", :sigla => "RN"          },   
   {:nome => "Tocantins", :sigla => "TO" },
   {:nome => "Rio Grande do Sul", :sigla => "RS"    },
   {:nome => "Rondônia", :sigla => "RO"     },
   {:nome => "Roraima", :sigla => "RR"      },
   {:nome => "Santa Catarina", :sigla => "SC"       },
   {:nome => "São Paulo", :sigla => "SP"    },
   {:nome => "Sergipe", :sigla => "SE"      },
   {:nome => "Tocantins", :sigla => "TO" },
  ]

lista_estados.each do |e|
  est = Estado.new ()
  est.nome = e[:nome]
  est.sigla = e[:sigla]
  est.save
end


alunos = [
    {:nome => "João", :sobrenome => "Silva", :estado_id => 1},
    {:nome => "Maria", :sobrenome => "Santos", :estado_id => 2},
    {:nome => "Pedro", :sobrenome => "Almeida", :estado_id => 3},
    {:nome => "Ana", :sobrenome => "Pereira", :estado_id => 1},
    {:nome => "Lucas", :sobrenome => "Oliveira", :estado_id => 4},
    {:nome => "Carla", :sobrenome => "Souza", :estado_id => 2},
    {:nome => "Gustavo", :sobrenome => "Ferreira", :estado_id => 5},
    {:nome => "Mariana", :sobrenome => "Rodrigues", :estado_id => 3},
    {:nome => "Rafael", :sobrenome => "Silveira", :estado_id => 1},
    {:nome => "Fernanda", :sobrenome => "Costa", :estado_id => 4},
    {:nome => "Diego", :sobrenome => "Melo", :estado_id => 2},
    {:nome => "Camila", :sobrenome => "Gomes", :estado_id => 5},
    {:nome => "Thiago", :sobrenome => "Ribeiro", :estado_id => 3},
    {:nome => "Juliana", :sobrenome => "Nascimento", :estado_id => 1},
    {:nome => "Rodrigo", :sobrenome => "Silva", :estado_id => 4},
    {:nome => "Patrícia", :sobrenome => "Lima", :estado_id => 2},
    {:nome => "Daniel", :sobrenome => "Martins", :estado_id => 5},
    {:nome => "Amanda", :sobrenome => "Fernandes", :estado_id => 3},
    {:nome => "Ricardo", :sobrenome => "Cardoso", :estado_id => 1}
]
  

alunos.each do |e|
    aln = Aluno.new()
    aln.nome = e[:nome]
    aln.sobrenome = e[:sobrenome]
    aln.estado_id=(e[:estado_id]).to_i
    aln.save
end

vetor_matriculas = [
    { ano: 2020, complemento: 1, aluno_id: 5 },
    { ano: 2021, complemento: 3, aluno_id: 3 },
    { ano: 2019, complemento: 2, aluno_id: 12 },
    { ano: 2022, complemento: 5, aluno_id: 7 },
    { ano: 2023, complemento: 4, aluno_id: 1 },
    { ano: 2021, complemento: 8, aluno_id: 10 },
    { ano: 2020, complemento: 7, aluno_id: 4 },
    { ano: 2022, complemento: 9, aluno_id: 6 },
    { ano: 2019, complemento: 6, aluno_id: 11 },
    { ano: 2023, complemento: 10, aluno_id: 9 },
    { ano: 2020, complemento: 12, aluno_id: 2 },
    { ano: 2021, complemento: 11, aluno_id: 8 },
    { ano: 2022, complemento: 14, aluno_id: 15 },
    { ano: 2023, complemento: 13, aluno_id: 14 },
    { ano: 2020, complemento: 16, aluno_id: 18 },
    { ano: 2021, complemento: 15, aluno_id: 13 },
    { ano: 2019, complemento: 18, aluno_id: 17 },
    { ano: 2022, complemento: 17, aluno_id: 16 }
  ]
  

vetor_matriculas.each do |e|
    aln = Matricula.new()
    aln.ano = e[:ano]
    aln.complemento = e[:complemento]
    aln.aluno_id=(e[:aluno_id]).to_i
    aln.save
end

vetor_departamentos = [
    {:nome => "Departamento de Ciências Exatas", :campus => ["Campus A", "Campus B", "Campus C", "Campus D", "Campus E", "Campus F"].sample},
    {:nome => "Departamento de Ciências Sociais", :campus => ["Campus A", "Campus B", "Campus C", "Campus D", "Campus E", "Campus F"].sample},
    {:nome => "Departamento de Letras", :campus => ["Campus A", "Campus B", "Campus C", "Campus D", "Campus E", "Campus F"].sample},
    {:nome => "Departamento de Engenharia", :campus => ["Campus A", "Campus B", "Campus C", "Campus D", "Campus E", "Campus F"].sample},
    {:nome => "Departamento de Artes", :campus => ["Campus A", "Campus B", "Campus C", "Campus D", "Campus E", "Campus F"].sample},
    {:nome => "Departamento de Saúde", :campus => ["Campus A", "Campus B", "Campus C", "Campus D", "Campus E", "Campus F"].sample},
    {:nome => "Departamento de Humanidades", :campus => ["Campus A", "Campus B", "Campus C", "Campus D", "Campus E", "Campus F"].sample},
    {:nome => "Departamento de Economia", :campus => ["Campus A", "Campus B", "Campus C", "Campus D", "Campus E", "Campus F"].sample},
    {:nome => "Departamento de Biologia", :campus => ["Campus A", "Campus B", "Campus C", "Campus D", "Campus E", "Campus F"].sample},
    {:nome => "Departamento de História", :campus => ["Campus A", "Campus B", "Campus C", "Campus D", "Campus E", "Campus F"].sample},
    {:nome => "Departamento de Filosofia", :campus => ["Campus A", "Campus B", "Campus C", "Campus D", "Campus E", "Campus F"].sample},
    {:nome => "Departamento de Psicologia", :campus => ["Campus A", "Campus B", "Campus C", "Campus D", "Campus E", "Campus F"].sample},
    {:nome => "Departamento de Matemática", :campus => ["Campus A", "Campus B", "Campus C", "Campus D", "Campus E", "Campus F"].sample},
    {:nome => "Departamento de Química", :campus => ["Campus A", "Campus B", "Campus C", "Campus D", "Campus E", "Campus F"].sample},
    {:nome => "Departamento de Física", :campus => ["Campus A", "Campus B", "Campus C", "Campus D", "Campus E", "Campus F"].sample},
    {:nome => "Departamento de Geografia", :campus => ["Campus A", "Campus B", "Campus C", "Campus D", "Campus E", "Campus F"].sample},
    {:nome => "Departamento de Educação Física", :campus => ["Campus A", "Campus B", "Campus C", "Campus D", "Campus E", "Campus F"].sample},
    {:nome => "Departamento de Ciências da Computação", :campus => ["Campus A", "Campus B", "Campus C", "Campus D", "Campus E", "Campus F"].sample}
  ]
  

vetor_departamentos.each do |e|
    aln = Departamento.new()
    aln.nome = e[:nome]
    aln.campus = e[:campus]
    aln.save
end

vetor_usuarios = [
    {:email => "admin@admin", :password => "admin", :role => 1},
    {:email => "user@user", :password => "user", :role => 0},
    {:email => "usuario1@example.com", :password => "senha1", :role => 0},
    {:email => "usuario2@example.com", :password => "senha2", :role => 0},
    {:email => "usuario3@example.com", :password => "senha3", :role => 0},
    {:email => "usuario4@example.com", :password => "senha4", :role => 0},
    {:email => "usuario5@example.com", :password => "senha5", :role => 0},
    {:email => "usuario6@example.com", :password => "senha6", :role => 0},
    {:email => "usuario7@example.com", :password => "senha7", :role => 0},
    {:email => "usuario8@example.com", :password => "senha8", :role => 0},
    {:email => "usuario9@example.com", :password => "senha9", :role => 0},
    {:email => "usuario10@example.com", :password => "senha10", :role => 0},
    {:email => "usuario11@example.com", :password => "senha11", :role => 0},
    {:email => "usuario12@example.com", :password => "senha12", :role => 0},
    {:email => "usuario13@example.com", :password => "senha13", :role => 0},
    {:email => "usuario14@example.com", :password => "senha14", :role => 0},
    {:email => "usuario15@example.com", :password => "senha15", :role => 0},
    {:email => "usuario16@example.com", :password => "senha16", :role => 0},
    {:email => "usuario17@example.com", :password => "senha17", :role => 0},
    {:email => "usuario18@example.com", :password => "senha18", :role => 0}
]

vetor_usuarios.each do |e|
    aln = User.new()
    aln.email = e[:email]
    aln.password = e[:password]
    aln.role=e[:role]
    aln.save
end

aln = Aluno.all
departamentos = Departamento.all

aln.each do |aluno|
  departamento = departamentos.sample
  aluno.departamentos << departamento
end
