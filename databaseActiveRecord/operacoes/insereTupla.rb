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


ActiveRecord::Base.establish_connection:adapter=>"sqlite3",
                                        :database=>"Tabelas.sqlite3"




def insereTupla(entrada)
    tabela=entrada[1]
    if(tabela!="alunos_departamentos")
        hashTable=hashTableInsercao(entrada)
    end
    case tabela
    when "departamentos"
        departamento=Departamento.new(hashTable)
        departamento.save
    when "disciplinas"
        disciplina=Disciplina.new(hashTable)
        disciplina.save
    when "codigos"
        codigo=Codigo.new(hashTable)
        codigo.save
    when "alunos"
        aluno=Aluno.new(hashTable)
        aluno.save
    when "estados"
        estado=Estado.new(hashTable)
        estado.save
    when "matriculas"
        matricula=Matricula.new(hashTable)
        matricula.save
    when "alunos_departamentos"
        hashs=hashTableAlDp(entrada)
        hashs.each do |hashEncontrada|
            alDp=AlunosDepartamento.new(hashEncontrada)
            alDp.save
        end
    else
        printf("Tabela inexistente \n")
    end
end
