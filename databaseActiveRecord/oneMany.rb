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

class AlunosDepartamento < ActiveRecord::Base
    belongs_to :aluno
    belongs_to :departamento
end


def retornaColunas(tabela)
    ActiveRecord::Base.connection.columns(tabela).map(&:name)
end

# aln=Aluno.find_by({:nome=>"JUCA"})
# puts aln.matricula.ano

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
    puts hashTable
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
        alDp=AlunosDepartamento.find_by(hashTable)
        alDp.destroy 
    end
end

def hashTableAlteracao()
    hashTableAtual={}
    hashTableNova={}
    for i in 2..(ARGV.length-1)
        infos=ARGV[i].split('=')  
        if(i%2 == 0)          
            ehTabela=verificaParametro(infos[0])
            if(ehTabela=="none")
                hashTableAtual[(infos[0])]=infos[1]
            else
                cmd=retornaInfo(ehTabela,infos[1])
                #transforma o xy_id em apenas xy
                chave=(infos[0].split('_'))[0]
                hashTableAtual[chave]=cmd
            end
        else
            ehTabela=verificaParametro(infos[0])
            if(ehTabela=="none")
                hashTableNova[(infos[0])]=infos[1]
            else
                cmd=retornaInfo(ehTabela,infos[1])
                #transforma o xy_id em apenas xy
                chave=(infos[0].split('_'))[0]
                hashTableNova[chave]=cmd
            end
        end
    end
    return [hashTableAtual, hashTableNova]
end

if(ARGV[0]=="altera")
    tabela=ARGV[1]
    hashTables=hashTableAlteracao()
    hashTableAtual=hashTables[0]
    hashTableNova=hashTables[1]
    case tabela
    when "departamentos"
        departamento=Departamento.find_by(hashTableAtual)
        departamento.update(hashTableNova)
    when "disciplinas"
        disciplina=Disciplina.find_by(hashTableAtual)
        disciplina.update(hashTableNova)
    when "codigos"
        codigo=Codigo.find_by(hashTableAtual)
        codigo.update(hashTableNova)
    when "alunos"
        aluno=Aluno.find_by(hashTableAtual)
        aluno.update(hashTableNova)
    when "estados"
        estado=Estado.find_by(hashTableAtual)
        estado.update(hashTableNova)
    when "matriculas"
        matricula=Matricula.find_by(hashTableAtual)
        matricula.update(hashTableNova)
    when "alunos_departamentos"
        alDp=AlunosDepartamento.find_by(hashTableAtual)
        alDp.update(hashTableNova)
    end
end