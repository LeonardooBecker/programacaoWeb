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
        printf("Tabela departamentos\n")
        imprimeDepartamento(tabela)
    when "disciplinas"
        printf("Tabela disciplinas\n")
        imprimeDisciplina(tabela)
    when "codigos"
        printf("Tabela codigos\n")
        imprimeCodigos(tabela)
    when "alunos"
        printf("Tabela alunos\n")
        imprimeAlunos(tabela)
    when "estados"
        printf("Tabela estados\n")
        imprimeEstados(tabela)
    when "matriculas"
        printf("Tabela matriculas\n")
        imprimeMatriculas(tabela)
    when "alunos_departamentos"
        printf("Tabela alunos_departamentos\n")
        imprimeAlunosDepartamento(tabela)
    end
end