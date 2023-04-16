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


ActiveRecord::Base.establish_connection:adapter=>"sqlite3",
                                        :database=>"Tabelas.sqlite3"




def insereTupla()
    tabela=ARGV[1]
    if(tabela!="alunos_departamentos")
        hashTable=hashTableInsercao()
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
        hashs=hashTableAlDp()
        hashs.each do |hashEncontrada|
            alDp=AlunosDepartamento.new(hashEncontrada)
            alDp.save
        end
    end
end
