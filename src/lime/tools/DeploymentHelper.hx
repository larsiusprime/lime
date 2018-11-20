package lime.tools;


import hxp.*;
import lime.tools.HXProject;


class DeploymentHelper {


	public static function deploy (project:HXProject, targetFlags:Map<String, String>, targetDirectory:String, targetName:String) {

		var name = project.meta.title + " (" + project.meta.version + " build " + project.meta.buildNumber + ") (" + targetName + ").zip";
		var targetPath = Path.combine (targetDirectory + "/dist", name);

		System.compress (Path.combine (targetDirectory, "bin"), targetPath);

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

			System.runCommand ("", "drive", args);

		}
		else if (targetFlags.exists ("skicka")) {
			
			var targetDir = Path.combine(targetDirectory, "dist");
			var destination = targetFlags.get("destination");
			
			if (destination != null && destination != "") {
				
				var args = [];
				
				if (targetFlags.exists("tokencache")) {
					
					args.push ("-tokencache");
					args.push (targetFlags.get("tokencache"));
					
				}
				
				args.push("upload");
				
				if (targetFlags.exists("dry-run")) {
					
					args.push ("-dry-run");
					
				}
				
				args.push(targetDir);
				args.push(destination);
				
				System.runCommand ("", "skicka", args);
				
			}
			
		}
	}


}
