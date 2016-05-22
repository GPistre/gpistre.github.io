function chrysanthemum() {
    var height = 600;
    var width = 400;
    var game = new Phaser.Game(height, width, Phaser.CANVAS, 'chrysanthemumCanvas', {create:create, update:update});
    var ix = 0;
    var N = 4000;
    var x = 4;
    var y = 3;
    var graphics;
    var scale = 20;

    var colors = ['0xf87373', '0xfc9ece', '0x12bbf0', '0xd4ac0d', '0xb177e2', '0xfa6607', '0xaadddd', '0x42b48e'];

    function create() {
        game.stage.backgroundColor = '#ffffff';
        game.scale.pageAlignHorizontally = true;
        game.scale.maxWidth = 600;
        game.scale.maxHeight = 400;
        game.scale.scaleMode = Phaser.ScaleManager.SHOW_ALL;
        game.scale.setScreenSize();
        game.scale.refresh();
        game.physics.startSystem(Phaser.Physics.Arcade);
        graphics = game.add.graphics(0, 0);

    }

    function distanceToCenter(x, y) {
        return Math.sqrt(Math.pow(x * scale, 2) + Math.pow(y * scale, 2));
    }

    function update() {
        ix = ix + 1;
        if (ix < 1900) {
            var power = 0.5;
            var dist = Math.round(Math.pow(distanceToCenter(x, y), power));
            var c = Phaser.Color.interpolateColor(colors[2], colors[0], Math.pow(260, power), dist);

            var u = ix * 21.0 * Math.PI / N;
            var p4 = Math.sin(17 * u / 3);
            var p8 = Math.sin(2 * Math.cos(3 * u) - 28 * u);
            var r = 5 * (1 + Math.sin(11 * u / 5)) - 4 * p4 * p4 * p4 * p4 * p8 * p8 * p8 * p8 * p8 * p8 * p8 * p8;

            if (ix > 1) {
                graphics.lineStyle(.5, c, 1);
                graphics.moveTo(height / 2 + x * scale, width / 2 + y * scale);
            }

            x = r * Math.cos(u);
            y = r * Math.sin(u);

            if (ix > 1) {
                graphics.lineTo(height / 2 + x * scale, width / 2 + y * scale);
            }

        } else {
            graphics.endFill();
            game.destroy()
        }
    }
}