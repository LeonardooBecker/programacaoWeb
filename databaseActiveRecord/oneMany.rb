require 'active_record'

ActiveRecord::Base.establish_connection:adapter=>"sqlite3",
                                        :database=>"Tabelas.sqlite3"


# ActiveRecord::Base.connection.create_table :departamentos do |t|
#     t.string :nome
#     t.string :campus
# end

# ActiveRecord::Base.connection.create_table :estados do |t|
#     t.string :sigla, limit: 2
#     t.string :nome
# end

# ActiveRecord::Base.connection.create_table :alunos do |t|
#     t.string :nome
#     t.string :sobrenome
#     t.references :estado, foreign_key: true
# end

# ActiveRecord::Base.connection.create_table :alunos_departamentos do |t|
#     t.references :departamento
#     t.references :aluno
# end

# ActiveRecord::Base.connection.create_table :matriculas do |t|
#     t.integer :ano
#     t.integer :complemento
#     t.references :aluno, foreign_key: true
# end

# ActiveRecord::Base.connection.create_table :disciplinas do |t|
#     t.string :nome
#     t.string :professor
#     t.references :departamento,foreign_key: true
# end

# ActiveRecord::Base.connection.create_table :codigos do |t|
#     t.string :codigo
#     t.references :disciplina, foreign_key: true
# end




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

# Palavras protegidas - aluno


def verificar(tabela)
    ActiveRecord::Base.connection.columns(tabela).map(&:name)
end

tables=verificar("alunos")

Aluno.find_by_sql("SELECT * from alunos WHERE nome = 'CESAR'")

etab="alunos"
var="LEONARDO"

def retornaInfo(tabela,valor)
    tables=verificar(tabela)
    tables.each do |column|
        # puts column
        aln=Aluno.find_by_sql("SELECT * from #{tabela} WHERE #{column} = '#{valor}'")
        if(aln[0]!=nil)
            return aln[0]
        end
    end
end

aln=retornaInfo("alunos","LEONARDO")
puts aln.sobrenome
# aln = Aluno.find_by_sql("SELECT * from #{var} WHERE CONCAT(nome, sobrenome) = 'LEONARDO'")
# puts aln[0].sobrenome


def verificaParametro(word)
    case word
    when "aluno_id"
        return "alunos"
    when "estado_id"
        return "estados"
    when "disciplina_id"
        return "disciplinas"
    when "departamento_id"
        return "departamentos"
    else
        return "none"
    end
end


if(ARGV[0]=="insere")
    tabela=ARGV[1]
    case ARGV[1]
    when "matriculas"
        matricula=Matricula.new()
        hashTable={}
        for i in 2..(ARGV.length-1)
            infos=ARGV[i].split('=')

            ehTabela=verificaParametro(infos[0])
            if(ehTabela=="none")
                hashTable[(infos[0])]=infos[1]
            else
                
            end
        end
        puts hashTable
    else
        return
    end
end


# insere matricula ano="x" comp="y" aluno_id="LEONARDO"



# aln = Aluno.find_by_sql("SELECT * from #{var} WHERE CONCAT(nome, sobrenome) = 'LEONARDO'")
# puts aln[0].sobrenome

# mat=Matricula.new({:ano=>2021,:complemento=>1789})
# mat.aluno=aln
# mat.save

# est=Estado.new({:sigla=>"PR",:nome=>"PARANA"})
# est.save


# est=Estado.find_by({:sigla=>"PR"})
# puts est.nome

# aln=Aluno.new({:nome=>"LEONARDO",:sobrenome=>"BECKER"})
# aln.estado=est
# aln.save

# aln=Aluno.find_by({:nome=>"LEONARDO"})
# puts aln.sobrenome

# mat=Matricula.new({:ano=>2021,:complemento=>1779})
# mat.aluno=aln
# mat.save

# dep=Departamento.new({:nome=>"DINF",:campus=>"POLITECNICO"})
# dep.save

# dep=Departamento.find_by({:nome=>"DINF"})
# dis=Disciplina.new({:nome=>"PROGWEB",:professor=>"BMULLER"})
# dis.departamento=dep
# dis.save

# dis=Disciplina.find_by({:nome=>"PROGWEB"})
# cod=Codigo.new({:codigo=>"CI1010"})
# cod.disciplina=dis
# cod.save

# dep1=Departamento.find_by({:nome=>"DINF"})
# puts dep1.nome
# alunos=Aluno.all
# alunos.each do |aluno|
#     puts aluno.nome
#     aluno.departamentos << dep1
# end




departamentos=Departamento.all
departamentos.each do |dep|
    dep.destroy
    # puts dep.name
    # mats=dep.mates
    # mats.each do |t|
    #     puts t.name
    # end
end