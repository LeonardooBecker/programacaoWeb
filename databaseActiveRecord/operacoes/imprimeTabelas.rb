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

ActiveRecord::Base.establish_connection:adapter=>"sqlite3",
                                        :database=>"Tabelas.sqlite3"


def imprimeDepartamento(tabela)
    lines=Departamento.all
    tables=Departamento.connection.columns(tabela).map(&:name)
    tables.each do |name|
        printf("%-20s  ",name)
    end
    print "\n"
    lines.each do |tupla|
        tables.each do |column|
            printf("| %-20s",tupla[column])
        end
        print "\n"
    end
end

def imprimeDisciplina(tabela)
    lines=Disciplina.all
    tables=Disciplina.connection.columns(tabela).map(&:name)
    tables.each do |name|
        printf("%-20s  ",name)
    end
    print "\n"
    lines.each do |tupla|
        tables.each do |column|
            printf("| %-20s",tupla[column])
        end
        print "\n"
    end
end

def imprimeCodigos(tabela)
    lines=Codigo.all
    tables=Codigo.connection.columns(tabela).map(&:name)
    tables.each do |name|
        printf("%-20s  ",name)
    end
    print "\n"
    lines.each do |tupla|
        tables.each do |column|
            printf("| %-20s",tupla[column])
        end
        print "\n"
    end
end

def imprimeAlunos(tabela)
    lines=Aluno.all
    tables=Aluno.connection.columns(tabela).map(&:name)
    tables.each do |name|
        printf("%-20s  ",name)
    end
    print "\n"
    lines.each do |tupla|
        tables.each do |column|
            printf("| %-20s",tupla[column])
        end
        print "\n"
    end
end

def imprimeEstados(tabela)
    lines=Estado.all
    tables=Estado.connection.columns(tabela).map(&:name)
    tables.each do |name|
        printf("%-20s  ",name)
    end
    print "\n"
    lines.each do |tupla|
        tables.each do |column|
            printf("| %-20s",tupla[column])
        end
        print "\n"
    end
end

def imprimeMatriculas(tabela)
    lines=Matricula.all
    tables=Matricula.connection.columns(tabela).map(&:name)
    tables.each do |name|
        printf("%-20s  ",name)
    end
    print "\n"
    lines.each do |tupla|
        tables.each do |column|
            printf("| %-20s",tupla[column])
        end
        print "\n"
    end
end

def imprimeAlunosDepartamento(tabela)
    lines=AlunosDepartamento.all
    tables=AlunosDepartamento.connection.columns(tabela).map(&:name)
    tables.each do |name|
        printf("%-20s  ",name)
    end
    print "\n"
    lines.each do |tupla|
        tables.each do |column|
            printf("| %-20s",tupla[column])
        end
        print "\n"
    end
end
