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


def alteraTupla(entrada)
    tabela=entrada[1]
    hashTables=hashTableAlteracao(entrada)
    hashTableAtual=hashTables[0]
    hashTableNova=hashTables[1]
    case tabela
    when "departamentos"
        departamento=Departamento.find_by(hashTableAtual)
        if(departamento!=nil)
            departamento.update(hashTableNova)
        else
            printf("departamento não encontrado\n")
        end
    when "disciplinas"
        disciplina=Disciplina.find_by(hashTableAtual)
        if(disciplina!=nil)
            disciplina.update(hashTableNova)
        else
            printf("disciplina não encontrado\n")
        end
    when "codigos"
        codigo=Codigo.find_by(hashTableAtual)
        if(codigo!=nil)
            codigo.update(hashTableNova)
        else
            printf("codigo não encontrado\n")
        end
    when "alunos"
        aluno=Aluno.find_by(hashTableAtual)
        if(aluno!=nil)
            aluno.update(hashTableNova)
        else
            printf("aluno não encontrado\n")
        end
    when "estados"
        estado=Estado.find_by(hashTableAtual)
        if(estado!=nil)
            estado.update(hashTableNova)
        else
            printf("estado não encontrado\n")
        end
    when "matriculas"
        matricula=Matricula.find_by(hashTableAtual)
        if(matricula!=nil)
            matricula.update(hashTableNova)
        else
            printf("matricula não encontrada\n")
        end
    when "alunos_departamentos"
        alDp=AlunosDepartamento.find_by(hashTableAtual)
        if(alDp!=nil)
            alDp.update(hashTableNova)
        else
            printf("aluno ou departamento não encontrado\n")
        end
    else
        printf("Tabela inexistente\n")
    end
end