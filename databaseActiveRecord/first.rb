# def a_method(a,b)
#     if block_given?
#         5+yield(a,b)
#     else
#         a+b
#     end
# end
# puts a_method(1,2){|x,y| (x+y)*3}


require 'rubygems'
require 'active_record'

ActiveRecord::Base.establish_connection :adapter => "sqlite3", :database => "Tabelas.sqlite3"

class DataBase < ActiveRecord::Base;
end


# Lista todas as tabelas de um banco de dados
if(ARGV[0]=="listar")
    DataBase.connection.tables.each do |table|
        puts table
    end
end



#Analisa as colunas da tabela
if(ARGV[0]=="verificar")
    # lista o nome de todas as colunas do database
    tabela=ARGV[1]
    puts DataBase.connection.columns(tabela).map(&:name)
end


if(ARGV[0]=="criar")
    # Só cria a tabela se ela ainda não existir
    tabela=ARGV[1]
    if (! DataBase.connection.table_exists? tabela)
        DataBase.connection.create_table :"#{tabela}" do |t|
        t.string :sigla, limit: 2
        t.string :nome
        end
    else
        puts "Tabela já existente"
    end
end




#Função de inserir
if(ARGV[0]=="insere")
    tabela=ARGV[1]
    if (DataBase.connection.table_exists? tabela)
        class MyTable < DataBase
            self.table_name="#{ARGV[1]}"
        end
        hashTable={}
        for i in 2..(ARGV.length-1)
            infos=ARGV[i].split('=')
            hashTable[(infos[0])]=infos[1]
        end
        line=MyTable.new(hashTable)
        line.save
    end
end

#Procurar no banco
if(ARGV[0]=="exclui")
    tabela=ARGV[1]
    if (DataBase.connection.table_exists? tabela)
        class MyTable < DataBase
            self.table_name="#{ARGV[1]}"
        end
        hashTable={}
        for i in 2..(ARGV.length-1)
            infos=ARGV[i].split('=')
            hashTable[(infos[0])]=infos[1]
            lines= MyTable.where(hashTable)
            lines.each do |tupla|
                puts tupla
                tupla.delete
            end

        end
    end
end 

# class Estado < ActiveRecord::Base;
# end

# est=Estado.new()
# est.nome="Acre"
# est.sigla="AC"
# est.save

# a = Estado.create(id:26,sigla:"PR",nome:"Paraná")
# a.save


# ests=Estado.all

# ests.each do |e|
#     puts "#{e.sigla} = #{e.nome}"
# end