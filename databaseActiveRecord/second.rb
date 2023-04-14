require 'active_record'

ActiveRecord::Base.establish_connection:adapter=>"sqlite3",
                                        :database=>"Tabelas.sqlite3"


class Departamento < ActiveRecord::Base
    has_many :disciplinas, dependent: :destroy
    has_and_belongs_to_many :alunos, dependent: :destroy
end

class Disciplina < ActiveRecord::Base
    belongs_to :departamento
    has_one :codigo, dependent: :destroy
end

class Codigo < ActiveRecord::Base
    belongs_to :disciplina
end

class Estado < ActiveRecord::Base;
    has_many :alunos, dependent: :destroy
end

class Aluno < ActiveRecord::Base
    belongs_to :estado
    has_one :matricula
    has_and_belongs_to_many :departamentos, dependent: :destroy
end

class Matricula < ActiveRecord::Base
    belongs_to :aluno
end
                                        
est=Estado.new({:sigla=>"PR",:nome=>"PARANA"})
est.save


est=Estado.find_by({:sigla=>"PR"})
puts est.nome

aln=Aluno.new({:nome=>"LEONARDO",:sobrenome=>"BECKER"})
aln.estado=est
aln.save

aln=Aluno.find_by({:nome=>"LEONARDO"})
puts aln.sobrenome

mat=Matricula.new({:ano=>2021,:complemento=>1779})
mat.aluno=aln
mat.save

dep=Departamento.new({:nome=>"DINF",:campus=>"POLITECNICO"})
dep.save

dep=Departamento.find_by({:nome=>"DINF"})
dis=Disciplina.new({:nome=>"PROGWEB",:professor=>"BMULLER"})
dis.departamento=dep
dis.save

dis=Disciplina.find_by({:nome=>"PROGWEB"})
cod=Codigo.new({:codigo=>"CI1010"})
cod.disciplina=dis
cod.save

dep1=Departamento.find_by({:nome=>"DINF"})
puts dep1.nome
alunos=Aluno.all
alunos.each do |aluno|
    puts aluno.nome
    aluno.departamentos << dep1
end
