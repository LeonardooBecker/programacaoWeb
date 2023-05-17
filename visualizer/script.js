var url = "./alunos.xml";

$('#btn').on("click", press);

function press() {
    loadDoc();
    aluno = $("#grr").val();
    $("h1").css({ "color": "red" });
}

console.log($("#grr").val());

function loadDoc() {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            myFunction(this);
        }
    };
    xhttp.open("GET", "./alunos.xml", true);
    xhttp.send();
}


function limpaTabela() {
    grade = $("td").removeClass();
}


let codigo;
let vetorr = [];

function myFunction(xml) {
    var i;
    var xmlDoc = xml.responseXML;

    var x = xmlDoc.getElementsByTagName("ALUNO");

    console.log(aluno)
    vetorGrade = []
    grade = $(".table-light");

    limpaTabela(grade);

    for (i = 0; i < grade.length; i++) {
        vetorGrade.push($(grade[i]).find("b").text());
    }

    vetorr = [];
    for (i = 0; i < x.length; i++) {

        matricula = x[i].getElementsByTagName("MATR_ALUNO")[0].childNodes[0].nodeValue;

        if (matricula == aluno) {

            codigo = x[i].getElementsByTagName("COD_ATIV_CURRIC")[0].childNodes[0].nodeValue;
            nomeDiscplina = x[i].getElementsByTagName("NOME_ATIV_CURRIC")[0].childNodes[0].nodeValue;
            ano = x[i].getElementsByTagName("ANO")[0].childNodes[0].nodeValue;
            periodo = x[i].getElementsByTagName("PERIODO")[0].childNodes[0].nodeValue;
            situacao = x[i].getElementsByTagName("SITUACAO")[0].childNodes[0].nodeValue;
            nota = x[i].getElementsByTagName("MEDIA_FINAL")[0].childNodes[0].nodeValue;
            frequencia = x[i].getElementsByTagName("FREQUENCIA")[0].childNodes[0].nodeValue;

            for (j = 0; j < vetorGrade.length; j++) {

                if ((codigo == vetorGrade[j])) {

                    vetorr.push([codigo, nomeDiscplina, ano, periodo, situacao, nota, frequencia]);

                    ft = $(grade[j]);
                    if ((situacao == "Reprovado por nota") || (situacao == "Reprovado por Frequência")) {
                        ft.removeClass();
                        ft.addClass("reprovado");
                    }
                    else if (situacao == "Aprovado") {
                        ft.removeClass();
                        ft.addClass("aprovado");
                    }
                    else if (situacao == "Matrícula") {
                        ft.removeClass();
                        ft.addClass("matricula");
                    }
                    else if (situacao == "Equivalência de Disciplina") {
                        ft.removeClass();
                        ft.addClass("equivalencia")
                    }
                }
            }

        }
    }
    vetorr.sort();
}

$("td").click(function () {
    codigo = ($(this).find("b").text());
    vetEspecifico = [];
    for (i = 0; i < vetorr.length; i++) {
        if (vetorr[i][0] == codigo) {
            vetEspecifico.push(vetorr[i]);
        }
    }
    console.log(vetEspecifico);
    $("#modal").show();
    // console.log(vetEspecifico[(vetEspecifico.length-1)])
    // console.log(vetorr);
});

$("td").on("contextmenu", function (event) {
    event.preventDefault();
    codigo = $(this).find("b").text();
    console.log(codigo);
    $("#modal").show();
});




$(document).ready(function () {

    $("#closeModal").click(function () {
        $("#modal").hide();
    });

    $(document).keyup(function(event) {
        if (event.key === "Escape") {
          $("#modal").hide();
        }
      });

    $(window).click(function (event) {
        if (event.target == $("#modal")[0]) {
            $("#modal").hide();
        }
    });
});

