function chrysanthemum() {
    var height = 600;
    var width = 400;
    var ix = 0;
    var N = 4000;
    var x = 4;
    var y = 3;
    var scale = 25;
    var maxIx = 1900;
    var canvas = document.getElementById("chrysCanvas");

    var colors = ['0xf87373', '0xfc9ece', '0x12bbf0', '0xd4ac0d', '0xb177e2', '0xfa6607', '0xaadddd', '0x42b48e'];

    var col1 = new RGB(18,187,240);
    var col2 = new RGB(248,115,115);
    
    function interpolateRGB(startRGB, endRGB, a, e) {
        var rgb = {
            r: Math.round((endRGB.r - startRGB.r) * a / e + startRGB.r),
            g: Math.round((endRGB.g - startRGB.g) * a / e + startRGB.g),
            b: Math.round((endRGB.b - startRGB.b) * a / e + startRGB.b)
        };

        return new RGB(rgb.r, rgb.g, rgb.b)
    }

    function RGB(r, g, b) {
        this.r = r || 0;
        this.g = g || 0;
        this.b = b || 0;
    }

    RGB.prototype.toString = function() {
        return 'rgb(' + this.r + ',' + this.g + ',' + this.b + ')';
    };

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

    function distanceToCenter(x, y) {
        return Math.sqrt(Math.pow(x * scale, 2) + Math.pow(y * scale, 2));
    }


    function animate() {
        ix = ix + 1;
        if (ix < maxIx) {

            var power = 0.5;
            var dist = distanceToCenter(x, y);

            var color = interpolateRGB(col2, col1, Math.pow(dist, power), Math.pow(200, power));
            var u = ix * 21.0 * Math.PI / N;
            var p4 = Math.sin(17 * u / 3);
            var p8 = Math.sin(2 * Math.cos(3 * u) - 28 * u);
            var r = 5 * (1 + Math.sin(11 * u / 5)) - 4 * p4 * p4 * p4 * p4 * p8 * p8 * p8 * p8 * p8 * p8 * p8 * p8;

            var ctx=canvas.getContext("2d");
            ctx.beginPath();

            if (ix == 1) {
                x = r * Math.cos(u);
                y = r * Math.sin(u);
            }

            ctx.moveTo(500 + x * scale, 320 + y * scale);

            x = r * Math.cos(u);
            y = r * Math.sin(u);

            ctx.lineTo(500 + x * scale, 320 + y * scale);
            ctx.strokeStyle=color;
            ctx.stroke();

        }
        requestAnimFrame(function() {
            animate();
        });
    }
    animate();
    

}