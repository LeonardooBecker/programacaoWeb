require 'active_record'

ActiveRecord::Base.establish_connection:adapter=>"sqlite3",
                                        :database=>"Tabelas.sqlite3"

# ActiveRecord::Base.connection.create_table :pessoas do |t|
#     t.string:sobrenome
#     t.string:nome
#     t.string:endereco
#     t.belongs_to :estado,foreign_key:true
# end

class Estado < ActiveRecord::Base;
    has_many :pessoas, dependent: :destroy
end

class Pessoa < ActiveRecord::Base;
    belongs_to :estado
end

est=Estado.find_by_sigla("PR")
est.destroy

# pes=Pessoa.new()
# pes.nome="LEONARDO"
# pes.sobrenome="BECKER"
# pes.endereco="RUA AUGUSTA"
# pes.estado=est
# pes.save

# estados= Estado.all
# estados.each do |estado|
#     pessoas=estado.pessoas
    
#     # puts estado.nome
#     # # pessoas=estado.pessoas
#     pessoas.each do |m|
#         puts m.nome
#     end
# end