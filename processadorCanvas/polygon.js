var canvas = document.getElementById("myCanvas");
ctx = canvas.getContext("2d");

reta = {}
reta.x1 = 20;
reta.y1 = 20;
reta.x2 = 550;
reta.y2 = 500;
allRetas = []
allRetas.push(reta);

for (i = 0; i < 10; i++) {
    reta = {}
    reta.x1 = Math.floor(Math.random() * 500)
    reta.y1 = Math.floor(Math.random() * 500)
    reta.x2 = Math.floor(Math.random() * 500)
    reta.y2 = Math.floor(Math.random() * 500)
    allRetas.push(reta)
}

function getEquation(reta) {
    // Calcula o coeficiente angular (slope) da reta
    const slope = (reta.y2 - reta.y1) / (reta.x2 - reta.x1);

    // Calcula o coeficiente linear (y-intercept) da reta
    const yIntercept = reta.y1 - slope * reta.x1;

    return { slope, yIntercept };
}

isMouseDown = false;
canto = 0;

function drawLine(allRetas,indice) {
    ctx.beginPath();
    ctx.moveTo(allRetas[indice].x1, allRetas[indice].y1);
    ctx.lineTo(allRetas[indice].x2, allRetas[indice].y2);
    ctx.strokeStyle = "black";
    ctx.lineWidth = 4;
    ctx.stroke();
}

function drawCircle(allRetas,indice){
    ctx.beginPath();
    ctx.arc(allRetas[indice].x1, allRetas[indice].y1, 5, 0, Math.PI * 2, true);
    ctx.fill();
    ctx.stroke();
    ctx.beginPath();
    ctx.arc(allRetas[indice].x2, allRetas[indice].y2, 5, 0, Math.PI * 2, true);
    ctx.fill();
    ctx.stroke();
}

for (i in allRetas) {
    drawLine(allRetas,i);
    drawCircle(allRetas,i);
}

function moveLine(event, allRetas, indiceReta) {
    const x = event.clientX - canvas.offsetLeft;
    const y = event.clientY - canvas.offsetTop;
    ctx.clearRect(0, 0, canvas.width, canvas.height);

    for (i in allRetas) {
        if (indiceReta.includes(i)) {
            console.log("oiii")
            ctx.beginPath();
            if (canto == 2) {
                ctx.moveTo(allRetas[i].x1, allRetas[i].y1);
                allRetas[i].x2 = x;
                allRetas[i].y2 = y;
                ctx.lineTo(allRetas[i].x2, allRetas[i].y2);
            }
            else if (canto == 1) {
                ctx.moveTo(allRetas[i].x2, allRetas[i].y2);
                allRetas[i].x1 = x;
                allRetas[i].y1 = y;
                ctx.lineTo(allRetas[i].x1, allRetas[i].y1);
            }
            ctx.strokeStyle = "black";
            ctx.lineWidth = 4;
            ctx.stroke();
            drawCircle(allRetas,i);
        }
        else 
        {
            drawLine(allRetas,i)
            drawCircle(allRetas,i)
        }
    }
}

retaSelecionada=[]

canvas.addEventListener("mousedown", function (event) {
    const x = event.clientX - canvas.offsetLeft;
    const y = event.clientY - canvas.offsetTop;
    const tolerancia = 8;

    for (i in allRetas) {
        param = getEquation(allRetas[i]);
        const distancia = Math.abs(x * param.slope + param.yIntercept - y);

        const diffX1 = Math.abs(x - allRetas[i].x1);
        const diffY1 = Math.abs(y - allRetas[i].y1);

        const diffX2 = Math.abs(x - allRetas[i].x2);
        const diffY2 = Math.abs(y - allRetas[i].y2);

        if (distancia <= tolerancia)
            console.log("reta");
        if (diffX2 <= tolerancia && diffY2 <= tolerancia) {
            canto = 2;
            isMouseDown = true;
            retaSelecionada.push(i)
        }
        else if (diffX1 <= tolerancia && diffY1 <= tolerancia) {
            canto = 1;
            isMouseDown = true;
            retaSelecionada.push(i)
        }
        if (isMouseDown) {
            console.log(retaSelecionada)
            moveLine(event, allRetas, retaSelecionada);
        }
    }
});

canvas.addEventListener("mousemove", function (e) {
    if (isMouseDown)
        moveLine(e, allRetas, retaSelecionada);
});

canvas.addEventListener("mouseup", function (e) {
    console.log("UP");
    isMouseDown = false;
    console.log(isMouseDown);
    retaSelecionada=[];
});