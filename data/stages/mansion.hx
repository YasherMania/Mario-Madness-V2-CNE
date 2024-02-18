import openfl.Lib;

var shader:CustomShader = null;
var shader2:CustomShader = null;

function create() {
        Lib.application.window.title="Friday Night Funkin': Mario's Madness | Iason Mason | KennyL ft GP, VanScotch, Scrubb & Dewott GAMERRR";
	shader = new CustomShader("hueshift");
	shader.uHsv = [0.5, 0, 0];
	shader2 = new CustomShader("hueshift");
	shader2.uHsv = [0.6, 0, 0];
	bg.shader = shader2;
	dad.shader = shader;
	boyfriend.shader = shader2;
	camHUD.addShader(shader);
}