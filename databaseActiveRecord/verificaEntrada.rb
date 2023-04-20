# -*- coding: utf-8 -*-
$:.push './'
require 'active_record'
require 'insereTupla.rb'
require 'excluiTupla.rb'
require 'alteraTupla.rb'
require 'listaTabela.rb'

ActiveRecord::Base.establish_connection:adapter=>"sqlite3",
                                        :database=>"Tabelas.sqlite3"

def corrigeEntrada(entrada)
    opts=entrada.split(" ")
    nova_string=""
    entre_aspas=false
    vet=[]
    opts.each do |s|
        if(s.count('"')==2)
            vet.push((s.delete!('"')))
        elsif s.include?('"')
            if(entre_aspas==false)
                nova_string = s.delete('"')
                entre_aspas = true
            else
                entre_aspas = false
                nova_string += ' ' + s.delete('"')
                vet.push(nova_string)
            end
        elsif entre_aspas
            nova_string += ' ' + s
        else
            vet.push(s)
        end
    end
    return vet
end

def preenchimentoAutomatico()
    File.open("./arquivoPreenchimento.txt", "r") do |arquivo|
        arquivo.each_line do |linha|
            if(linha!="\n")
                entrada=corrigeEntrada(linha)
                option=entrada[0]
                case option
                when "insere"
                    insereTupla(entrada)
                when "exclui"
                    excluiTupla(entrada)
                when "altera"
                    alteraTupla(entrada)
                when "lista"
                    listaTabela(entrada)
                when "q"
                    printf("Encerrando programa\n")
                else
                    printf("Operação desconhecida :(\n")
                end
            end
        end
    end
end