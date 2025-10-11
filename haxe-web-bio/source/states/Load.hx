package states;

import flixel.ui.FlxSpriteButton;
import flixel.FlxG;
import states.WebStatusState;
import classes.PathSound;
import flixel.text.FlxText;
import flixel.tweens.*;
import flixel.util.FlxTimer;
/**
    Preloading stuff; sets the window bounds to small so that the scrolling
    background is still there and I can add FlxText elements.

    - PotateX2
*/
class Load extends FlxState {
    var lmao:FlxSpriteButton;
    var indicator:FlxText;
    var clickHandler:PathSound = new PathSound();
    public function new() {
        super();
        lmao = new FlxSpriteButton(0, 0, () -> {
            clickHandler.soundCheck("clickOut.ogg");
            new FlxTimer().start(0.1, (_) -> FlxG.switchState(new flixel.system.FlxSplash(new WebStatusState())));
        });
        lmao.loadGraphic("bulkAssets/bozo.png");
        overrideButtonCB();
        lmao.screenCenter();
        add(lmao);

        indicator = new FlxText(0, 0, 200, "load profile :P", 16);
        indicator.setFormat("PhantomMuff 1.5", 16, 0x00aeff, "CENTER");
        indicator.screenCenter();
        indicator.y += 100;
        add(indicator);
        indicator.alpha = 0;
    }
    private function overrideButtonCB() {
        // I cooould use the this keyword, but nah.
        lmao.onOver.callback = () -> {
            FlxTween.cancelTweensOf(lmao);
            FlxTween.tween(lmao, {"scale.x": 1.25, "scale.y": 1.25}, 0.5, {ease: FlxEase.circOut});
            FlxTween.cancelTweensOf(indicator);
            FlxTween.tween(indicator, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
        };
        lmao.onOut.callback = () -> {
            FlxTween.cancelTweensOf(lmao);
            FlxTween.tween(lmao, {"scale.x": 1, "scale.y": 1}, 0.5, {ease: FlxEase.circOut});
            FlxTween.cancelTweensOf(indicator);
            FlxTween.tween(indicator, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
        };
        lmao.onDown.callback = () -> {
            FlxTween.cancelTweensOf(lmao);
            lmao.scale.x -= 0.2;
            lmao.scale.y -= 0.2;
            FlxTween.cancelTweensOf(indicator);
            indicator.color = 0x0077ff;
            clickHandler.soundCheck("clickIn.ogg");
        };
    }
}