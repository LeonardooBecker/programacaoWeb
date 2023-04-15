# -*- coding: utf-8 -*-
$:.push './'
require 'active_record'
require 'insereTupla.rb'
require 'excluiTupla.rb'
require 'alteraTupla.rb'
require 'listaTabela.rb'

ActiveRecord::Base.establish_connection:adapter=>"sqlite3",
                                        :database=>"Tabelas.sqlite3"



option=ARGV[0]
case option
when "insere"
    insereTupla()
when "exclui"
    excluiTupla()
when "altera"
    alteraTupla()
when "lista"
    listaTabela()
end