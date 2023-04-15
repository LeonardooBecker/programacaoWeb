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
#     t.references :departamento, foreign_key: true
#     t.references :aluno, foreign_key: true
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
    has_one :matricula, dependent: :destroy
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
            return dado
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
            #cria com a primeira referencia encontrada
            cmd=(retornaInfo(ehTabela,infos[1]))[0]
            #transforma o xy_id em apenas xy
            chave=(infos[0].split('_'))[0]
            hashTable[chave]=cmd
        end
    end
    return hashTable
end

def hashTableAlDp()
    hashTable={}
    htables=[]
    chaveAnt=""
    for i in 2..(ARGV.length-1)
        infos=ARGV[i].split('=')            
        ehTabela=verificaParametro(infos[0])
        if(ehTabela=="none")
            hashTable[(infos[0])]=infos[1]
        else
            cmd=retornaInfo(ehTabela,infos[1])
            cmd.each do |t|
            #transforma o xy_id em apenas xy
                chave=(infos[0].split('_'))[0]
                if(chave!=chaveAnt && chaveAnt!="")
                    htables.each do |table|
                        table[chave]=t
                    end
                    return htables
                end
                chaveAnt=chave
                hashTable={}
                hashTable[chave]=t
                htables.push(hashTable)
            end
        end
    end
    return htables
end

if(ARGV[0]=="insere")
    tabela=ARGV[1]
    hashTable=criaHashTable()
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
        hashs=hashTableAlDp()
        puts hashs
        hashs.each do |hashEncontrada|
            alDp=AlunosDepartamento.new(hashEncontrada)
            alDp.save
        end
    end
end

def hashTableExclusao()
    htables=[]
    hashTable={}
    for i in 2..(ARGV.length-1)
        infos=ARGV[i].split('=')            
        ehTabela=verificaParametro(infos[0])
        if(ehTabela=="none")
            hashTable[(infos[0])]=infos[1]
        else
            cmd=retornaInfo(ehTabela,infos[1])
            cmd.each do |t|
            #transforma o xy_id em apenas xy
                chave=(infos[0].split('_'))[0]
                hashTable={}
                hashTable[chave]=t
                htables.push(hashTable)
            end
        end
    end
    if(htables.length==0)
        htables.push(hashTable)
    end
    return htables
end

if(ARGV[0]=="exclui")
    tabela=ARGV[1]
    hashs=hashTableExclusao()
    puts hashs
    hashs.each do |hashTable|
        case tabela
        when "departamentos"
            departamento=Departamento.where(hashTable)
            departamento.destroy_all
        when "disciplinas"
            disciplina=Disciplina.where(hashTable)
            puts disciplina
            disciplina.destroy_all
        when "codigos"
            codigo=Codigo.where(hashTable)
            codigo.destroy_all
        when "alunos"
            aluno=Aluno.where(hashTable)
            aluno.destroy_all
        when "estados"
            estado=Estado.where(hashTable)
            estado.each do |t|
                t.alunos.each(&:destroy)
            end
                estado.destroy_all
        when "matriculas"
            matricula=Matricula.where(hashTable)
            matricula.destroy_all
        when "alunos_departamentos"
            alDp=AlunosDepartamento.where(hashTable)
            alDp.destroy_all
        end
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
                cmd=(retornaInfo(ehTabela,infos[1]))[0]
                #transforma o xy_id em apenas xy
                chave=(infos[0].split('_'))[0]
                hashTableAtual[chave]=cmd
            end
        else
            ehTabela=verificaParametro(infos[0])
            if(ehTabela=="none")
                hashTableNova[(infos[0])]=infos[1]
            else
                cmd=(retornaInfo(ehTabela,infos[1]))[0]
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


if(ARGV[0]=="lista")
    tabela=ARGV[1]
    case tabela
    when "departamentos"
        lines=Departamento.all
        tables=Departamento.connection.columns(tabela).map(&:name)
        tables.each do |name|
            printf("%-20s  ",name)
        end
        print "\n"
        lines.each do |tupla|
            tables.each do |column|
                printf("| %-20s",tupla[column])
            end
            print "\n"
        end
    when "disciplinas"
        lines=Disciplina.all
        tables=Disciplina.connection.columns(tabela).map(&:name)
        tables.each do |name|
            printf("%-20s  ",name)
        end
        print "\n"
        lines.each do |tupla|
            tables.each do |column|
                printf("| %-20s",tupla[column])
            end
            print "\n"
        end
    when "codigos"
        lines=Codigo.all
        tables=Codigo.connection.columns(tabela).map(&:name)
        tables.each do |name|
            printf("%-20s  ",name)
        end
        print "\n"
        lines.each do |tupla|
            tables.each do |column|
                printf("| %-20s",tupla[column])
            end
            print "\n"
        end
    when "alunos"
        lines=Aluno.all
        tables=Aluno.connection.columns(tabela).map(&:name)
        tables.each do |name|
            printf("%-20s  ",name)
        end
        print "\n"
        lines.each do |tupla|
            tables.each do |column|
                printf("| %-20s",tupla[column])
            end
            print "\n"
        end
    when "estados"
        lines=Estado.all
        tables=Estado.connection.columns(tabela).map(&:name)
        tables.each do |name|
            printf("%-20s  ",name)
        end
        print "\n"
        lines.each do |tupla|
            tables.each do |column|
                printf("| %-20s",tupla[column])
            end
            print "\n"
        end
    when "matriculas"
        lines=Matricula.all
        tables=Matricula.connection.columns(tabela).map(&:name)
        tables.each do |name|
            printf("%-20s  ",name)
        end
        print "\n"
        lines.each do |tupla|
            tables.each do |column|
                printf("| %-20s",tupla[column])
            end
            print "\n"
        end
    when "alunos_departamentos"
        lines=AlunosDepartamento.all
        tables=AlunosDepartamento.connection.columns(tabela).map(&:name)
        tables.each do |name|
            printf("%-20s  ",name)
        end
        print "\n"
        lines.each do |tupla|
            tables.each do |column|
                printf("| %-20s",tupla[column])
            end
            print "\n"
        end
    end
end