# -*- coding: utf-8 -*-
$:.push './'
require 'estado.rb'
require 'municipio.rb'

estado_pr = Estado.find_by_sigla("PR")

municipio = Pessoa.new ()
municipio.nome = "Abatiá"
municipio.estado = estado_pr
municipio.save
municipio = Pessoa.new ()
municipio.nome = "Adrianópolis"
municipio.estado = estado_pr
municipio.save

puts "-----"

estados=Estado.all
estados.each do |estado|
  puts estado.nome
  pessoas=estado.pessoas
  Estado.pessoas.delete
  pessoas.each do |m|
    puts m.nome
  end
end
