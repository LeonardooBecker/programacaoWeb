# Trabalho 2 - Banco de Dados usando ActiveRecord

## Estruturas

### Tabelas

* **departamentos** (nome, campus)
* **estado** (nome, sigla)
* **alunos** (nome, sobrenome, *estado_id*)
* **alunos_departamentos** (*aluno_id*, *departamento_id*)
* **matriculas** (ano, complemento, *aluno_id*)
* **disciplinas** (nome, professor, *departamento_id*)
* **codigos**(codigo, *disciplina_id*)

### Relações existentes

**Relação N:N**   

* Um departamento possui N alunos, e os alunos estão em N departamentos.

**Relação 1:N**   

* Um departamento possui muitas disciplinas, mas cada disciplina so pertence a 1 departamento.
* Um estado possui muitos alunos, mas cada aluno so pertence a 1 estado.

**Relação 1:1**   

* Uma disciplina so possui 1 código, assim como 1 código só esta associado a uma disciplina.
* Cada aluno so possui 1 matrícula, assim como 1 matrícula so esta associada a um aluno.     

<img src="./diagrama.png" alt="Diagrama" width="400">

## Criar database

### Forma manual:

~~~ruby
ruby cria"Tabela".rb
~~~
_Do qual:_ "Tabela" é substituído pela tabela que deseja ser criado.

### Forma automática:
~~~bash
./criaTudo.sh
~~~
_Do qual:_ Todas as tabelas disponíveis serão criadas automaticamente


## Iniciar programa principal

### Para inserção manual

~~~ruby
ruby menu.rb
~~~
_Com esse chamado, o programa entra em modo de execução permitindo usar os Comandos para interação com o bando de dados_

### Para inserção automática de valores
~~~ruby
ruby menu.rb 1
~~~
_Chamando dessa maneira, o banco de dados é preenchido com os comandos existentes em "arquivoPreenchimento.txt"_


## Comandos
Os comandos seguem uma formatação semelhante:
~~~bash
< operação > < tabela > { atributo=valor }
~~~

### Operação
* **insere** : Insere valores na tabela com os atributos e valores passados.
~~~bash
insere alunos nome="Leonardo"
~~~
* **exclui** : Exclui valores da tabela de acordo com os atributos e valores passados.
~~~bash
exclui alunos nome="Leonardo"
~~~
* **altera** : Altera os valores da tabela. Importante passar os valores já existentes e os novos desejados,para o correto funcionamento.
~~~bash
altera alunos nome="Leonardo" nome="João"
~~~ 
* **lista** : Lista a tabela informada, nesse comando não são necessários atributos e valores.
~~~bash
lista alunos
~~~

### Tabela
Neste campo é possível escolher a trabalha que se deseja interagir, dentre as criadas e definidas.

### Atributo e valor
Permitindo repetição, nesse campo são inseridos todos os atributos e valores do qual se deseja operar.
