function simpleFlower() {
    var ix = 0;
    var N = 1000;
    var x = 4;
    var y = 3;
    var scale = 300;
    var d = 3;
    var n = 1;
    var canvas = document.getElementById("simpleFlowerCanvas");
    var ctx = canvas.getContext("2d");
    var maxIx = 4000;

    function refreshd(){
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        d = $("#d").slider( "value" );
        ix = 0;
        ctx = canvas.getContext("2d");
        var str = "r = ";
        str += "<sup>";
        str += d;
        str += "</sup>&frasl;<sub>";
        str += n;
        str += "</sub>";
        str += " cos(&theta;)";
        document.getElementById("eqRes").innerHTML = str;
    }

    function refreshn(){
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        n = $("#n").slider( "value" );
        ix = 0;
        ctx = canvas.getContext("2d");
        var str = "r = ";
        str += "<sup>";
        str += d;
        str += "</sup>&frasl;<sub>";
        str += n;
        str += "</sub>";
        str += " cos(&theta;)";
        document.getElementById("eqRes").innerHTML = str;
    }

    $("#d").slider({
        orientation: "horizontal",
        range: "min",
        max: 20,
        min: 1,
        value: 3,
        slide: refreshd,
        change: refreshd
    });

    $("#n").slider({
        orientation: "horizontal",
        range: "min",
        max: 20,
        min: 1,
        value: 1,
        slide: refreshn,
        change: refreshn
    });


    window.requestAnimFrame = (function(callback) {
        return window.requestAnimationFrame ||
            window.webkitRequestAnimationFrame ||
            window.mozRequestAnimationFrame ||
            window.oRequestAnimationFrame ||
            window.msRequestAnimationFrame ||
            function(callback) {
                window.setTimeout(callback, 1000 / 60);
            };
    })();

    function animate() {
        ix = ix + 1;
        if (ix < maxIx) {
            var u = ix * 21.0 * Math.PI / N;
            var r = Math.cos((d / n) * u);
            // var r = Math.cos((Math.sqrt(2) / Math.PI) * u);
            if (ix > 1) {
                ctx.strokeStyle = "#12bbf0";
                ctx.moveTo(540 + x * scale, 320 + y * scale);
            } else {
                ctx.beginPath();
                ctx.lineWidth=1;
            }

            x = r * Math.cos(u);
            y = r * Math.sin(u);

            if (ix > 1) {
                ctx.lineTo(540 + x * scale, 320 + y * scale);
                ctx.stroke();
            }
        }
        requestAnimFrame(function() {
            animate();
        });
    }
    animate();
}