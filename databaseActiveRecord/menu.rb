# -*- coding: utf-8 -*-
$:.push './'
require 'active_record'
require 'operacoes/insereTupla.rb'
require 'operacoes/excluiTupla.rb'
require 'operacoes/alteraTupla.rb'
require 'operacoes/listaTabela.rb'
require 'operacoes/verificaEntrada.rb'

ActiveRecord::Base.establish_connection:adapter=>"sqlite3",
                                        :database=>"Tabelas.sqlite3"


option=""
leArquivo=0
if (ARGV[0]=="1")
    leArquivo=1
    preenchimentoAutomatico()
end
ARGV.clear

if(leArquivo==0)
    printf("Banco de dados utilizando active record.\n")
    printf("Operações disponíveis: 
        'insere', 
        'exclui', 
        'lista', 
        'altera'.\n\n")
    printf("Tabelas existentes: 
        'alunos_departamentos', 
        'departamentos', 
        'alunos', 
        'estados', 
        'disciplinas', 
        'codigos', 
        'matriculas'.\n\n")
end

while ((option!="q") && (leArquivo==0))
    printf("Insira um comando: ( Para encerrar insira 'q' )\n")
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