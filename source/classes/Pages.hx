package classes;

import flixel.group.FlxSpriteGroup;
import classes.UI;
import states.WebStatusState;
import flixel.FlxG;
import flixel.tweens.*;

/**
    Custom page class for streamlined element creation, rendering, and management.
    Creates a designated button with its named icon located in `navIcons/`.

    NTS: changed from camera instances to full-on `FlxSubState`s.
    
    - PotateX2
*/
class Page extends FlxSpriteGroup {
    // TO-DO: for-loop on each substate instance, closing non-current ones.
    public static var instance:Page = null;
    public static var current:Page = null;

    public var pageName:String;
    public var isHome:Bool;
    public var inited:Bool = false;
    // OKAY I GET GROUPS NOWWWWW YEEEAHHHH
    /**__Note:__ Icons for href links must be manually initialized with `pushToHeader()`.*/
    public function new(pageName:String, objectList:() -> Void, isHome:Bool = false) {
        super();
        instance = this;
        this.pageName = pageName;
        this.isHome = isHome;
        objectList();
        trace(this);
    }
    public static function addToPage(object:Dynamic) {
        instance.add(object);
    }
}
