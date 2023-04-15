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


def alteraTupla()
    tabela=ARGV[1]
    hashTables=hashTableAlteracao()
    hashTableAtual=hashTables[0]
    hashTableNova=hashTables[1]
    case tabela
    when "departamentos"
        departamento=Departamento.find_by(hashTableAtual)
        departamento.update(hashTableNova)
    when "disciplinas"
        disciplina=Disciplina.find_by(hashTableAtual)
        disciplina.update(hashTableNova)
    when "codigos"
        codigo=Codigo.find_by(hashTableAtual)
        codigo.update(hashTableNova)
    when "alunos"
        aluno=Aluno.find_by(hashTableAtual)
        aluno.update(hashTableNova)
    when "estados"
        estado=Estado.find_by(hashTableAtual)
        estado.update(hashTableNova)
    when "matriculas"
        matricula=Matricula.find_by(hashTableAtual)
        matricula.update(hashTableNova)
    when "alunos_departamentos"
        alDp=AlunosDepartamento.find_by(hashTableAtual)
        alDp.update(hashTableNova)
    end
end