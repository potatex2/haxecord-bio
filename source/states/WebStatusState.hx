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
    var camHUD:HUD;

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

    var PageDirectory:Array<String> = ["Home", "Bio", "Status"];
    var pageList:Array<Page> = [];
    var preventTransition:Bool = false;
    override function create() {
        camList.add(camHome);
        camList.add(camBio);
        camList.add(camStatus);
        trace(camList);

        var notHomeSet:Bool = true;
        var iter:Int = 0;
        for (name => callback in Page.camFuncs) {
            pageList[iter] = new Page(PageDirectory[iter], camList.members[iter], callback, notHomeSet);
            iter++;
            if (notHomeSet) notHomeSet = false;
        }
        Browser.document.body.style.overflowY = "scroll";
        Browser.document.body.style.height = Std.string(2000 + FlxG.height);

        var filler = Browser.document.createDivElement();
        filler.style.height = "2000px";
        filler.style.boxShadow = "10px 5px 5px white";
        filler.style.background = "linear-gradient(#000000, #002C3D)";
        Browser.document.body.appendChild(filler);

        super.create();

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
        trace(bopper);
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
        FlxTween.tween(bopper, {alpha: 1, x: FlxG.width/2}, 1.7, {ease: FlxEase.sineOut, onComplete: (_) -> {startBop = true; bopConst = bopper.x;}});
        
    }

    var boopWay:Bool = true;
    var delayy:Bool = false;
    var camBeat:Int;
    override function update(elapsed:Float) {
        var secondsTotal:Float = FlxMath.roundDecimal(MusicHandler.time / 1000, 4);
        var croshet:Float = FlxMath.roundDecimal(60 / jason,4);
        if (secondsTotal % croshet >= 0 && secondsTotal % croshet <= 0.025) {
            if (!delayy) {
                if (startBop) {
                    FlxTween.completeTweensOf(bopper);
                    camBeat++;
                    if (camBeat % 2 == 0) {
                        camHUD.zoom = 1.01;
                        FlxTween.tween(camHUD, {zoom: 1}, croshet*1.02, {ease: FlxEase.sineOut});
                    }
                    bopper.x += (camBeat % 2 == 0 ? 5 : -5);
                    FlxTween.tween(bopper, {x: bopConst}, croshet/1.2, {ease: FlxEase.expoOut});
                }
                boopWay = !boopWay;
                bopper.angle = boopWay ? 10 : -10;
                bopper.scale.set(0.9, 0.9); //YES. IT. DOES.
                FlxTween.tween(bopper, {angle: 0}, croshet/1.4, {ease: FlxEase.circOut});
                FlxTween.tween(bopper.scale, {x: 0.75, y: 0.75}, croshet/1.5, {ease: FlxEase.quadOut});
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

}