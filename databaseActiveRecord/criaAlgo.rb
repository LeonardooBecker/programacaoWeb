require 'active_record'

ActiveRecord::Base.establish_connection:adapter=>"sqlite3",:database=>"Tabelas.sqlite3"

class Pessoa < ActiveRecord::Base;
    belongs_to:estado, dependent: :destroy
end



# class Pessoa <ActiveRecord::Base;
# end

class Estado < ActiveRecord::Base;
end


p = Pessoa.new({:sobrenome=>"SILVa",:nome=>"JOAO",:endereco=>"rua1"})
# p.save
est = Estado.find_by_sigla("PR")
# puts est.nome
p.estado=est
p.save


# pessoas=Pessoa.all
# pessoas.each do |t|
#     t.delete
# end