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



def retornaColunas(tabela)
    ActiveRecord::Base.connection.columns(tabela).map(&:name)
end


def retornaInfo(tabela,valor)
    tables=retornaColunas(tabela)
    tables.each do |column|
        case tabela
        when "alunos"
            dado=Aluno.find_by_sql("SELECT * from #{tabela} WHERE #{column} = '#{valor}'")
        when "departamentos"
            dado=Departamento.find_by_sql("SELECT * from #{tabela} WHERE #{column} = '#{valor}'")
        when "disciplinas"
            dado=Disciplina.find_by_sql("SELECT * from #{tabela} WHERE #{column} = '#{valor}'")
        when "estados"
            dado=Estado.find_by_sql("SELECT * from #{tabela} WHERE #{column} = '#{valor}'")
        end
        if(dado[0]!=nil)
            return dado[0]
        end
    end
end

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

def criaHashTable()
    hashTable={}
    for i in 2..(ARGV.length-1)
        infos=ARGV[i].split('=')            
        ehTabela=verificaParametro(infos[0])
        if(ehTabela=="none")
            hashTable[(infos[0])]=infos[1]
        else
            cmd=retornaInfo(ehTabela,infos[1])
            #transforma o xy_id em apenas xy
            chave=(infos[0].split('_'))[0]
            hashTable[chave]=cmd
        end
    end
    return hashTable
end

if(ARGV[0]=="insere")
    tabela=ARGV[1]
    hashTable=criaHashTable()
    puts hashTable
    case tabela
    when "departamentos"
        departamento=Departamento.new(hashTable)
        departamento.save
    when "disciplinas"
        disciplina=Disciplina.new(hashTable)
        disciplina.save
    when "codigos"
        codigo=Codigo.new(hashTable)
        codigo.save
    when "alunos"
        aluno=Aluno.new(hashTable)
        aluno.save
    when "estados"
        estado=Estado.new(hashTable)
        estado.save
    when "matriculas"
        matricula=Matricula.new(hashTable)
        matricula.save
    when "alunos_departamentos"
        hashTable["aluno"].departamentos << hashTable["departamento"]
    end
end


if(ARGV[0]=="exclui")
    tabela=ARGV[1]
    hashTable=criaHashTable()
    case tabela
    when "departamentos"
        departamento=Departamento.find_by(hashTable)
        departamento.destroy
    when "disciplinas"
        disciplina=Disciplina.find_by(hashTable)
        disciplina.destroy
    when "codigos"
        codigo=Codigo.find_by(hashTable)
        codigo.destroy
    when "alunos"
        aluno=Aluno.find_by(hashTable)
        aluno.destroy
    when "estados"
        estado=Estado.find_by(hashTable)
        estado.destroy
    when "matriculas"
        matricula=Matricula.find_by(hashTable)
        matricula.destroy
    when "alunos_departamentos"
        hashTable["aluno"].departamentos.delete(hashTable["departamento"])
        hashTable["departamento"].alunos.delete(hashTable["aluno"])
    end
end

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
# alunos=Aluno.find_by({:nome=>"JUCA"})
# puts alunos.sobrenome
# dep1.alunos.destroy
# alunos.departamentos.delete(dep1)
# alunos.each do |aluno|
#     puts aluno.nome
#     aluno.departamentos
# end




# departamentos=Departamento.all
# departamentos.each do |dep|
#     dep.destroy
#     # puts dep.name
#     # mats=dep.mates
#     # mats.each do |t|
#     #     puts t.name
#     # end
# end