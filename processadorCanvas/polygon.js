var canvas = document.getElementById("myCanvas");
ctx = canvas.getContext("2d");

allRetas = []

lados = 6
inicio = 0

ctx.beginPath();
ctx.arc(canvas.width / 2, canvas.height / 2, 20, 0, Math.PI * 2, true);
ctx.strokeStyle = "green";
ctx.stroke();

while (1) {
    passo = ((Math.PI * 2) / lados);
    raio = 200
    sen1 = (Math.round(Math.sin(inicio) * raio));
    cos1 = (Math.round(Math.cos(inicio) * raio));
    sen2 = (Math.round(Math.sin(inicio + passo) * raio));
    cos2 = (Math.round(Math.cos(inicio + passo) * raio));

    reta = {}
    reta.x1 = canvas.width / 2 + sen1;
    reta.y1 = canvas.height / 2 + cos1;
    reta.x2 = canvas.width / 2 + sen2;
    reta.y2 = canvas.height / 2 + cos2;
    allRetas.push(reta)

    inicio += passo;
    if (inicio > (Math.PI * 2 - 0.3))
        break;
}

allCircles = []
for (i = 0; i < (allRetas.length); i++) {
    point = {}
    point.x = allRetas[i].x1;
    point.y = allRetas[i].y1;
    if (i != 0) {
        point.reta1 = allRetas[i]
        point.reta2 = allRetas[(i - 1)]
    }
    else {
        point.reta1 = allRetas[i]
        point.reta2 = allRetas[(allRetas.length - 1)]
    }
    allCircles.push(point)
}
console.log(allCircles)
console.log(allRetas);


function getEquation(reta) {
    // Calcula o coeficiente angular (slope) da reta
    const slope = (reta.y2 - reta.y1) / (reta.x2 - reta.x1);

    // Calcula o coeficiente linear (y-intercept) da reta
    const yIntercept = reta.y1 - slope * reta.x1;

    return { slope, yIntercept };
}

isMouseDown = false;
isCanto = false;
isLine = false;
canto = 0;


function drawLine(reta) {
    ctx.beginPath();
    ctx.moveTo(reta.x1, reta.y1);
    ctx.lineTo(reta.x2, reta.y2);
    ctx.strokeStyle = "black";
    ctx.lineWidth = 4;
    ctx.stroke();
}

function drawCircle(circulo) {
    ctx.beginPath();
    ctx.arc(circulo.x, circulo.y, 5, 0, Math.PI * 2, true);
    ctx.fill();
    ctx.stroke();
}

centrais = []
for (i = 0; i < allRetas.length; i++) {
    point = {}
    if (allRetas[i].x1 > allRetas[i].x2) {
        point.x = (allRetas[i].x1 - allRetas[i].x2) / 2 + allRetas[i].x2;
    }
    else
        point.x = (allRetas[i].x2 - allRetas[i].x1) / 2 + allRetas[i].x1;
    if (allRetas[i].y1 > allRetas[i].y2) {
        point.y = (allRetas[i].y1 - allRetas[i].y2) / 2 + allRetas[i].y2;
    }
    else
        point.y = (allRetas[i].y2 - allRetas[i].y1) / 2 + allRetas[i].y1;
    if (i != (allCircles.length - 1)) {
        point.circle1 = allCircles[i];
        point.circle2 = allCircles[i + 1];
    }
    else {
        point.circle1 = allCircles[i];
        point.circle2 = allCircles[0];
    }
    point.retaPertencente = allRetas[i];
    centrais.push(point)
}

console.log(centrais)

for (i = 0; i < centrais.length; i++)
    drawCircle(centrais[i]);
for (i = 0; i < (allRetas.length); i++) {
    drawLine(allRetas[i]);
    drawCircle(allCircles[i])
}



function moveLine(event, allCircles, indiceCircle) {
    const x = event.clientX - canvas.offsetLeft;
    const y = event.clientY - canvas.offsetTop;
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    for (i = 0; i < allRetas.length; i++) {
        drawLine(allRetas[i]);
        drawCircle(allCircles[i]);
        if (i == indiceCircle) {
            reta1 = (allCircles[i]).reta1;
            reta1.x1 = x;
            reta1.y1 = y;

            reta2 = (allCircles[i]).reta2;
            reta2.x2 = x;
            reta2.y2 = y;

            allCircles[i].x = x;
            allCircles[i].y = y;
        }

    }
}

function move(andouX, andouY, allCircles, indice) {

    allCircles[indice].x += andouX;
    allCircles[indice].y += andouY;

    reta1 = (allCircles[indice]).reta1;
    reta1.x1 = allCircles[indice].x;
    reta1.y1 = allCircles[indice].y;

    reta2 = (allCircles[indice]).reta2;
    reta2.x2 = allCircles[indice].x;
    reta2.y2 = allCircles[indice].y;

}


function moveDual(event, centrais, indiceCentral) {
    const x = event.clientX - canvas.offsetLeft;
    const y = event.clientY - canvas.offsetTop;

    circ1 = centrais[indiceCentral].circle1;
    circ2 = centrais[indiceCentral].circle2;

    andouX = x - centrais[indiceCentral].x;
    andouY = y - centrais[indiceCentral].y;

    centrais[indiceCentral].x = x;
    centrais[indiceCentral].y = y;

    if(indiceCentral>0)
        pontoCentral = centrais[(indiceCentral - 1)]
    else
        pontoCentral = centrais[(centrais.length-1)]

    if ((pontoCentral.retaPertencente.x2) > (pontoCentral.retaPertencente.x1))
        pontoCentral.x = ((pontoCentral.retaPertencente.x2 - pontoCentral.retaPertencente.x1) / 2 + pontoCentral.retaPertencente.x1);
    else
        pontoCentral.x = ((pontoCentral.retaPertencente.x1 - pontoCentral.retaPertencente.x2) / 2 + pontoCentral.retaPertencente.x2);
    if ((pontoCentral.retaPertencente.y2) > (pontoCentral.retaPertencente.y1))
        pontoCentral.y = ((pontoCentral.retaPertencente.y2 - pontoCentral.retaPertencente.y1) / 2 + pontoCentral.retaPertencente.y1);
    else
        pontoCentral.y = ((pontoCentral.retaPertencente.y1 - pontoCentral.retaPertencente.y2) / 2 + pontoCentral.retaPertencente.y2);

    
    if(indiceCentral<(centrais.length-1))
        pontoCentral = centrais[(indiceCentral + 1)]
    else
        pontoCentral = centrais[0]

    if ((pontoCentral.retaPertencente.x2) > (pontoCentral.retaPertencente.x1))
        pontoCentral.x = ((pontoCentral.retaPertencente.x2 - pontoCentral.retaPertencente.x1) / 2 + pontoCentral.retaPertencente.x1);
    else
        pontoCentral.x = ((pontoCentral.retaPertencente.x1 - pontoCentral.retaPertencente.x2) / 2 + pontoCentral.retaPertencente.x2);
    if ((pontoCentral.retaPertencente.y2) > (pontoCentral.retaPertencente.y1))
        pontoCentral.y = ((pontoCentral.retaPertencente.y2 - pontoCentral.retaPertencente.y1) / 2 + pontoCentral.retaPertencente.y1);
    else
        pontoCentral.y = ((pontoCentral.retaPertencente.y1 - pontoCentral.retaPertencente.y2) / 2 + pontoCentral.retaPertencente.y2);




    ctx.clearRect(0, 0, canvas.width, canvas.height);
    for (i = 0; i < allCircles.length; i++) {
        drawCircle(allCircles[i]);
        drawLine(allRetas[i]);
        drawCircle(centrais[i]);
        if (allCircles[i] == circ1) {
            move(andouX, andouY, allCircles, i)
        }

        if (allCircles[i] == circ2) {
            move(andouX, andouY, allCircles, i)
        }
    }
}


canvas.addEventListener("mousedown", function (event) {
    const x = event.clientX - canvas.offsetLeft;
    const y = event.clientY - canvas.offsetTop;
    const tolerancia = 9;

    for (i = 0; i < allCircles.length; i++) {
        const DiffXCentral = Math.abs(x - centrais[i].x);
        const DiffYCentral = Math.abs(y - centrais[i].y);
        const diffX = Math.abs(x - allCircles[i].x);
        const diffY = Math.abs(y - allCircles[i].y);


        param = getEquation(allRetas[i]);
        const distancia = Math.abs(x * param.slope + param.yIntercept - y);

        if (diffX < tolerancia) {
            if (diffY < tolerancia) {
                isMouseDown = true;
                isCanto = true;
                isLine = false;
                indiceCircle = i;
                break;
            }
        }
        if (DiffXCentral < tolerancia) {
            if (DiffYCentral < tolerancia) {
                isMouseDown = true;
                isCanto = false;
                isLine = true;
                indiceCentral = i;
            }
        }
        // else {
        //     if (distancia < tolerancia + 8) {
        //         indices = []
        //         for (j = 0; j < allCircles.length; j++) {
        //             if (allCircles[j].reta1 == allRetas[i])
        //                 indices.push(j)
        //             if (allCircles[j].reta2 == allRetas[i])
        //                 indices.push(j)
        //         }
        //         isCanto = false;
        //         isLine = true;
        //         moveDual(event, allCircles, indices)
        //     }
        // }

    }

    if (isMouseDown) {
        if (isCanto)
            moveLine(event, allCircles, indiceCircle)
        if (isLine)
            moveDual(event, centrais, indiceCentral)
    }
});

canvas.addEventListener("mousemove", function (e) {
    if (isMouseDown) {
        if (isCanto)
            moveLine(e, allCircles, indiceCircle);
        if (isLine)
            moveDual(e, centrais, indiceCentral)
    }
});

canvas.addEventListener("mouseup", function (e) {
    isMouseDown = false;
    isCanto = false;
    isLine = false;
    retaSelecionada = [];
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    for (i = 0; i < allRetas.length; i++)
        drawLine(allRetas[i]);
    for (i = 0; i < allCircles.length; i++)
        drawCircle(allCircles[i]);
    for (i = 0; i < centrais.length; i++)
        drawCircle(centrais[i]);
});