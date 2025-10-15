package states;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxCamera;
import haxe.Json; // parser
import openfl.Lib;
//needed for js porting
import js.Browser;
import haxe.Http;

import flixel.FlxState;
import flixel.FlxSprite as Img;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.FlxCamera as HUD;
import flixel.math.FlxMath;
import classes.PathSound as Audio;
import classes.HTMLBackend;
import classes.Pages;
import classes.UI;
import flixel.tweens.*;
import flixel.text.FlxText;
import flixel.addons.display.FlxBackdrop as BG;
import Main;

class WebStatusState extends FlxState {
    public var RootDirectory:String = "bulkAssets/";

    /**Goober.*/
    var bopper:Img;
    /**Base camera for canvas elements.*/
    public static var camHUD:HUD;

    // Other mf cameras for pages, this is likely so inefficient...
    var camHome:HUD = new HUD();
    var camBio:HUD = new HUD();
    var camStatus:HUD = new HUD();
    public var camList:FlxTypedGroup<HUD> = new FlxTypedGroup<HUD>();

    var bgGoofy:BG;
    public var MusicHandler:Audio = new Audio();
    public var SoundHandler:Audio = new Audio();

    var startBop:Bool = false;
    var bopConst:Float;
    var jason:Int;
    var files:UI;
    var realTime:FlxText;

    public static var curPage:String;

    //TEMPORARY
    public var sorry:FlxText;

    /**
        __The root of the page elements to pass objects through in callbacks.__
    */
    var __Page_Elements:Map<String, Void->Void> = [];

    var preventTransition:Bool = false;
    override function create() {
        __Page_Elements = [
            // Home page
            "Home" => () -> {
                add(new Page("Home", () -> {
                    Page.addToPage(
                        new FlxText(0, 0, 800,
"Oh, heyo. Looks like you stumbled upon the preliminary structure
of what's supposed to be my entire Discord profile page.

Now for those of you that have seen the Netlify one with all the
JS and HTML stuff, you might be wondering why I'm using this instead.
It's simple, really. BRINGING HAXE TO NPM AND JS IS A HASSLE, AAAAA

So yeah, I'm building my whole profile stuff from scratch with the language I tinker with the most.
More improvements coming soon; add issues in the main GitHub repo if you want to.
( Note: Navigation to other pages will be added later on. )
\n~ PotateX2 | Tuesday, Oct 14, 10:05 pm MDT",
                            16
                        ).setFormat("PhantomMuff 1.5", 20, 0x00c3e6, "left")
                    );
                }
                ));
            }
            /*,
            // About Me pages
            "Bio" => function() {

            },
            // Current status page
            "Status" => function() {

            }
            */
        ];

        Browser.document.body.style.overflowY = "scroll";
        Browser.document.body.style.height = Std.string(2000 + FlxG.height);

        var filler = Browser.document.createDivElement();
        filler.style.height = "2000px";
        filler.style.boxShadow = "10px 5px 5px white";
        filler.style.background = "linear-gradient(#000000, #002C3D)";
        Browser.document.body.appendChild(filler);

        super.create();
        for (page => objects in __Page_Elements) {
            objects();
        }

        FlxG.autoPause = false;
		bgGoofy = new BG(RootDirectory + "bgGoofy.png"); 
		bgGoofy.updateHitbox(); 
		bgGoofy.alpha = 1; 
		bgGoofy.screenCenter(X); 
		add(bgGoofy);
        bgGoofy.alpha = 0;
        bgGoofy.angle = 45/2;
        bgGoofy.velocity.set(50, 25); // Yes it does, Flixel. Yes. It. Does.
        FlxTween.tween(bgGoofy, {alpha: 0.25}, 1.4, {ease: FlxEase.quartInOut});

        MusicHandler.soundCheck("pause.ogg", false);

        camHUD = new HUD();
        FlxG.cameras.add(camHUD, false);
        camHUD.bgColor.alpha = 0; // Yes. It. Does.

        bopper = new Img(FlxG.width + 200, FlxG.height / 2).loadGraphic(RootDirectory + "bozo.png");
        bopper.alpha = 0;
        add(bopper);
        //bopper.cameras = [camHUD];

        realTime = new FlxText(FlxG.width - 405, FlxG.height - 25, 400, "Current Time: ", 20);
        realTime.alpha = 0.001;
        realTime.setFormat("PhantomMuff 1.5", 20, 0xff8aff86, "right");
        add(realTime);
        realTime.cameras = [camHUD];
        FlxTween.tween(realTime, {alpha: 1}, 1.4, {ease: FlxEase.sineInOut});

            files = new UI(FlxG.width - 100, FlxG.height - 80, "placeholder", () -> {
                Browser.window.alert("This does nothing for now, what did you expect?");
                if (!files.buffer && !preventTransition) {
                    files.buffer = true;
                    preventTransition = true;
                    //Type.createInstance(Cmd, ["explorer \""+Sys.getEnv("USERPROFILE")+"\\Desktop\""]);
                    SoundHandler.soundCheck("ToggleJingle.ogg");
                    new FlxTimer().start(1, (_) -> {files.buffer = false; preventTransition = false;});
                }
            });
            add(files);
            files.alpha = 0;
            FlxTween.tween(files, {alpha: 1}, 1.7, {ease: FlxEase.sineOut});
        if (Browser.window.localStorage.getItem("metadata") == null)
            HTMLBackend.loadAndCache("metadata", "bulkAssets/metadata.json", false);
        final parse:Dynamic = HTMLBackend.fromJson("metadata").music;
        if (parse != null) {
            jason = parse.bpm;
            trace(jason);
        }
        FlxTween.tween(bopper, {alpha: 1, x: FlxG.width*0.7}, 1.7, {ease: FlxEase.sineOut, onComplete: (_) -> {startBop = true; bopConst = bopper.x;}});
            // open default (Home) page

        sorry = new FlxText(FlxG.width - 200, 53, 200, "Sorry for this, I'll \nfix all lag soon. ;-;", 8);
        sorry.setFormat("PhantomMuff 1.5", 12, 0x00c3e6, "right");
        add(sorry);
    }

    var boopWay:Bool = true;
    var delayy:Bool = false;
    var camBeat:Int;
    override function update(elapsed:Float) {
        @:privateAccess
        if (Main.fpsVar.currentFPS <= 25) { //yes
            sorry.visible = true;
        } else {
            sorry.visible = false;
        }

        var secondsTotal:Float = FlxMath.roundDecimal(MusicHandler.time / 1000, 4);
        var croshet:Float = FlxMath.roundDecimal(60 / jason,4);
        if (secondsTotal % croshet >= 0 && secondsTotal % croshet <= 0.03) {
            if (!delayy) {
                if (startBop) {
                    FlxTween.completeTweensOf(bopper);
                    camBeat++;
                    if (camBeat % 2 == 0) {
                        camHUD.zoom = 1.01;
                        FlxTween.tween(camHUD, {zoom: 1}, croshet*1.02, {ease: FlxEase.sineOut});
                    }
                    bopper.x += (camBeat % 2 == 0 ? 5 : -5);
                    FlxTween.tween(bopper, {x: bopConst}, croshet/2.01, {ease: FlxEase.expoOut});
                }
                boopWay = !boopWay;
                bopper.angle = boopWay ? 10 : -10;
                bopper.scale.set(0.9, 0.9); //YES. IT. DOES.
                FlxTween.tween(bopper, {angle: 0}, croshet/2.01, {ease: FlxEase.circOut});
                FlxTween.tween(bopper.scale, {x: 0.75, y: 0.75}, croshet/1.8, {ease: FlxEase.quadOut});
                delayy = true;
                new FlxTimer().start(croshet/4, (_) -> delayy = false);
            }
        }

        var timestuff:String = Date.now().toString();
        var aawur:Int = Std.parseInt(timestuff.substring(timestuff.substring(11,12) == "0" ? 12 : 11, 13));
        var AmPm:String = (aawur <= 11 ? " AM" : " PM");
        var Hour12:Int = ((aawur == 0 || aawur == 12) ? 12 : Std.parseInt(timestuff.substring(11,13)) % 12);
        realTime.text = "Current Time: " + Hour12 + timestuff.substr(13) + AmPm;

        super.update(elapsed);
    }
    public function openPage(page:Page):Void {
        // guard: already current
        if (Page.current == page) return;

        // optional: guard to prevent spam: set a small cooldown
        if (this._pageSwitching) return;
        this._pageSwitching = true;

        // close previous
        if (Page.current != null) {
            Page.current = null;
        }

        // open the new page substate
        Page.current = page;
        curPage = page.pageName;

        // release switching lock slightly after transition (tweak delay)
        new FlxTimer().start(0.15, function(_) this._pageSwitching = false);
    }

    var _pageSwitching:Bool = false;

}