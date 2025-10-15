package;

import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import flixel.ui.FlxSpriteButton;
import classes.FPSCounter;
import openfl.Lib;
import js.Browser;
import flixel.FlxG;
import flixel.system.FlxSplash;
import openfl.display.Sprite; //for main ig
import openfl.display.StageScaleMode;
import flixel.FlxGame;
import openfl.events.Event;

class Main extends Sprite {
	/**
		Window initialization settings for FlxGame, derived from Psych Engine.

		You're not making ANOTHER main state, so don't bother taking out `static`.
	**/
    static var state = {
		width: Browser.window.innerWidth, // WINDOW width
		height: Browser.window.innerHeight, // WINDOW height
		initialState: states.Load, // starting state
		zoom: -1.0, // game state bounds, SET TO -1 FOR CALCULATIONS
		framerate: 45,
		skipSplash: true, // Flixel splash (note: putting splash after instead of right on init ;P )
		startFullscreen: false
	};
	private var initButton:FlxSpriteButton;
	public static var fpsVar:FPSCounter;
    
	public function new() {
        super();

        if (stage != null) {
			init();
		}
		else
			addEventListener(Event.ADDED_TO_STAGE, init);
    }

    public static function main():Void
	{
		Lib.current.addChild(new Main());
	}
    private function init(?E:Event):Void {
        if (hasEventListener(Event.ADDED_TO_STAGE)) {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			setupGame();
		}
    }
    private function setupGame() {
		FlxSplash.creditOverride(Context.Custom("bulkAssets/bozo.png"));
		FlxG.autoPause = false;
		Lib.current.stage.align = "tl";
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
        var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight; //yes

		if (state.zoom == -1.0)
		{
			var ratioX:Float = stageWidth / state.width;
			var ratioY:Float = stageHeight / state.height;
			state.zoom = Math.min(ratioX, ratioY);
			state.width = Math.ceil(stageWidth / state.zoom);
			state.height = Math.ceil(stageHeight / state.zoom);
		}
        addChild(new FlxGame(state.width, state.height, state.initialState, #if (flixel < "5.0.0") state.zoom, #end state.framerate, state.framerate, state.skipSplash, state.startFullscreen));
		
		fpsVar = new FPSCounter(stageWidth * 0.8, 3, 0xFFFFFF);
		fpsVar.defaultTextFormat = new TextFormat("_sans", 14, 0xffffffff, false, false, false, null, null, TextFormatAlign.RIGHT);
		addChild(fpsVar);
		fpsVar.visible = true;	
		trace("%%%%% Post-setup %%%%%\n");
    }
}