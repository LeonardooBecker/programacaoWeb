rm -f Tabelas.sqlite3
echo -n "criaEstados ..."
ruby criaTabelas/criaEstados.rb 
echo "Ok"
echo -n "criaAlunoDepartamento ..."
ruby criaTabelas/criaAlunoDepartamento.rb
echo "Ok"
echo -n "criaAlunos ..."
ruby criaTabelas/criaAlunos.rb
echo "Ok"
echo -n "criaCodigos ..."
ruby criaTabelas/criaCodigos.rb 
echo "Ok"
echo -n "criaDepartamentos ..."
ruby criaTabelas/criaDepartamentos.rb 
echo "Ok"
echo -n "criaDisciplinas ..."
ruby criaTabelas/criaDisciplinas.rb 
echo "Ok"
echo -n "criaMatriculas ..."
ruby criaTabelas/criaMatriculas.rb 
echo "Ok"