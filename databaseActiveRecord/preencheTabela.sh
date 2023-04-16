ruby menu.rb insere estados nome="Parana" sigla="PR"
ruby menu.rb insere estados nome="Belo Horizonte" sigla="BH"
ruby menu.rb insere estados nome="Santa Catarina" sigla="SC"
ruby menu.rb insere estados nome="Sao Paulo" sigla="SP"
ruby menu.rb insere estados nome="Rio de Janeiro" sigla="RJ"
ruby menu.rb insere estados nome="Rio Grande do Sul" sigla="RS"
ruby menu.rb insere estados nome="Acre" sigla="AC"
ruby menu.rb insere estados nome="Alagoas" sigla="AL"
ruby menu.rb insere estados nome="Espirito Santo" sigla="ES"
ruby menu.rb insere estados nome="Roraima" sigla="RR"

ruby menu.rb insere departamentos nome="Ciencias Agrarias" campus="Agrarias"
ruby menu.rb insere departamentos nome="Ciencias Biologicas" campus="Botanico"
ruby menu.rb insere departamentos nome="Ciencias da Terra" campus="Politecnico"
ruby menu.rb insere departamentos nome="Ciencias Exatas" campus="Politecnico"
ruby menu.rb insere departamentos nome="Ciencias Humanas" campus="Centro"
ruby menu.rb insere departamentos nome="Ciencias Juridicas" campus="Centro"
ruby menu.rb insere departamentos nome="Ciencias Educacao" campus="Reboucas"
ruby menu.rb insere departamentos nome="Ciencias Tecnologicas" campus="Politecnico"

ruby menu.rb insere disciplinas nome="Agronomia" professor="Cesar" departamento_id="campus='Agrarias'"
ruby menu.rb insere disciplinas nome="Biologia" professor="Roberto" departamento_id="nome='Ciencias Biologicas'"
ruby menu.rb insere disciplinas nome="Geologia" professor="Marcela" departamento_id="nome='Ciencias da Terra'"
ruby menu.rb insere disciplinas nome="Automacao" professor="Fernando" departamento_id="campus='Politecnico'"
ruby menu.rb insere disciplinas nome="Direito" professor="Marcelo" departamento_id="nome='Ciencias Juridicas'"
ruby menu.rb insere disciplinas nome="Pedagogia" professor="Juliana" departamento_id="campus='Reboucas'"
ruby menu.rb insere disciplinas nome="Programacao" professor="Gabriela" departamento_id="nome='Ciencias Tecnologicas'"
ruby menu.rb insere disciplinas nome="Psicologia" professor="Kant" departamento_id="nome='Ciencias Humanas'"

ruby menu.rb insere codigos codigo="AG1062" disciplina_id="nome='Agronomia'"
ruby menu.rb insere codigos codigo="BL1556" disciplina_id="nome='Biologia'"
ruby menu.rb insere codigos codigo="GG1046" disciplina_id="nome='Geologia'"
ruby menu.rb insere codigos codigo="AT3618" disciplina_id="nome='Automacao'"
ruby menu.rb insere codigos codigo="DP1456" disciplina_id="professor='Marcelo'"
ruby menu.rb insere codigos codigo="PG1069" disciplina_id="nome='Pedagogia'"
ruby menu.rb insere codigos codigo="CI1047" disciplina_id="professor='Gabriela"
ruby menu.rb insere codigos codigo="PS1749" disciplina_id="nome='Psicologia'"

ruby menu.rb insere alunos nome="Lara" sobrenome="Vieira" estado_id="sigla='PR'"
ruby menu.rb insere alunos nome="Gabriel" sobrenome="Oliveira" estado_id="nome='Acre'"
ruby menu.rb insere alunos nome="Marina" sobrenome="Santos" estado_id="nome='Santa Catarina'"
ruby menu.rb insere alunos nome="Henrique" sobrenome="Silva" estado_id="sigla='AC'"
ruby menu.rb insere alunos nome="Julia" sobrenome="Rodrigues" estado_id="sigla='RS'"
ruby menu.rb insere alunos nome="Lucas" sobrenome="Oliveira" estado_id="sigla='AC'"
ruby menu.rb insere alunos nome="Isabela" sobrenome="Fernandes" estado_id="nome='Roraima'"
ruby menu.rb insere alunos nome="Gabriel" sobrenome="Costa" estado_id="sigla='PR'"
ruby menu.rb insere alunos nome="Gabriel" sobrenome="Almeida" estado_id="nome='Parana'"
ruby menu.rb insere alunos nome="Ana" sobrenome="Souza" estado_id="sigla='RJ'"

ruby menu.rb insere matriculas ano=2021 complemento=1569 aluno_id="nome='Lara'"
ruby menu.rb insere matriculas ano=2019 complemento=1046 aluno_id="nome='Gabriel'"
ruby menu.rb insere matriculas ano=2021 complemento=1506 aluno_id="nome='Marina'"
ruby menu.rb insere matriculas ano=2021 complemento=1798 aluno_id="nome='Henrique'"
ruby menu.rb insere matriculas ano=2020 complemento=1089 aluno_id="nome='Julia'"
ruby menu.rb insere matriculas ano=2018 complemento=1079 aluno_id="nome='Lucas'"
ruby menu.rb insere matriculas ano=2021 complemento=1963 aluno_id="nome='Isabela'"
ruby menu.rb insere matriculas ano=2020 complemento=1367 aluno_id="sobrenome='Costa'"
ruby menu.rb insere matriculas ano=2020 complemento=1212 aluno_id="sobrenome='Almeida'"
ruby menu.rb insere matriculas ano=2021 complemento=1741 aluno_id="nome='Ana'"

ruby menu.rb insere alunos_departamentos aluno_id="nome='Lara'" departamento_id="campus='Centro'"
ruby menu.rb insere alunos_departamentos aluno_id="nome='Lara'" departamento_id="campus='Reboucas'"
ruby menu.rb insere alunos_departamentos aluno_id="nome='Henrique'" departamento_id="nome='Ciencias Tecnologicas'"
ruby menu.rb insere alunos_departamentos aluno_id="sobrenome='Costa'" departamento_id="campus='Botanico'"
ruby menu.rb insere alunos_departamentos aluno_id="nome='Marina'" departamento_id="campus='Centro'"
ruby menu.rb insere alunos_departamentos aluno_id="nome='Gabriel'" departamento_id="nome='Ciencias da Terra'"
ruby menu.rb insere alunos_departamentos aluno_id="nome='Lucas'" departamento_id="nome='Ciencias Exatas'"
ruby menu.rb insere alunos_departamentos aluno_id="nome='Julia'" departamento_id="nome='Ciencias Educacao'"
ruby menu.rb insere alunos_departamentos aluno_id="nome='Lara'" departamento_id="nome='Ciencias Biologicas'"
ruby menu.rb insere alunos_departamentos aluno_id="sobrenome='Almeida'" departamento_id="campus='Agrarias'"

ruby menu.rb lista alunos_departamentos
echo -e "\n\n"
ruby menu.rb lista departamentos
echo -e "\n\n"
ruby menu.rb lista disciplinas
echo -e "\n\n"
ruby menu.rb lista codigos
echo -e "\n\n"
ruby menu.rb lista alunos
echo -e "\n\n"
ruby menu.rb lista estados
echo -e "\n\n"
ruby menu.rb lista matriculas
echo -e "\n\n"

ruby menu.rb exclui alunos_departamentos aluno_id="nome='Lara'"
ruby menu.rb exclui alunos_departamentos departamento_id="nome='Ciencias da Terra'"
ruby menu.rb altera alunos_departamentos aluno_id="nome='Gabriel' sobrenome='Costa'" aluno_id="nome='Marina'"

ruby menu.rb exclui departamentos nome="Ciencias Humanas"
ruby menu.rb exclui departamentos campus="Agrarias"
ruby menu.rb altera departamentos nome="Ciencias Educacao" nome="Ciencias Educacionais"

ruby menu.rb exclui disciplinas nome="Automacao"
ruby menu.rb exclui disciplinas professor="Roberto"
ruby menu.rb exclui disciplinas departamento_id="campus='Centro'"
ruby menu.rb altera disciplinas departamento_id="nome='Ciencias Tecnologicas'" departamento_id="nome='Ciencias Educacionais'"

ruby menu.rb exclui codigos codigo="GG1046"
ruby menu.rb exclui codigos disciplina_id="nome='Pedagogia'"
ruby menu.rb altera codigos codigo="CI1047" codigo="PG1566"

ruby menu.rb exclui estados nome="Acre"
ruby menu.rb exclui estados sigla="AL"
ruby menu.rb altera estados nome="Rio Grande do Sul" nome="Bahia" sigla="RS" sigla="BA"

ruby menu.rb exclui alunos nome="Julia"
ruby menu.rb exclui alunos sobrenome="Almeida"
ruby menu.rb exclui alunos estado_id="nome='Rio de Janeiro'"
ruby menu.rb altera alunos estado_id="nome='Roraima'" estado_id="sigla='SP'"

ruby menu.rb exclui matriculas ano=2020
ruby menu.rb exclui matriculas complemento=1963
ruby menu.rb exclui matriculas aluno_id="nome='Lara'"
ruby menu.rb altera matriculas complemento=1506 complemento=1823


ruby menu.rb lista alunos_departamentos
echo -e "\n\n"
ruby menu.rb lista departamentos
echo -e "\n\n"
ruby menu.rb lista disciplinas
echo -e "\n\n"
ruby menu.rb lista codigos
echo -e "\n\n"
ruby menu.rb lista alunos
echo -e "\n\n"
ruby menu.rb lista estados
echo -e "\n\n"
ruby menu.rb lista matriculas
echo -e "\n\n"