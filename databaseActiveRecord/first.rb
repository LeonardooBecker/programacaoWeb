require 'rubygems'
require 'active_record'

ActiveRecord::Base.establish_connection :adapter => "sqlite3", :database => "Tabelas.sqlite3"

class DataBase < ActiveRecord::Base;
end

def mostrarTabelas()
    DataBase.connection.tables.each do |table|
        puts table
    end
end

# Lista todas as tabelas de um banco de dados
if(ARGV[0]=="mostrarTabelas")
    mostrarTabelas()
end

#Retorna todas as colunas da tabela
def verificar(tabela)
    DataBase.connection.columns(tabela).map(&:name)
end

# #Cria tabela
# if(ARGV[0]=="criar")
#     # Só cria a tabela se ela ainda não existir
#     tabela=ARGV[1]
#     if (! DataBase.connection.table_exists? tabela)
#         DataBase.connection.create_table :"#{tabela}" do |t|
#         t.string :sigla, limit: 2
#         t.string :nome
#         end
#     else
#         puts "Tabela já existente"
#     end
# end

est="Estado"

class Estado < ActiveRecord::Base
end

#Lista todas as tuplas da tabela
if(ARGV[0]=="lista")
    tabela=ARGV[1]
    if (DataBase.connection.table_exists? tabela)
        class MyTable < DataBase
            self.table_name="#{ARGV[1]}"
        end
        lines=MyTable.all
        lines.each do |tupla|
            tables=verificar(tabela)
            tables.each do |colum|
                print "#{tupla[colum]} "
            end
            print "\n"
        end
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


#Alterar database
if(ARGV[0]=="alterar")
    tabela=ARGV[1]
    if (DataBase.connection.table_exists? tabela)
        class MyTable < DataBase
            self.table_name="#{ARGV[1]}"
        end
        for i in 2..(ARGV.length-1)
            
            infos=ARGV[i].split('=')
            if(i%2 == 0)
                hashTableNovo={}
                hashTableAtual={}
                hashTableAtual[(infos[0])]=infos[1]
            else
                hashTableNovo[(infos[0])]=infos[1]
                # Localizado aqui pois so ocorre quando dois valores forem passados, ou seja, quando houver um valor válido no hashTableNovo
                lines= MyTable.where(hashTableAtual)
                lines.each do |tupla|
                    puts tupla
                    tupla.update(hashTableNovo)
                end
            end
        end
    end
end 