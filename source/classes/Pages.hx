package classes;

import flixel.FlxSubState;
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
class Page extends FlxSubState {
    // TO-DO: for-loop on each substate instance, closing non-current ones.
    public static var listOfPages:Array<Page> = [];

    public var pageName:String;
    public var callback:Void->Void;
    public var isHome:Bool;
    var temp:Dynamic;
    /**__Note:__ Icons for href links must be manually initialized with `pushToHeader()`.*/
    public function new(pageName:String, objCreation:()->Void, isHome:Bool = false) {
        super();
        persistentUpdate = true;
        this.pageName = pageName;
        callback = objCreation;
        this.isHome = isHome;
        initPage();
        listOfPages.push(this);
        trace(this);
    }
    function initPage() {
        callback();
    }
}
