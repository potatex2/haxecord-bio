package classes;

import haxe.Json;
import haxe.Http;
import js.Browser;
/**idk why i assigned any type here...*/
class HTMLBackend {
    //ty gpt ig...
    public static function loadAndCache(name:String, url:String, async:Bool):Void {
        var http = new Http(url);
        http.onData = function(raw:String) {
            Browser.window.localStorage.setItem(name, raw); // cache the text
            trace('Cached ' + name);
        }
        http.onError = function(err) {trace("Failed to fetch " + url + " | " + err);};
        http.request(async);
    }

    public static function fromJson(name:String):Dynamic {
        try {
            var targ:String = Browser.window.localStorage.getItem(name);
            trace(targ ?? "NO OBJECT VALUE");
            var obj:Null<Dynamic> = null;
            if (targ != null) {
                obj = Json.parse(targ);
            }
            return obj;
        } catch (e) {throw "$$$$$ Parse failed | "+e; return null;}
    }
}