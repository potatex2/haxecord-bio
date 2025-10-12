package;

import haxe.io.Bytes;
import haxe.io.Path;
import lime.utils.AssetBundle;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

#if disable_preloader_assets
@:dox(hide) class ManifestResources {
	public static var preloadLibraries:Array<Dynamic>;
	public static var preloadLibraryNames:Array<String>;
	public static var rootPath:String;

	public static function init (config:Dynamic):Void {
		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();
	}
}
#else
@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {


	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	public static var rootPath:String;


	public static function init (config:Dynamic):Void {

		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();

		rootPath = null;

		if (config != null && Reflect.hasField (config, "rootPath")) {

			rootPath = Reflect.field (config, "rootPath");

			if(!StringTools.endsWith (rootPath, "/")) {

				rootPath += "/";

			}

		}

		if (rootPath == null) {

			#if (ios || tvos || webassembly)
			rootPath = "assets/";
			#elseif android
			rootPath = "";
			#elseif (console || sys)
			rootPath = lime.system.System.applicationDirectory;
			#else
			rootPath = "./";
			#end

		}

		#if (openfl && !flash && !display)
		openfl.text.Font.registerFont (__ASSET__OPENFL__bulkassets_phantommuff_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_monsterrat_ttf);
		
		#end

		var data, manifest, library, bundle;

		data = '{"name":null,"assets":"aoy4:pathy24:bulkAssets%2FbgGoofy.pngy4:sizei9125y4:typey5:IMAGEy2:idR1y7:preloadtgoR0y21:bulkAssets%2Fbozo.pngR2i28469R3R4R5R7R6tgoR2i5681R3y5:SOUNDR5y24:bulkAssets%2FclickIn.oggy9:pathGroupaR9hR6tgoR2i5432R3R8R5y25:bulkAssets%2FclickOut.oggR10aR11hR6tgoR0y21:bulkAssets%2Ficon.pngR2i24322R3R4R5R12R6tgoR0y23:bulkAssets%2Ficon64.pngR2i5550R3R4R5R13R6tgoR0y26:bulkAssets%2Fmetadata.jsonR2i192R3y4:TEXTR5R14R6tgoR0y25:bulkAssets%2FmusicBar.pngR2i744R3R4R5R16R6tgoR0y32:bulkAssets%2FnavIcons%2FHome.pngR2i71060R3R4R5R17R6tgoR2i632783R3R8R5y22:bulkAssets%2Fpause.oggR10aR18hR6tgoR2i46252R3y4:FONTy9:classNamey35:__ASSET__bulkassets_phantommuff_ttfR5y28:bulkAssets%2FPhantomMuff.ttfR6tgoR2i69071R3R8R5y29:bulkAssets%2FToggleJingle.oggR10aR23hR6tgoR2i2563R3y5:MUSICR5y26:flixel%2Fsounds%2Fbeep.mp3R10aR25y26:flixel%2Fsounds%2Fbeep.ogghR6tgoR2i39706R3R24R5y28:flixel%2Fsounds%2Fflixel.mp3R10aR27y28:flixel%2Fsounds%2Fflixel.ogghR6tgoR2i5636R3R8R5R26R10aR25R26hgoR2i33629R3R8R5R28R10aR27R28hgoR2i15744R3R19R20y35:__ASSET__flixel_fonts_nokiafc22_ttfR5y30:flixel%2Ffonts%2Fnokiafc22.ttfR6tgoR2i29724R3R19R20y36:__ASSET__flixel_fonts_monsterrat_ttfR5y31:flixel%2Ffonts%2Fmonsterrat.ttfR6tgoR0y33:flixel%2Fimages%2Fui%2Fbutton.pngR2i277R3R4R5R33R6tgoR0y36:flixel%2Fimages%2Flogo%2Fdefault.pngR2i505R3R4R5R34R6tgoR0y34:flixel%2Fflixel-ui%2Fimg%2Fbox.pngR2i75R3R4R5R35R6tgoR0y37:flixel%2Fflixel-ui%2Fimg%2Fbutton.pngR2i211R3R4R5R36R6tgoR0y48:flixel%2Fflixel-ui%2Fimg%2Fbutton_arrow_down.pngR2i216R3R4R5R37R6tgoR0y48:flixel%2Fflixel-ui%2Fimg%2Fbutton_arrow_left.pngR2i222R3R4R5R38R6tgoR0y49:flixel%2Fflixel-ui%2Fimg%2Fbutton_arrow_right.pngR2i238R3R4R5R39R6tgoR0y46:flixel%2Fflixel-ui%2Fimg%2Fbutton_arrow_up.pngR2i227R3R4R5R40R6tgoR0y42:flixel%2Fflixel-ui%2Fimg%2Fbutton_thin.pngR2i118R3R4R5R41R6tgoR0y44:flixel%2Fflixel-ui%2Fimg%2Fbutton_toggle.pngR2i254R3R4R5R42R6tgoR0y40:flixel%2Fflixel-ui%2Fimg%2Fcheck_box.pngR2i101R3R4R5R43R6tgoR0y41:flixel%2Fflixel-ui%2Fimg%2Fcheck_mark.pngR2i97R3R4R5R44R6tgoR0y37:flixel%2Fflixel-ui%2Fimg%2Fchrome.pngR2i135R3R4R5R45R6tgoR0y42:flixel%2Fflixel-ui%2Fimg%2Fchrome_flat.pngR2i124R3R4R5R46R6tgoR0y43:flixel%2Fflixel-ui%2Fimg%2Fchrome_inset.pngR2i102R3R4R5R47R6tgoR0y43:flixel%2Fflixel-ui%2Fimg%2Fchrome_light.pngR2i118R3R4R5R48R6tgoR0y44:flixel%2Fflixel-ui%2Fimg%2Fdropdown_mark.pngR2i86R3R4R5R49R6tgoR0y41:flixel%2Fflixel-ui%2Fimg%2Ffinger_big.pngR2i1337R3R4R5R50R6tgoR0y43:flixel%2Fflixel-ui%2Fimg%2Ffinger_small.pngR2i157R3R4R5R51R6tgoR0y38:flixel%2Fflixel-ui%2Fimg%2Fhilight.pngR2i74R3R4R5R52R6tgoR0y36:flixel%2Fflixel-ui%2Fimg%2Finvis.pngR2i72R3R4R5R53R6tgoR0y41:flixel%2Fflixel-ui%2Fimg%2Fminus_mark.pngR2i77R3R4R5R54R6tgoR0y40:flixel%2Fflixel-ui%2Fimg%2Fplus_mark.pngR2i83R3R4R5R55R6tgoR0y36:flixel%2Fflixel-ui%2Fimg%2Fradio.pngR2i108R3R4R5R56R6tgoR0y40:flixel%2Fflixel-ui%2Fimg%2Fradio_dot.pngR2i81R3R4R5R57R6tgoR0y37:flixel%2Fflixel-ui%2Fimg%2Fswatch.pngR2i94R3R4R5R58R6tgoR0y34:flixel%2Fflixel-ui%2Fimg%2Ftab.pngR2i106R3R4R5R59R6tgoR0y39:flixel%2Fflixel-ui%2Fimg%2Ftab_back.pngR2i111R3R4R5R60R6tgoR0y44:flixel%2Fflixel-ui%2Fimg%2Ftooltip_arrow.pngR2i176R3R4R5R61R6tgoR0y39:flixel%2Fflixel-ui%2Fxml%2Fdefaults.xmlR2i1263R3R15R5R62R6tgoR0y53:flixel%2Fflixel-ui%2Fxml%2Fdefault_loading_screen.xmlR2i1953R3R15R5R63R6tgoR0y44:flixel%2Fflixel-ui%2Fxml%2Fdefault_popup.xmlR2i1848R3R15R5R64R6tgoR0y42:flixel%2Fimages%2Ftransitions%2Fcircle.pngR2i299R3R4R5R65R6tgoR0y53:flixel%2Fimages%2Ftransitions%2Fdiagonal_gradient.pngR2i730R3R4R5R66R6tgoR0y43:flixel%2Fimages%2Ftransitions%2Fdiamond.pngR2i236R3R4R5R67R6tgoR0y42:flixel%2Fimages%2Ftransitions%2Fsquare.pngR2i209R3R4R5R68R6tgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
		

		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		

	}


}

#if !display
#if flash

@:keep @:bind @:noCompletion #if display private #end class __ASSET__bulkassets_bggoofy_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__bulkassets_bozo_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__bulkassets_clickin_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__bulkassets_clickout_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__bulkassets_icon_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__bulkassets_icon64_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__bulkassets_metadata_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__bulkassets_musicbar_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__bulkassets_navicons_home_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__bulkassets_pause_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__bulkassets_phantommuff_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__bulkassets_togglejingle_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_box_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_down_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_left_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_right_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_up_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_thin_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_toggle_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_check_box_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_check_mark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_flat_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_inset_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_light_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_dropdown_mark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_finger_big_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_finger_small_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_hilight_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_invis_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_minus_mark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_plus_mark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_radio_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_radio_dot_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_swatch_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_tab_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_tab_back_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_tooltip_arrow_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_xml_defaults_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_xml_default_loading_screen_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_xml_default_popup_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_transitions_circle_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_transitions_diagonal_gradient_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_transitions_diamond_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_transitions_square_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:keep @:image("bulkAssets/bgGoofy.png") @:noCompletion #if display private #end class __ASSET__bulkassets_bggoofy_png extends lime.graphics.Image {}
@:keep @:image("bulkAssets/bozo.png") @:noCompletion #if display private #end class __ASSET__bulkassets_bozo_png extends lime.graphics.Image {}
@:keep @:file("bulkAssets/clickIn.ogg") @:noCompletion #if display private #end class __ASSET__bulkassets_clickin_ogg extends haxe.io.Bytes {}
@:keep @:file("bulkAssets/clickOut.ogg") @:noCompletion #if display private #end class __ASSET__bulkassets_clickout_ogg extends haxe.io.Bytes {}
@:keep @:image("bulkAssets/icon.png") @:noCompletion #if display private #end class __ASSET__bulkassets_icon_png extends lime.graphics.Image {}
@:keep @:image("bulkAssets/icon64.png") @:noCompletion #if display private #end class __ASSET__bulkassets_icon64_png extends lime.graphics.Image {}
@:keep @:file("bulkAssets/metadata.json") @:noCompletion #if display private #end class __ASSET__bulkassets_metadata_json extends haxe.io.Bytes {}
@:keep @:image("bulkAssets/musicBar.png") @:noCompletion #if display private #end class __ASSET__bulkassets_musicbar_png extends lime.graphics.Image {}
@:keep @:image("bulkAssets/navIcons/Home.png") @:noCompletion #if display private #end class __ASSET__bulkassets_navicons_home_png extends lime.graphics.Image {}
@:keep @:file("bulkAssets/pause.ogg") @:noCompletion #if display private #end class __ASSET__bulkassets_pause_ogg extends haxe.io.Bytes {}
@:keep @:font("output/html5/obj/webfont/PhantomMuff.ttf") @:noCompletion #if display private #end class __ASSET__bulkassets_phantommuff_ttf extends lime.text.Font {}
@:keep @:file("bulkAssets/ToggleJingle.ogg") @:noCompletion #if display private #end class __ASSET__bulkassets_togglejingle_ogg extends haxe.io.Bytes {}
@:keep @:file("C:/Users/PotateX2/lime/flixel/5,8,0/assets/sounds/beep.mp3") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends haxe.io.Bytes {}
@:keep @:file("C:/Users/PotateX2/lime/flixel/5,8,0/assets/sounds/flixel.mp3") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends haxe.io.Bytes {}
@:keep @:file("C:/Users/PotateX2/lime/flixel/5,8,0/assets/sounds/beep.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends haxe.io.Bytes {}
@:keep @:file("C:/Users/PotateX2/lime/flixel/5,8,0/assets/sounds/flixel.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends haxe.io.Bytes {}
@:keep @:font("output/html5/obj/webfont/nokiafc22.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font {}
@:keep @:font("output/html5/obj/webfont/monsterrat.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font {}
@:keep @:image("C:/Users/PotateX2/lime/flixel/5,8,0/assets/images/ui/button.png") @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends lime.graphics.Image {}
@:keep @:image("C:/Users/PotateX2/lime/flixel/5,8,0/assets/images/logo/default.png") @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends lime.graphics.Image {}
@:keep @:image("C:/Users/PotateX2/lime/flixel-ui/2,6,3/assets/images/box.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_box_png extends lime.graphics.Image {}
@:keep @:image("C:/Users/PotateX2/lime/flixel-ui/2,6,3/assets/images/button.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_png extends lime.graphics.Image {}
@:keep @:image("C:/Users/PotateX2/lime/flixel-ui/2,6,3/assets/images/button_arrow_down.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_down_png extends lime.graphics.Image {}
@:keep @:image("C:/Users/PotateX2/lime/flixel-ui/2,6,3/assets/images/button_arrow_left.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_left_png extends lime.graphics.Image {}
@:keep @:image("C:/Users/PotateX2/lime/flixel-ui/2,6,3/assets/images/button_arrow_right.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_right_png extends lime.graphics.Image {}
@:keep @:image("C:/Users/PotateX2/lime/flixel-ui/2,6,3/assets/images/button_arrow_up.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_up_png extends lime.graphics.Image {}
@:keep @:image("C:/Users/PotateX2/lime/flixel-ui/2,6,3/assets/images/button_thin.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_thin_png extends lime.graphics.Image {}
@:keep @:image("C:/Users/PotateX2/lime/flixel-ui/2,6,3/assets/images/button_toggle.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_toggle_png extends lime.graphics.Image {}
@:keep @:image("C:/Users/PotateX2/lime/flixel-ui/2,6,3/assets/images/check_box.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_check_box_png extends lime.graphics.Image {}
@:keep @:image("C:/Users/PotateX2/lime/flixel-ui/2,6,3/assets/images/check_mark.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_check_mark_png extends lime.graphics.Image {}
@:keep @:image("C:/Users/PotateX2/lime/flixel-ui/2,6,3/assets/images/chrome.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_png extends lime.graphics.Image {}
@:keep @:image("C:/Users/PotateX2/lime/flixel-ui/2,6,3/assets/images/chrome_flat.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_flat_png extends lime.graphics.Image {}
@:keep @:image("C:/Users/PotateX2/lime/flixel-ui/2,6,3/assets/images/chrome_inset.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_inset_png extends lime.graphics.Image {}
@:keep @:image("C:/Users/PotateX2/lime/flixel-ui/2,6,3/assets/images/chrome_light.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_light_png extends lime.graphics.Image {}
@:keep @:image("C:/Users/PotateX2/lime/flixel-ui/2,6,3/assets/images/dropdown_mark.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_dropdown_mark_png extends lime.graphics.Image {}
@:keep @:image("C:/Users/PotateX2/lime/flixel-ui/2,6,3/assets/images/finger_big.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_finger_big_png extends lime.graphics.Image {}
@:keep @:image("C:/Users/PotateX2/lime/flixel-ui/2,6,3/assets/images/finger_small.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_finger_small_png extends lime.graphics.Image {}
@:keep @:image("C:/Users/PotateX2/lime/flixel-ui/2,6,3/assets/images/hilight.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_hilight_png extends lime.graphics.Image {}
@:keep @:image("C:/Users/PotateX2/lime/flixel-ui/2,6,3/assets/images/invis.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_invis_png extends lime.graphics.Image {}
@:keep @:image("C:/Users/PotateX2/lime/flixel-ui/2,6,3/assets/images/minus_mark.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_minus_mark_png extends lime.graphics.Image {}
@:keep @:image("C:/Users/PotateX2/lime/flixel-ui/2,6,3/assets/images/plus_mark.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_plus_mark_png extends lime.graphics.Image {}
@:keep @:image("C:/Users/PotateX2/lime/flixel-ui/2,6,3/assets/images/radio.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_radio_png extends lime.graphics.Image {}
@:keep @:image("C:/Users/PotateX2/lime/flixel-ui/2,6,3/assets/images/radio_dot.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_radio_dot_png extends lime.graphics.Image {}
@:keep @:image("C:/Users/PotateX2/lime/flixel-ui/2,6,3/assets/images/swatch.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_swatch_png extends lime.graphics.Image {}
@:keep @:image("C:/Users/PotateX2/lime/flixel-ui/2,6,3/assets/images/tab.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_tab_png extends lime.graphics.Image {}
@:keep @:image("C:/Users/PotateX2/lime/flixel-ui/2,6,3/assets/images/tab_back.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_tab_back_png extends lime.graphics.Image {}
@:keep @:image("C:/Users/PotateX2/lime/flixel-ui/2,6,3/assets/images/tooltip_arrow.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_tooltip_arrow_png extends lime.graphics.Image {}
@:keep @:file("C:/Users/PotateX2/lime/flixel-ui/2,6,3/assets/xml/defaults.xml") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_xml_defaults_xml extends haxe.io.Bytes {}
@:keep @:file("C:/Users/PotateX2/lime/flixel-ui/2,6,3/assets/xml/default_loading_screen.xml") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_xml_default_loading_screen_xml extends haxe.io.Bytes {}
@:keep @:file("C:/Users/PotateX2/lime/flixel-ui/2,6,3/assets/xml/default_popup.xml") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_xml_default_popup_xml extends haxe.io.Bytes {}
@:keep @:image("C:/Users/PotateX2/lime/flixel-addons/3,3,0/assets/images/transitions/circle.png") @:noCompletion #if display private #end class __ASSET__flixel_images_transitions_circle_png extends lime.graphics.Image {}
@:keep @:image("C:/Users/PotateX2/lime/flixel-addons/3,3,0/assets/images/transitions/diagonal_gradient.png") @:noCompletion #if display private #end class __ASSET__flixel_images_transitions_diagonal_gradient_png extends lime.graphics.Image {}
@:keep @:image("C:/Users/PotateX2/lime/flixel-addons/3,3,0/assets/images/transitions/diamond.png") @:noCompletion #if display private #end class __ASSET__flixel_images_transitions_diamond_png extends lime.graphics.Image {}
@:keep @:image("C:/Users/PotateX2/lime/flixel-addons/3,3,0/assets/images/transitions/square.png") @:noCompletion #if display private #end class __ASSET__flixel_images_transitions_square_png extends lime.graphics.Image {}
@:keep @:file("") @:noCompletion #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else

@:keep @:expose('__ASSET__bulkassets_phantommuff_ttf') @:noCompletion #if display private #end class __ASSET__bulkassets_phantommuff_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "bulkAssets/PhantomMuff"; #else ascender = 1913; descender = -419; height = 2356; numGlyphs = 235; underlinePosition = -292; underlineThickness = 150; unitsPerEM = 2048; #end name = "PhantomMuff 1.5"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/nokiafc22"; #else ascender = 2048; descender = -512; height = 2816; numGlyphs = 172; underlinePosition = -640; underlineThickness = 256; unitsPerEM = 2048; #end name = "Nokia Cellphone FC Small"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/monsterrat"; #else ascender = 968; descender = -251; height = 1219; numGlyphs = 263; underlinePosition = -150; underlineThickness = 50; unitsPerEM = 1000; #end name = "Monsterrat"; super (); }}


#end

#if (openfl && !flash)

#if html5
@:keep @:expose('__ASSET__OPENFL__bulkassets_phantommuff_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__bulkassets_phantommuff_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__bulkassets_phantommuff_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#else
@:keep @:expose('__ASSET__OPENFL__bulkassets_phantommuff_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__bulkassets_phantommuff_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__bulkassets_phantommuff_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#end

#end
#end

#end