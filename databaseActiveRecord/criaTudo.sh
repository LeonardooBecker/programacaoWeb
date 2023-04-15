rm -f Tabelas.sqlite3
echo -n "criaEstados ..."
ruby criaEstados.rb 
echo "Ok"
echo -n "criaAlunoDepartamento ..."
ruby criaAlunoDepartamento.rb
echo "Ok"
echo -n "criaAlunos ..."
ruby criaAlunos.rb
echo "Ok"
echo -n "criaCodigos ..."
ruby criaCodigos.rb 
echo "Ok"
echo -n "criaDepartamentos ..."
ruby criaDepartamentos.rb 
echo "Ok"
echo -n "criaDisciplinas ..."
ruby criaDisciplinas.rb 
echo "Ok"
echo -n "criaMatriculas ..."
ruby criaMatriculas.rb 
echo "Ok"


# echo -n "populaEstados ..."
# ruby populaEstados.rb
# echo "Ok"
# echo -n "populaPessoas ..."
# ruby populaPessoasD.rb
# echo "Ok"
# echo -n "populaMunicipios ..."
# ruby populaMunicipos.rb
# echo "Ok"
# echo -n "populaEsportes ..."
# ruby populaEsportes.rb
# echo "Ok"
# echo -n "populaPessoasEsportes ..."
# ruby populaPessoaEsporte.rb
# echo "Ok"