package classes;

import flixel.ui.FlxButton;
import flixel.ui.FlxSpriteButton;
import flixel.tweens.*;

class UI extends FlxButton {
    public var buffer:Bool = false;
    public function new(x:Int, y:Int, text:String, func:Void->Void) {
        super(x, y, text, func);
    }
}

class PageNav extends FlxSpriteButton {
    public function new(dest:Void->Void, x:Float = 0, y:Float = 0, ?img:FlxSprite) {
        super(x, y, img, dest);
        final defY = y;

        this.onOver.callback = () -> {
            FlxTween.cancelTweensOf(this);
            FlxTween.tween(this, {"scale.x": 1.1, "scale.y": 1.1, y: this.y - 10}, 0.5, {ease: FlxEase.circOut});
        };
        this.onOut.callback = () -> {
            FlxTween.cancelTweensOf(this);
            FlxTween.tween(this, {"scale.x": 1, "scale.y": 1, y: defY}, 0.5, {ease: FlxEase.circOut});
        };
        this.onDown.callback = () -> {
            FlxTween.cancelTweensOf(this);
            this.scale.x -= 0.2;
            this.scale.y -= 0.2;
        };
        this.onUp.callback = () -> {
            dest();
            FlxTween.cancelTweensOf(this);
            this.scale.x += 0.2;
            this.scale.y += 0.2;
        };
    }
}

class