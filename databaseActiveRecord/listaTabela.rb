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
require 'hashTables.rb'
require 'imprimeTabelas.rb'

ActiveRecord::Base.establish_connection:adapter=>"sqlite3",
                                        :database=>"Tabelas.sqlite3"




def listaTabela()
    tabela=ARGV[1]
    case tabela
    when "departamentos"
        imprimeDepartamento(tabela)
    when "disciplinas"
        imprimeDisciplina(tabela)
    when "codigos"
        imprimeCodigos(tabela)
    when "alunos"
        imprimeAlunos(tabela)
    when "estados"
        imprimeEstados(tabela)
    when "matriculas"
        imprimeMatriculas(tabela)
    when "alunos_departamentos"
        imprimeAlunosDepartamento(tabela)
    end
end