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
            departamento=Departamento.where(hashTable)
            departamento.destroy_all
        when "disciplinas"
            disciplina=Disciplina.where(hashTable)
            disciplina.destroy_all
        when "codigos"
            codigo=Codigo.where(hashTable)
            codigo.destroy_all
        when "alunos"
            aluno=Aluno.where(hashTable)
            aluno.destroy_all
        when "estados"
            estado=Estado.where(hashTable)
            estado.each do |t|
                t.alunos.each(&:destroy)
            end
                estado.destroy_all
        when "matriculas"
            matricula=Matricula.where(hashTable)
            matricula.destroy_all
        when "alunos_departamentos"
            alDp=AlunosDepartamento.where(hashTable)
            alDp.destroy_all
        end
    end
end