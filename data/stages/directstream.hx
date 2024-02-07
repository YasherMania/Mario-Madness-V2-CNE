import flixel.text.FlxText;
import flixel.text.FlxText.FlxTextBorderStyle;
import flixel.text.FlxText.FlxTextFormat;

var txtNum = 0;
var miya:FlxSprite;
var face:FlxSprite;
var noPosSet = false;
var livechat:FlxText;
var chatcolor1:FlxTextFormat = new FlxTextFormat(FlxColor.RED, false, false, 0xFF000000);
var chatcolor2:FlxTextFormat = new FlxTextFormat(0xFF4888F0, false, false, 0xFF000000);
var chatcolor3:FlxTextFormat = new FlxTextFormat(0xFF76E657, false, false, 0xFF000000);
var chatcolor4:FlxTextFormat = new FlxTextFormat(0xFFE4F55F, false, false, 0xFF000000);
var chatcolor5:FlxTextFormat = new FlxTextFormat(0xFFF04891, false, false, 0xFF000000);

function postCreate() {
	camGame.alpha = 0;
	camHUD.alpha = 0;
    	miya = new FlxSprite(250, 100);
    	miya.frames = Paths.getSparrowAtlas('stages/real/miyamoto');
    	miya.animation.addByPrefix('idle', "miyamoto still", 24, true);
    	miya.animation.addByPrefix('talk', "miyamoto talking", 24, false);
    	miya.animation.addByPrefix('hand', "miyamoto hand motion", 24, false);
    	miya.antialiasing = true;
    	miya.updateHitbox();
	miya.scrollFactor.set();
    	add(miya);
	miya.animation.play('idle', true);

    	face = new FlxSprite(1025, -210);
    	face.frames = Paths.getSparrowAtlas('stages/real/facecam bg');
    	face.animation.addByPrefix('idle', "facecam bg down0", 24, true);
    	face.animation.addByPrefix('left', "facecam bg left0", 24, true);
    	face.animation.addByPrefix('down', "facecam bg down0", 24, true);
    	face.animation.addByPrefix('up', "facecam bg up0", 24, true);
    	face.animation.addByPrefix('right', "facecam bg right0", 24, true);
    	face.antialiasing = true;
    	face.updateHitbox();
	face.scrollFactor.set();
	insert(members.indexOf(dad), face);
	insert(members.indexOf(gf), face);
	insert(members.indexOf(boyfriend), face);
	face.animation.play('idle', true);

	dad.alpha = 0;
	livechat = new FlxText(1060, 270, 818, '', 32);
	livechat.setFormat(Paths.font("pixel.otf"), 24, FlxColor.WHITE, "left", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);

	livechat.cameras = [camGame];
	insert(members.indexOf(miya), livechat);
	reset();
}

function update() {
	camGame.scroll.x = 0;
	camGame.scroll.y = 0;
	FlxG.camera.followLerp = 0.01;

	if (dad.animation.curAnim.name == "isame") {
		dad.x = 200 + 9;
		dad.y = -100;
	} else if (dad.animation.curAnim.name == "hey") {
		dad.x = 200 - 130;
		dad.y = -100 - 101;
	} else {
		if (!noPosSet) {
			dad.x = 200;
			dad.y = -100;
		}
	}
	miya.y = 0 + Math.sin(miya.x / 36) * 10;

	if (boyfriend.animation.curAnim.name == "singLEFT") face.animation.play('left', true);
	if (boyfriend.animation.curAnim.name == "singDOWN") face.animation.play('down', true);
	if (boyfriend.animation.curAnim.name == "singUP") face.animation.play('up', true);
	if (boyfriend.animation.curAnim.name == "singRIGHT") face.animation.play('right', true);
	if (boyfriend.animation.curAnim.name == "idle") face.animation.play('idle', true);
	if (FlxG.random.int(0, 50) == 5) {
		addMessage();
	}
	if(txtNum == 14){
		livechat.text = "";
		txtNum = 0;
	}
}

function talk() { miya.animation.play('talk', true); }
function hand() { miya.animation.play('hand', true); }
function itsame() { 
	dad.danceOnBeat = false;
	dad.animation.play("itsame", true);
 }
function amario() { dad.animation.play("hey", true); }
function normal() {
	dad.danceOnBeat = true;
	noPosSet = false;
	FlxTween.tween(camHUD, {alpha:1}, 1, {ease: FlxEase.sineInOut, type: FlxTween.ONESHOT});
}

function beatHit(curBeat) {
	if (curBeat == 0) FlxTween.tween(camGame, {alpha:1}, 2, {ease: FlxEase.sineInOut, type: FlxTween.ONESHOT});
	if (curBeat == 0) defaultCamZoom = 0.63;
}

function miyaleave() {
	noPosSet = true;
	dad.x = 1000;
	tag.x = -800;
	FlxTween.tween(miya, {x: -1600}, 2.5, {ease: FlxEase.sineInOut, type: FlxTween.ONESHOT});
	FlxTween.tween(bg, {alpha:1}, 2, {ease: FlxEase.sineInOut, type: FlxTween.ONESHOT});
	FlxTween.tween(dad, {alpha:1, x:200}, 2, {ease: FlxEase.sineInOut, type: FlxTween.ONESHOT});
	FlxTween.tween(tag, {alpha:1, x:-100}, 4, {ease: FlxEase.sineOut, type: FlxTween.ONESHOT});
}

function chatMessage() {
	addMessage();
}

// the text stuff!!!
	public static var chatText:String = '';
	public static var chatLong:String = '';
	public static var chatArray:Array<String> = ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];
	public static var chosenUsername:String = '';
	public static var chosenMessage:String = '';
	public static var finalchat:String = '';
	public static var cantidad:Int = 0;
	public static var tooLong:Bool = false;

	public static function reset()
	{
		chatArray = ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];
	}

	public static function addMessage()
	{
			var messages:Array<String> = [
				'what about gd',
				'mid',
				'will you play fnaf later?',
				'yooo mario',
				'alr',
				'ITS MARIO OMG',
				'lmao',
				'LMAOOOO',
				'what',
				'l',
				'w',
				'no way',
				'can you play oddysey?',
				'what happened to miyamoto',
				'is that mario',
				'is the guy from marvel',
				'is the guy from marvel?',
				'is the guy from marvel!',
				'are you the guy from fnf?',
				'salami',
				'this is great',
				'oh',
				'woo banger',
				'this shit straight fire',
				'BROOO????',
				'hi boyfriend',
				'its a me',
				'love this man',
				'thats cool',
				'he looks like markiplier',
				'so cool',
				'how',
				'Yeaaaa',
				'hi',
				'WTF Chris Pratt?',
				'what about charles',
				'this movie is gonna suck',
				'ew illumination',
				'what the fuck',
				'WHAAAAAAAAAT',
				'no fucking way',
				'what is nintendo thinking',
				'i wonder who luigi is?',
				'bruh',
				'hi',
				'i was here',
				'ratio',
				'you fell off',
				'hi youtube',
				'is that your gf in the bg?',
				'bro ur gf is hot',
				'bro ur gf is ugly',
				'fuck you leaker',
				'sonic.exe is better',
				'will you rap battle me plz',
				'someone gift me a sub plz',
				'someone give me money plz',
				'fight me bro',
				'i lov pstasa nigh',
				'oh look a free ipad',
				'ca n I be in the chat....',
				'the g',
				'ola causa',
				'there should be an fnf mod of this',
				'me when fnf',
				'cry about it',
				'y es todo un tema viste',
				'ojo',
				'I love Balloon Boy',
				'XD',
				'couch potato',
				'have you ever wanted movies free',
				'this is the story of a girl',
				'brown bricks',
				'let me tell you a sad story',
				'6 piece chicken nuggets',
				'McFlurry',
				'Sus ojos le sangraban...',
				'bring on tha thunda',
				'hop on among us cuz',
				'sussy facecam',
				'los dioses de mi causa me han abandonado',
				'hippopotomonstrosesquippedaliophobia',
				'deez nuts',
				"bro thinks he's mario",
				'[message deleted by moderator]',
				'[message deleted by moderator]',
				'[message deleted by moderator]',
				'this shit STIIIIINKS',
				'Fue mi pene',
				'last message',
				'shithead',
				'hey BF how do you say flan',
				'He looks like Theodore the Chipmunk',
				'This is like a wario take on remember the alamo',
				'PISS FAT???',
				'this is so gangster holy shit',
				'so no smash?',
				'Can you play GD?',
				'This sucks, next song',
				'Dude, I know this is unrelated, but I need your help right now.',
				'Wanna become famous? Buy followers, at bigfollows.com!',
				'Gushers',
				'unfortunately, ratio',
				'Galápagos Tortoise',
				'gracias a dios que es viernes',
				'Hes so cool...',
				'This is going to be a disaster',
				'are we getting a Chris Pratt amiibo?',
				'Can you play fortnite?',
				'They should add chris pratt to fortnite',
				'PILGRIM SPONGEBOB???',
				'whens twinsanity',
				'is chris pratt a duende?',
				'this has to be a joke',
				'reggie would be rolling in his grave rn',
				'wtf',
				'aint no way',
				'oh goodness gracious',
				'mid march?',
				'shouldve been adam sandler tbh',
				'Its a BAD day for mario',
				'yeah this is fucked',
				'can you play desert bus next?',
				'get a load of this guy',
				'MY MARIO?!? THEY TOOK HIM!!!!',
				'is that christian bale from star wars?',
				'vaya mierda',
				'want robux? visit FREEROBUX.COM and become a MILLIONARE !',
				'yeah man',
				'midlicious',
				'Lol, lmao even',
				'oh, thats chris pratt',
				'I love these beans',
				'MOM GET THE PS5',
				'me rio?'
			];
			
			var usernames:Array<String> = [
				'Bleakim',
				'BootMunde',
				'CatAlone',
				'Cooledia',
				'DanceRocker',
				'Ellacens',
				'EnergyHan',
				'Giglobus',
				'GlimmerAut',
				'Guantonk',
				'Hacksale',
				'Jinom',
				'Kavenix',
				'LastingBorg',
				'NotesGlory',
				'Teal',
				'Sun',
				'Poolis',
				'Raptw',
				'Sexylo',
				'Sistergy',
				'Sowf',
				'Specism',
				'Sticomyl',
				'StoopFamous',
				'Tallyda',
				'Terreve',
				'Thebesten',
				'Vitexce',
				'VodForum',
				'WakeboardBox',
				'Zippoix',
				'zxppy',
				'candel',
				'fnaffreddy',
				'GP',
				'Red',
				'lemonaid2',
				'Magik',
				'StrawDeutch',
				'NateTDOM',
				'theWAHbox',
				'PepeMago',
				'Chad',
				'fishlips77',
				'justbruh',
				'BestEnd',
				'sharlet',
				'Gerardo',
				'mikhobb',
				'CaptCake',
				'Colacapn',
				'lillypad',
				'Zendraynix',
				'wyvernGoddess',
				'paradiseEvan',
				'manmakestick',
				'blueknight250',
				'fivein_',
				'CoreCombatant',
				'shapperoni',
				'maxinoise',
				'A_vacuum',
				'ewademar',
				'buttnugget',
				'nugass',
				'lordbossmaster',
				'artugamerpro99',
				'byelion',
				'friedfrick',
				'friedrick',
				'fredrick',
				'MXgaming',
				'kingf0x',
				'MundMashup',
				'Gadget',
				'MikeMatei',
				'sponge',
				'Super Johnsons',
				'Smellvin',
				'Beefrunkle',
				'Faro',
				'doug',
				'C0mix_Z0ne',
				'StingaFlinn',
				'OpillaBowd',
				'AwesomeHuggyWuggy',
				'Reki',
				'PaulFart',
				'Zeroh',
				'GamesCage',
				'Soup',
				'MetalFingers',
				'MetalFace',
				'Zeurel',
				'Lythero',
				'IheartJustice',
				'JCJack',
				'Ironik',
				'Sturm',
				'ChurgneyGurgney',
				'Jerma985',
				'DougDoug',
				'Chris Snack',
				'Duende',
				'CasualCaden',
				'BadArseJones',
				'marmot',
				'BeegYoshi',
				'Sandi',
				'johnsonVMUleaker',
				'weedeet',
				'Bromaster819',
				'Griog',
				'The_Beast',
				'Zebo',
				'BelowNatural',
				'FreddyFreaker',
				'Marquitoswin',
				'DastardlyDeacon',
				'VibingLeaf',
				'RedTv53',
				"apurples",
				//ones below here have special messages for their names
				
				'Joe_Biden',
				'Ney',
				'turmoil',
				'care',
				'mx',
				'saster',
				'evil mario',
				'wega',
				'winniethepooh',
				'moldy mario',
				'mr.l',
				'useraqua',
				'EllisBros',
				'Dave',
				'JackBlack',
				'Vania',
				'scrumbo_',
				'Linkara',
				'mark',
				'Fernanfloo',
				'Vargskelethor',
				'MrDink',
				'FatAlbert',
				'Hermanoquebasto',
				'Clue_Buddy',
				'anderson043',
				'Robotnik',
				'ElRubisOMG',
				'Walter_White',
				'Ganon',
				'Joker',
				'Super Wario Man',
				'WhiteyDvl',
				'misterSYS'
			];


			var usercolor:Int = FlxG.random.int(1, 5);
			var tagcolor:String = '';

			switch(usercolor){
				case 1:
					tagcolor = '$';
				case 2:
					tagcolor = '#';
				case 3:
					tagcolor = '%';
				case 4:
					tagcolor = '&';
				case 5:
					tagcolor = ';';
			}

			chosenMessage = messages[FlxG.random.int(0, messages.length - 1)];
			chosenUsername = usernames[FlxG.random.int(0, usernames.length - 1)];
			
			livechat.text = livechat.text + chosenUsername + " : " + chosenMessage + "\n";
			txtNum += 1;

			// randomizeUserColor(); - this dont work yet - apurples
		}

function randomizeUserColor(){
	function shuffle(){
		switch(FlxG.random.int(1, 5)){
			case 1: chosenUsername.color = FlxColor.RED;
			case 2: chosenUsername.color = 0xFF4888F0;
			case 3: chosenUsername.color = FlxColor.RED;
			case 4: chosenUsername.color = 0xFF4888F0;
			case 5: chosenUsername.color = FlxColor.RED;
		}
	}
	shuffle();
}
