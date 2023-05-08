var canvas = document.getElementById("myCanvas");
ctx = canvas.getContext("2d");

point1 = {}
point2 = {}
point1.x = 20;
point1.y = 20;
point2.x = 550;
point2.y = 500;

function getEquation(point1, point2) {
    // Calcula o coeficiente angular (slope) da reta
    const slope = (point2.y - point1.y) / (point2.x - point1.x);

    // Calcula o coeficiente linear (y-intercept) da reta
    const yIntercept = point1.y - slope * point1.x;

    return { slope, yIntercept };
}

isMouseDown = false;
canto = 0;

function drawLine(event) {
    console.log("DOWN");
    const x = event.clientX - canvas.offsetLeft;
    const y = event.clientY - canvas.offsetTop;
    ctx.beginPath();
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    if (canto == 2) {
        console.log("canto 2")
        ctx.moveTo(point1.x, point1.y);
        point2.x = x;
        point2.y = y;
        ctx.lineTo(point2.x, point2.y);
    }
    else if (canto == 1) {
        console.log("canto 1")
        ctx.moveTo(point2.x, point2.y);
        point1.x = x;
        point1.y = y;
        ctx.lineTo(point1.x, point1.y);
    }
    ctx.strokeStyle = "black";
    ctx.lineWidth = 4;
    ctx.stroke();
}

canvas.addEventListener("mousedown", function (event) {
    const x = event.clientX - canvas.offsetLeft;
    const y = event.clientY - canvas.offsetTop;
    param = getEquation(point1, point2);
    const tolerancia = 8;
    const distancia = Math.abs(x * param.slope + param.yIntercept - y);

    const diffX1 = Math.abs(x - point1.x);
    const diffY1 = Math.abs(y - point1.y);
    console.log(diffX1, diffY1)

    const diffX2 = Math.abs(x - point2.x);
    const diffY2 = Math.abs(y - point2.y);

    if (distancia <= tolerancia)
        console.log("reta");
    if (diffX2 <= tolerancia && diffY2 <= tolerancia) {
        canto = 2;
        isMouseDown = true;
    }
    else if (diffX1 <= tolerancia && diffY1 <= tolerancia) {
        canto = 1;
        isMouseDown = true;
    }
    if (isMouseDown) {
        drawLine(event);
    }
});

canvas.addEventListener("mousemove", function (e) {
    if (isMouseDown)
        drawLine(e);
});

canvas.addEventListener("mouseup", function (e) {
    console.log("UP");
    isMouseDown = false;
    console.log(isMouseDown);
});


ctx.beginPath();

ctx.moveTo(point1.x, point1.y);
ctx.lineTo(point2.x, point2.y);
ctx.strokeStyle = "green";
ctx.lineWidth = 4;

ctx.stroke();