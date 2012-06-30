package installers;


import data.Asset;
import haxe.io.Path;
import sys.FileSystem;


/**
 * ...
 * @author Joshua Granick
 */

class HTML5Installer extends InstallerBase {
	
	
	override function build ():Void {
		
		var hxml:String = buildDirectory + "/html5/haxe/" + (debug ? "debug" : "release") + ".hxml";
		
		runCommand ("", "haxe", [ hxml ] );
		
		if (targetFlags.exists ("minify")) {
			
			if (defines.exists ("JAVA_HOME")) {
				
				Sys.putEnv ("JAVA_HOME", defines.get ("JAVA_HOME"));
				
			}
			
			var sourceFile = buildDirectory + "/html5/bin/" + defines.get ("APP_FILE") + ".js";
			var tempFile = buildDirectory + "/html5/bin/_" + defines.get ("APP_FILE") + ".js";
			
			FileSystem.rename (sourceFile, tempFile);
			
			runCommand ("", "java", [ "-jar", NME + "/tools/command-line/bin/yuicompressor-2.4.7.jar", "-o", sourceFile, tempFile ]);
			
			FileSystem.deleteFile (tempFile);
			
		}
		
	}
	
	
	override function clean ():Void {
		
		var targetPath = buildDirectory + "/html5";
		
		if (FileSystem.exists (targetPath)) {
			
			removeDirectory (targetPath);
			
		}
		
	}
	
	
	private function generateFontData (font:Asset, destination:String):Void {
		
		var sourcePath = font.sourcePath;
		var targetPath = destination + font.targetPath;
		
		if (!FileSystem.exists (FileSystem.fullPath (sourcePath) + ".hash")) {
			
			runCommand (Path.directory (targetPath), "neko", [ NME + "/tools/command-line/html5/hxswfml.n", "ttf2hash", FileSystem.fullPath (sourcePath), "-glyphs", "32-255" ] );
			
		}
		
		context.HAXE_FLAGS += "\n-resource " + FileSystem.fullPath (sourcePath) + ".hash@NME_" + font.flatName;
		
	}
	
	
	override function run ():Void {
		
		var destination:String = buildDirectory + "/html5/bin";
		var dotSlash:String = "./";
		
		if (InstallTool.isWindows) {
			
			if (defines.exists ("DEV_URL"))
				runCommand (destination, defines.get("DEV_URL"), []);
			else
				runCommand (destination, ".\\index.html", []);
			
		} else if (InstallTool.isMac) {
			
			if (defines.exists ("DEV_URL"))
				runCommand (destination, "open", [ defines.get("DEV_URL") ]);
			else
				runCommand (destination, "open", [ "index.html" ]);
			
		} else {
			
			if (defines.exists ("DEV_URL"))
				runCommand (destination, "xdg-open", [ defines.get("DEV_URL") ]);
			else
				runCommand (destination, "xdg-open", [ "index.html" ]);
			
		}
		
	}
	
	
	override function update ():Void {
		
		var destination:String = buildDirectory + "/html5/bin/";
		mkdir (destination);
		
		for (asset in assets) {
			
			if (asset.type != Asset.TYPE_TEMPLATE) {
				
				mkdir (Path.directory (destination + asset.targetPath));
				
				if (asset.type != Asset.TYPE_FONT) {
					
					// going to root directory now, but should it be a forced "assets" folder later?
					
					copyIfNewer (asset.sourcePath, destination + asset.targetPath);
					
				} else {
					
					generateFontData (asset, destination);
					
				}
				
			}
			
		}
		
		recursiveCopy (NME + "/tools/command-line/html5/template", destination);
		recursiveCopy (NME + "/tools/command-line/haxe", buildDirectory + "/html5/haxe");
		recursiveCopy (NME + "/tools/command-line/html5/haxe", buildDirectory + "/html5/haxe");
		recursiveCopy (NME + "/tools/command-line/html5/hxml", buildDirectory + "/html5/haxe");
		
		for (asset in assets) {
						
			if (asset.type == Asset.TYPE_TEMPLATE) {
				
				mkdir (Path.directory (destination + asset.targetPath));
				copyFile (asset.sourcePath, destination + asset.targetPath);
				
			}
			
		}
		
	}
	
	
}