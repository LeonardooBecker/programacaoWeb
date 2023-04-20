# -*- coding: utf-8 -*-
$:.push './'
require 'active_record'
require 'insereTupla.rb'
require 'excluiTupla.rb'
require 'alteraTupla.rb'
require 'listaTabela.rb'
require 'verificaEntrada.rb'

ActiveRecord::Base.establish_connection:adapter=>"sqlite3",
                                        :database=>"Tabelas.sqlite3"


option=""
leArquivo=0
if (ARGV[0]=="1")
    leArquivo=1
    preenchimentoAutomatico()
end
ARGV.clear


while ((option!="q") && (leArquivo==0))
    entrada=gets.chomp
    entrada=corrigeEntrada(entrada)
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