require 'active_record'

ActiveRecord::Base.establish_connection:adapter=>"sqlite3",
                                        :database=>"Tabelas.sqlite3"

# ActiveRecord::Base.connection.create_table :departamentos do |t|
#     t.string :name
#     t.string :campus
# end

# ActiveRecord::Base.connection.create_table :mates do |t|
#     t.string :name
#     t.string :horas
#     t.belongs_to :departamento,foreign_key: true
# end

# ActiveRecord::Base.connection.create_table :codigos do |t|
#     t.string :codigo
#     t.belongs_to :mate, foreign_key: true
# end

# ActiveRecord::Base.connection.create_table :departamentos_pessoas do |t|
#     t.references :departamento
#     t.references :pessoa
# end

class Departamento < ActiveRecord::Base
    has_many :mates, dependent: :destroy
    has_and_belongs_to_many :pessoas, dependent: :destroy
end

class Mate < ActiveRecord::Base
    belongs_to :departamento
    has_one :codigo, dependent: :destroy
end

class Codigo < ActiveRecord::Base
    belongs_to :mate
end

class Estado < ActiveRecord::Base;
    has_many :pessoas, dependent: :destroy
end

class Pessoa < ActiveRecord::Base
    belongs_to :estado
    has_and_belongs_to_many :departamentos, dependent: :destroy
end

# est=Estado.find_by({:sigla=>"PR"})
# puts est.nome

# pes=Pessoa.new()
# pes.nome="LEONARDO"
# pes.endereco="RUA1"
# pes.estado=est
# pes.save


dep1=Departamento.find_by({:name=>"DINF"})
puts dep1.name
pessoas=Pessoa.all
pessoas.each do |pessoa|
    puts pessoa.nome
    pessoa.departamentos << dep1
end


# dep=Departamento.new(:name=>"DINF", :campus=>"POLI")
# dep.save

# dep=Departamento.find_by({:name=>"DINF"})
# puts dep.campus

# mat=Mate.new()
# mat.name="PROGWEB"
# mat.horas="60"
# mat.departamento=dep
# mat.save

# mat=Mate.find_by({:horas=>"60"})
# puts mat.name

# cod=Codigo.new()
# cod.codigo="1126"
# cod.mate=mat
# cod.save



# departamentos=Departamento.all
# departamentos.each do |dep|
#     dep.destroy
#     # puts dep.name
#     # mats=dep.mates
#     # mats.each do |t|
#     #     puts t.name
#     # end
# end