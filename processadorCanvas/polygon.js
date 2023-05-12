var canvas = document.getElementById("myCanvas");
ctx = canvas.getContext("2d");

lados = 2
inicio = 0

function insereRetas(allRetas, x1, y1, x2, y2, posicao) {
    reta = {}
    reta.x1 = x1;
    reta.y1 = y1;
    reta.x2 = x2;
    reta.y2 = y2;
    allRetas.splice(posicao, 0, reta);
}

function insereCirculo(allCircles, x, y, allRetas, posicao) {
    point = {}
    point.x = x;
    point.y = y;
    point.reta = allRetas[(posicao - 1)];
    allCircles.splice(posicao, 0, point);
}

function retornaCentro(reta) {
    point = {}
    if (reta.x1 > reta.x2) {
        point.x = (reta.x1 - reta.x2) / 2 + reta.x2;
    }
    else
        point.x = (reta.x2 - reta.x1) / 2 + reta.x1;
    if (reta.y1 > reta.y2) {
        point.y = (reta.y1 - reta.y2) / 2 + reta.y2;
    }
    else
        point.y = (reta.y2 - reta.y1) / 2 + reta.y1;
    return point;
}

function insereCentro(allCentros, allRetas, posicao) {
    point = {}
    point = retornaCentro(allRetas[posicao])
    allCentros.splice(posicao, 0, point);
}

allRetas = []
allCircles = []
allCentros = []

while (1) {
    passo = ((Math.PI * 2) / lados);
    raio = 200
    sen1 = (Math.round(Math.sin(inicio) * raio));
    cos1 = (Math.round(Math.cos(inicio) * raio));
    sen2 = (Math.round(Math.sin(inicio + passo) * raio));
    cos2 = (Math.round(Math.cos(inicio + passo) * raio));

    x1 = canvas.width / 2 + sen1;
    y1 = canvas.height / 2 + cos1;
    x2 = canvas.width / 2 + sen2;
    y2 = canvas.height / 2 + cos2;

    insereRetas(allRetas, x1, y1, x2, y2, (allRetas.length));
    insereCirculo(allCircles, x1, y1, allRetas, (allCircles.length));
    insereCentro(allCentros, allRetas, (allCentros.length));
    inicio += passo;
    if (inicio > (Math.PI * 2 - 0.3))
        break;

}
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


for (i = 0; i < allCentros.length; i++)
    drawCircle(allCentros[i]);
for (i = 0; i < (allRetas.length); i++) {
    drawLine(allRetas[i]);
    drawCircle(allCircles[i])
}


function moveLine(event, allCircles, indiceCircle) {
    const x = event.clientX - canvas.offsetLeft;
    const y = event.clientY - canvas.offsetTop;

    ctx.clearRect(0, 0, canvas.width, canvas.height);

    for (i = 0; i < allRetas.length; i++) {
        drawCircle(allCircles[i]);
        drawLine(allRetas[i])
        drawCircle(allCentros[i]);
        if (i == indiceCircle) {

            allCircles[i].x = x;
            allCircles[i].y = y;

            allRetas[i].x1 = x;
            allRetas[i].y1 = y;

            allCentros[i] = retornaCentro(allRetas[i])

            indice = i;
            if (i == 0)
                indice = (allRetas.length) - 1;
            else
                indice = i - 1;

            allRetas[indice].x2 = x;
            allRetas[indice].y2 = y;
            allCentros[indice] = retornaCentro(allRetas[indice]);

        }

    }
}


function moveDual(event, allCentros, indiceCentral) {
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    for (i = 0; i < allRetas.length; i++) {
        drawCircle(allCircles[i]);
        drawLine(allRetas[i])
        drawCircle(allCentros[i]);
    }
    const x = event.clientX - canvas.offsetLeft;
    const y = event.clientY - canvas.offsetTop;

    andouX = x - allCentros[indiceCentral].x;
    andouY = y - allCentros[indiceCentral].y;

    allCentros[indiceCentral].x = x;
    allCentros[indiceCentral].y = y;

    allCircles[indiceCentral].x += andouX;
    allCircles[indiceCentral].y += andouY;

    allRetas[indiceCentral].x1 += andouX;
    allRetas[indiceCentral].y1 += andouY;
    allRetas[indiceCentral].x2 += andouX;
    allRetas[indiceCentral].y2 += andouY;

    indice=indiceCentral;
    if (indice == 0)
        indice = (allCircles.length - 1);
    else
        indice -= 1;

    allRetas[indice].x2 = allCircles[indiceCentral].x;
    allRetas[indice].y2 = allCircles[indiceCentral].y;
    allCentros[indice] = retornaCentro(allRetas[indice]);

    indice = indiceCentral;
    if (indice == (allCircles.length - 1))
        indice = 0;
    else
        indice += 1;

    allCircles[indice].x += andouX;
    allCircles[indice].y += andouY;
    allRetas[indice].x1 = allCircles[indice].x;
    allRetas[indice].y1 = allCircles[indice].y;
    allCentros[indice] = retornaCentro(allRetas[indice]);


    drawCircle(allCentros[indiceCentral])

}


function cortaReta(event, allRetas, indice) {
    const x = event.clientX - canvas.offsetLeft;
    const y = event.clientY - canvas.offsetTop;
    console.log(x, y)
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    allRetas[indice].x2 = x;
    allRetas[indice].y2 = y;
    if (indice == (allRetas.length - 1))
        indice = 0;
    else
        indice = indice + 1;
    insereRetas(allRetas, x, y, allRetas[indice].x1, allRetas[indice].y1, indice);
    insereCirculo(allCircles, x, y, allRetas, indice);
    insereCentro(allCentros, allRetas, indice);

    //Correção de centro pós corte
    if (indice == 0)
        indice = (allRetas.length - 1)
    else
        indice = indice - 1;
    allCentros[indice] = retornaCentro(allRetas[indice]);

    isMouseDown = false;
    isRightClick = false;
}

isRightClick = false;

canvas.addEventListener("mousedown", function (event) {
    isMouseDown = true;
    const x = event.clientX - canvas.offsetLeft;
    const y = event.clientY - canvas.offsetTop;
    const tolerancia = 9;

    for (i = 0; i < allCircles.length; i++) {
        const DiffXCentral = Math.abs(x - allCentros[i].x);
        const DiffYCentral = Math.abs(y - allCentros[i].y);
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
                console.log("centro")
                isMouseDown = true;
                isCanto = false;
                isLine = true;
                indiceCentral = i;
            }
        }

    }

    if (isMouseDown) {
        if (isCanto)
            moveLine(event, allCircles, indiceCircle)
        if (isLine)
            moveDual(event, allCentros, indiceCentral)
    }
});

canvas.addEventListener("mousemove", function (e) {
    if (isMouseDown) {
        if (isCanto)
            moveLine(e, allCircles, indiceCircle);
        if (isLine)
            moveDual(e, allCentros, indiceCentral)
    }
});

canvas.addEventListener('contextmenu', function (event) {
    event.preventDefault();
    const x = event.clientX - canvas.offsetLeft;
    const y = event.clientY - canvas.offsetTop;
    const tolerancia = 9;
    isRightClick = true;
    for (i = 0; i < allCircles.length; i++) {
        param = getEquation(allRetas[i]);
        const distancia = Math.abs(x * param.slope + param.yIntercept - y);
        if (distancia < tolerancia) {
            if (isRightClick) {
                isRightClick = false;
                cortaReta(event, allRetas, i);
            }
        }
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
    for (i = 0; i < allCentros.length; i++)
        drawCircle(allCentros[i]);
});