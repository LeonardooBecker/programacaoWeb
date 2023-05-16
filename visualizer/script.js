var url = "./alunos.xml";
var vet = [];
var dual = [];
let aluno="GRR00000000"
$.ajax({
    url: url,
    dataType: "xml",
    success: function (xml) {
        $(xml).find('ALUNO').each(function() {
            // sit = $(this).find("SITUACAO").text();
            // console.log(sit)
            // ano = $(this).find("ANO").text();
            // if (!vet.includes(cod)) {
            //     vet.push(cod);
            //     dual.push([cod, sit])
            // }
            // $(".table-light").append(
            //     `<div class="card">
            //         <p class="nome">${$(this).find("NOME_ALUNO").text()}</p>
            //         <p class="codigo">${$(this).find("COD_ATIV_CURRIC").text()}</p>
            //     </div>`
            // );
        });
        // console.log(dual)
        sucess(dual);
    },
    error: function () {
        alert("Erro ao carregar o arquivo XML.");
    }
});

function sucess(vet) {
    const vt = document.querySelectorAll(".table-light");
    $(document).ready(function(){
        console.log($("#class"));
    });
    // mats=[]
    // console.log(vet);
    // for (i = 0; i < vt.length; i++)
    // {
    //     materia=vt[i].textContent.split(" ");
    //     for(j=0;j<vet.length;j++)
    //     {
    //         if((materia[0])==(vet[j][0]))
    //             vt[i].classList.add("table");
    //     }
    //     // vt[i].classList.add("table");
    // }
}
