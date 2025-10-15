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
    public var pageName:String;
    public var isHome:Bool;
    public var inited:Bool = false;
    // OKAY I GET GROUPS NOWWWWW YEEEAHHHH
    /**
        __Note:__ Icons for href links must be manually initialized with `pushToHeader()`.

        @param pageName Self-explanatory.
        @param objectList FlxSprite elements to add to this page group.
        @param isHome __Optional:__ Is this the home page? (Why did I put this again?)
    */
    public function new(pageName:String, objectList:Array<Dynamic>, isHome:Bool = false) {
        super();
        instance = this;
        this.pageName = pageName;
        this.isHome = isHome;
        for (element in objectList) {
            addToPage(element);
        }
        if (!isHome) this.visible = false;
        trace(this);
    }
    /**
        Helper class that adds the FlxSprite element to the page group.
    */
    static function addToPage(object:Dynamic) {
        instance.add(object);   
    }
}
