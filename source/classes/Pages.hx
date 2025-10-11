package classes;

import flixel.FlxCamera as HUD;
import flixel.FlxG;
import flixel.tweens.*;

typedef CamObject = {
    var name:String;
    var camera:HUD;
}

/**
    Custom page class for streamlined element creation, rendering, and management.
    
    - PotateX2
*/
class Page {
    public static var camFuncs:Map<CamObject, Void->Void> = [];
    /**
        Bool flag for if elements have been initialized.    
    */
    public var exists:Bool = false;
    public var targetCam:HUD;
    public var callback:Void->Void;
    var temp:Dynamic;

    public function new(camName:String, camInstance:HUD, objCreation:()->Void, isHome:Bool) {
        callback = objCreation;
        camFuncs.set({name: camName, camera: camInstance}, objCreation);
        trace('$camFuncs | $camName');
        temp = camInstance;
        if (isHome) {
            this.initPage();
        }
    }
    function initPage() {
        if (!exists) {
            callback();
            exists = true;
        }
        switchCams(temp);
    }
    /**
        Helper function to iterate over cameras for page switching.    
    */
    function switchCams(target:HUD) {
        for (cam in FlxG.cameras.list) {
            if (target == cam) FlxTween.tween(cam, {alpha: 1}, 0.5, {ease: FlxEase.sineIn, startDelay: 0.5});
            else {FlxTween.tween(cam, {alpha: 0}, 0.5, {ease: FlxEase.sineIn}); trace("not the cam: "+ FlxG.cameras.list.indexOf(cam));}
        }
    }
    function Header() {}
}
