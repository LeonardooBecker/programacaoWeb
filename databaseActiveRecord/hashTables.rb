# -*- coding: utf-8 -*-
$:.push './'
require 'active_record'
require 'aluno.rb'
require 'codigo.rb'
require 'alunoDepartamentos.rb'
require 'departamento.rb'
require 'disciplina.rb'
require 'estado.rb'
require 'matricula.rb'

ActiveRecord::Base.establish_connection:adapter=>"sqlite3",
                                        :database=>"Tabelas.sqlite3"

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

def hashTableInsercao()
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
