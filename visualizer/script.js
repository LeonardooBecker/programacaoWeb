var url = "./alunos.xml";

$(document).keydown(function (event) {
    if (event.which === 13) {
        aluno = ($("#grr").val());
        loadDoc();
    }
});


let codigo;
let vetorr = [];
let allMatriculas = [];
var aluno = "";
var attMatricula = 0;

$(document).ready(function () {
    loadDoc();
});


function updateMatriculas() {
    if (attMatricula == 0) {
        for (i = 0; i < allMatriculas.length; i++) {
            info = "<option>" + allMatriculas[i] + "</option>"
            $("#stds").append(info);
        }
        attMatricula = 1
    }
}

function loadDoc() {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            myFunction(this);
            updateMatriculas();
        }
    };
    xhttp.open("GET", "./alunos.xml", true);
    xhttp.send();
}


function limpaTabela() {
    grade = $("td").removeClass();
    grade = $("td").addClass("none");
}

function tabelaInvalida() {
    grade = $("td").removeClass();
}


function myFunction(xml) {
    var i;
    var xmlDoc = xml.responseXML;

    var x = xmlDoc.getElementsByTagName("ALUNO");

    vetorGrade = []
    grade = $("#grade td");

    if (allMatriculas.includes(aluno)) {
        limpaTabela();
    }
    else
        tabelaInvalida();

    for (i = 0; i < grade.length; i++) {
        vetorGrade.push($(grade[i]).find("b").text());
    }
    vetorr = [];
    for (i = 0; i < x.length; i++) {

        matricula = x[i].getElementsByTagName("MATR_ALUNO")[0].childNodes[0].nodeValue;
        if (!allMatriculas.includes(matricula))
            allMatriculas.push(matricula);

        if (matricula == aluno) {

            codigo = x[i].getElementsByTagName("COD_ATIV_CURRIC")[0].childNodes[0].nodeValue;
            nomeDiscplina = x[i].getElementsByTagName("NOME_ATIV_CURRIC")[0].childNodes[0].nodeValue;
            ano = x[i].getElementsByTagName("ANO")[0].childNodes[0].nodeValue;
            periodo = x[i].getElementsByTagName("PERIODO")[0].childNodes[0].nodeValue;
            situacao = x[i].getElementsByTagName("SITUACAO")[0].childNodes[0].nodeValue;
            nota = x[i].getElementsByTagName("MEDIA_FINAL")[0].childNodes[0].nodeValue;
            frequencia = x[i].getElementsByTagName("FREQUENCIA")[0].childNodes[0].nodeValue;
            frequencia = parseFloat(frequencia).toFixed(2);
            atv = x[i].getElementsByTagName("DESCR_ESTRUTURA")[0].childNodes[0].nodeValue;

            if (atv == "Trabalho de Graduação I") {
                codigo = "TG I"
            }
            else if (atv == "Trabalho de Graduação II") {
                codigo = "TG II"
            }

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
                    else if ((situacao == "Equivalência de Disciplina") || (situacao == "Dispensa de Disciplinas (com nota)")) {
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
    dado = vetEspecifico[(vetEspecifico.length - 1)];
    if (dado == null) {
        $("#clickHeader").hide();
        $("#clickBody").hide();
        $(".modal-content table").hide();
        $(".modal-content p").remove();
        $(".modal-content").append("<p>Histórico inexistente</p>")
    }
    else {
        $("#clickBody").empty();
        $(".modal-content p").remove();
        $(".modal-content table").show();
        info = "<tr>"
        for (i = 0; i < dado.length; i++) {
            info = info + "<td>" + dado[i] + "</td>"
        }
        info = info + "</tr>"
        $("#clickBody").append(info);
        $("#clickHeader").show();
        $("#clickBody").show();
    }
    $("#modal").show();

});

$("td").on("contextmenu", function (event) {
    event.preventDefault();
    codigo = $(this).find("b").text();
    vetEspecifico = [];
    for (i = 0; i < vetorr.length; i++) {
        if (vetorr[i][0] == codigo) {
            vetEspecifico.push(vetorr[i]);
        }
    }
    if ((vetEspecifico.length) == 0) {
        $("#clickHeader").hide();
        $("#clickBody").hide();
        $(".modal-content table").hide();
        $(".modal-content p").remove();
        $(".modal-content").append("<p>Histórico inexistente</p>")
    }
    else {
        $("#clickBody").empty();
        $(".modal-content p").remove();
        $(".modal-content table").show();
        for (i = 0; i < vetEspecifico.length; i++) {
            info = "<tr>"
            dado = vetEspecifico[i];
            for (j = 0; j < dado.length; j++) {
                info = info + "<td>" + dado[j] + "</td>"
            }
            info = info + "</tr>"
            $("#clickBody").append(info);
        }
        $("#clickHeader").show();
        $("#clickBody").show();
    }
    $("#modal").show();
});


$(document).ready(function () {

    $("#closeModal").click(function () {
        $("#modal").hide();
    });

    $(document).keyup(function (event) {
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

// $(document).ready(function () {

//     let iguais = 0;
//     $("#grr").on("input", function () {
//         input = $(this).val();
//         $("#autocomplete").empty();
//         for (i = 0; i < allMatriculas.length; i++) {
//             iguais = 1;
//             for (j = 0; j < input.length; j++) {
//                 if (allMatriculas[i][j] != input[j])
//                     iguais = 0;
//             }
//             if ((iguais == 1) && (input.length != 0)) {
//                 substr = allMatriculas[i].slice(input.length, allMatriculas.length);
//                 info = "<p>" + "<span class='textComplete'>" + input + "</span>" + substr + "</p>"
//                 $("#autocomplete").append(info);
//             }
//             if (input == allMatriculas[i])
//                 $("#autocomplete").empty();
//         }
//     });
// });

$(function () {
    $(".autocomplete").autocomplete({
        source: allMatriculas
    });
});
