# Trabalho 5: (Framework Web) Aplicação Rails

### Tabelas

* **departamentos** (nome, campus)
* **estados** (nome, sigla)
* **alunos** (nome, sobrenome, *estado_id*)
* **alunos_departamentos** (*aluno_id*, *departamento_id*)
* **users** (*email*, *password*, *role*)

### Relações existentes

**Relação N:N**   

* Um departamento possui N alunos, e os alunos estão em N departamentos.

**Relação 1:N**   

* Um estado possui muitos alunos, mas cada aluno so pertence a 1 estado.

**Relação 1:1**   

* Cada aluno so possui 1 matrícula, assim como 1 matrícula so esta associada a um aluno.     

### Utilizaçao

* Para acessar qualquer tabela é neccessário estar logado.

* Usuários podem visualizar as tabelas.

* Administradores podem visualizar e modificar as tabelas.

### Aplicação do jquery

* Ao pressionar sobre um elemento presente na tabela, um modal aparece apresentando as informações do elemento, assim como disponibilizando as opções de alterar e excluir elemento.

