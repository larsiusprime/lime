package lime.tools.helpers;


import lime.project.HXProject;


class DeploymentHelper {
	
	
	public static function deploy (project:HXProject, targetFlags:Map<String, String>, targetDirectory:String, targetName:String) {
		
		var name = project.meta.title + " (" + project.meta.version + " build " + project.meta.buildNumber + ") (" + targetName + ").zip";
		var targetPath = PathHelper.combine (targetDirectory + "/dist", sanitize(name));
		
		trace("DeploymentHelper.deploy() name = " + name + " targetDirectory = " + targetDirectory + " targetPath = " + targetPath);
		
		ZipHelper.compress (PathHelper.combine (targetDirectory, "bin"), targetPath);
		
		if (targetFlags.exists ("gdrive")) {
			
			var parent = targetFlags.get ("parent");
			
			var args = [ "upload" , "-f" , targetPath ];
			
			if (targetFlags.exists("config")) {
			
				args.push ("--config");
				args.push (targetFlags.get("config"));
				
			}
			
			if (parent != null && parent != "") {
				
				args.push ("-p");
				args.push (parent);
				
			}
			
			ProcessHelper.runCommand ("", "drive", args);
			
		}
		
	}
	
	
	private static function sanitize(str:String):String
	{
		var chars1 = [":", "/", "\\", "*", "?", "<", ">", "|"];
		var chars2 = ["-", "-",  "-", "_", "_", "_", "_", "_"];
		for (i in 0...chars1.length)
		{
			var char1 = chars1[i];
			var char2 = chars2[i];
			str = StringTools.replace(str, char1, char2);
		}
		return str;
	}
	
	
}
