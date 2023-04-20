# -*- coding: utf-8 -*-
$:.push './../'
require 'active_record'
require 'defineTabelas/aluno.rb'
require 'defineTabelas/codigo.rb'
require 'defineTabelas/alunoDepartamentos.rb'
require 'defineTabelas/departamento.rb'
require 'defineTabelas/disciplina.rb'
require 'defineTabelas/estado.rb'
require 'defineTabelas/matricula.rb'
require 'operacoes/hashTables.rb'
require 'operacoes/imprimeTabelas.rb'

ActiveRecord::Base.establish_connection:adapter=>"sqlite3",
                                        :database=>"Tabelas.sqlite3"



def listaTabela(entrada)
    tabela=entrada[1]
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
    else
        printf("Tabela inexistente \n")
    end
    printf("\n")
end