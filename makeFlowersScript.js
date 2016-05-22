function makeFlowers() {
    maxIx = 10;
    var clicking = false;
    var flowers = [];
    var game = new Phaser.Game(800, 640, Phaser.CANVAS, "flowerCanvas", {preload:preload, create:create, update:update});
    var colors = ['0xf87373', '0xfc9ece', '0x12bbf0', '0xd4ac0d', '0xb177e2', '0xfa6607', '0xaadddd', '0x42b48e'];

    function preload() {
        game.load.image('chrys', 'assets/chrys.png');

        for (var i = 1; i < 9; i++) {
            for (var j = 1; j < 8; j++) {
                var name = 'flower2_' + i + '_' + j;
                game.load.image(name, 'assets/' + name + '.png');
                flowers.push(name);
            }
        }

    }

    function create() {
        game.physics.startSystem(Phaser.Physics.Arcade);
        game.stage.backgroundColor = '#ffffff';
        game.scale.pageAlignHorizontally = true;
        game.scale.pageAlignVertically = true;
        game.scale.refresh();


        console.log('started');
        for (var i = 0; i < 4; i++) {
            flowers.push('chrys');
        }

    }

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

    function animate(flower, ix) {
        if (ix == 1) {
            // console.log("???");
            flower.scale.setTo(ix / 10, ix / 10);
            requestAnimFrame(function() {
                animate(flower, ix + 1);
            });

        } else if (ix < maxIx) {
            flower.scale.setTo(ix / 10, ix / 10);
            requestAnimFrame(function() {
                animate(flower, ix + 1);
            });
        }
    }

    function update() {
        if (game.input.mousePointer.isDown) {
            console.log(game.input.x);
            if (! clicking) {
                clicking = true;
                var randomFlower = flowers[Math.floor((Math.random() * flowers.length))];
                var flower = game.add.sprite(game.input.x, game.input.y, randomFlower);
                flower.anchor.set(0.55, 0.45);
                animate(flower, 1);
            }
        }

        if (game.input.mousePointer.isUp) {
            clicking = false;
        }
    }
}

