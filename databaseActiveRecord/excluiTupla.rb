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




def excluiTupla()
    tabela=ARGV[1]
    hashs=hashTableExclusao()
    hashs.each do |hashTable|
        case tabela
        when "departamentos"
            if !hashTable.empty?
                departamento=Departamento.where(hashTable)
                if departamento.empty?
                    printf("Não foram encontrados valores validos\n")
                end
                departamento.destroy_all
            end
        when "disciplinas"
            if !hashTable.empty?
                disciplina=Disciplina.where(hashTable)
                if disciplina.empty?
                    printf("Não foram encontrados valores validos\n")
                end
                disciplina.destroy_all
            end
        when "codigos"
            if !hashTable.empty?
                codigo=Codigo.where(hashTable)
                if codigo.empty?
                    printf("Não foram encontrados valores validos\n")
                end
                codigo.destroy_all
            end
        when "alunos"
            if !hashTable.empty?
                aluno=Aluno.where(hashTable)
                if aluno.empty?
                    printf("Não foram encontrados valores validos\n")
                end
                aluno.destroy_all
            end
        when "estados"
            if !hashTable.empty?
                estado=Estado.where(hashTable)
                if estado.empty?
                    printf("Não foram encontrados valores validos\n")
                end
                estado.each do |t|
                    t.alunos.each(&:destroy)
                end
                estado.destroy_all
            end
        when "matriculas"
            if !hashTable.empty?
                matricula=Matricula.where(hashTable)
                if matricula.empty?
                    printf("Não foram encontrados valores validos\n")
                end
                matricula.destroy_all
            else
                printf("Dado não encontrado")
            end

        when "alunos_departamentos"
            if !hashTable.empty?
                alDp=AlunosDepartamento.where(hashTable)
                if alDp.empty?
                    printf("Não foram encontrados valores validos\n")
                end
                alDp.destroy_all
            end
        end
    end
end