package classes;

import flixel.sound.FlxSound;
import flixel.FlxG;
import states.WebStatusState;

/**
    Inline audio handler for both music and sound.
    
*/
class PathSound extends FlxSound {
    var RootDirectory:String = "bulkAssets/";
    /**
        Don't know why I made this. Oh well, it's still helpful so
        proper description'll be added here soon.

        - PotateX2
        
        ### NOTE: Path points to bulkAssets folder.
        @param path File path to point to target audio.
        @param isSound Whether the target is music and should be cached, or
        only a playOnce sound (for sound handlers because I cba
        calling `FlxG.sound.play()` constantly)
    **/
    public function soundCheck(path:String, sound:Bool = true):Void {
        if (this == null /* || !FileSystem.exists(RootDirectory + path)*/ ) {
            trace("### no sound.");
            return;
        }
        try {
            this.loadEmbedded(RootDirectory + path, !sound);
            FlxG.sound.list.add(this);
            trace('$path | in '+FlxG.sound.list);
            this.play();
        } catch(nul) throw nul;
    }
}