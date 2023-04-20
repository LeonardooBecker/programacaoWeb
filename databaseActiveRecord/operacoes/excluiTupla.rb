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




def excluiTupla(entrada)
    tabela=entrada[1]
    hashs=hashTableExclusao(entrada)
    hashs.each do |hashTable|
        case tabela
        when "departamentos"
            if !hashTable.empty?
                departamento=Departamento.where(hashTable)
                if departamento.empty?
                    printf("Não foram encontrados valores validos - Departamentos\n")
                end
                departamento.destroy_all
                return
            end
        when "disciplinas"
            if !hashTable.empty?
                disciplina=Disciplina.where(hashTable)
                if disciplina.empty?
                    printf("Não foram encontrados valores validos - Disciplinas \n")
                end
                disciplina.destroy_all
                return
            end
        when "codigos"
            if !hashTable.empty?
                codigo=Codigo.where(hashTable)
                if codigo.empty?
                    printf("Não foram encontrados valores validos - Codigos\n")
                end
                codigo.destroy_all
                return
            end
        when "alunos"
            if !hashTable.empty?
                aluno=Aluno.where(hashTable)
                if aluno.empty?
                    printf("Não foram encontrados valores validos - Alunos\n")
                end
                aluno.destroy_all
                return
            end
        when "estados"
            if !hashTable.empty?
                estado=Estado.where(hashTable)
                if estado.empty?
                    printf("Não foram encontrados valores validos - Estados \n")
                end
                estado.each do |t|
                    t.alunos.each(&:destroy)
                end
                estado.destroy_all
                return
            end
        when "matriculas"
            if !hashTable.empty?
                matricula=Matricula.where(hashTable)
                if matricula.empty?
                    printf("Não foram encontrados valores validos - Matriculas \n")
                end
                matricula.destroy_all
                return
            end
        when "alunos_departamentos"
            if !hashTable.empty?
                alDp=AlunosDepartamento.where(hashTable)
                if alDp.empty?
                    printf("Não foram encontrados valores validos - AlunosDepartamentos\n")
                end
                alDp.destroy_all
                return
            end
        else
            printf("Tabela inexistente\n")
        end
    end
end