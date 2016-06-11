#include <ui/FileDialog.h>
#include <stdio.h>

#include <tinyfiledialogs.c>

namespace lime {
	
	
	const char* FileDialog::OpenDirectory (const char* filter, const char* defaultPath) {
		
		char const * savePath = tinyfd_selectFolderDialog( "", defaultPath);
		if(savePath == NULL)
		{
			return 0;
		}
		return savePath;
	}
	
	
	const char* FileDialog::OpenFile (const char* filter, const char* defaultPath) {
		
		char const * savePath = tinyfd_openFileDialog ("", defaultPath, 0, NULL, NULL, 0);
		
		if(savePath == NULL)
		{
			return 0;
		}
		return savePath;
		
	}
	
	
	void FileDialog::OpenFiles (std::vector<const char*>* files, const char* filter, const char* defaultPath) {
		
		
	}
	
	
	const char* FileDialog::SaveFile (const char* filter, const char* defaultPath) {
		
		char const * savePath = tinyfd_saveFileDialog("", defaultPath, 0, NULL, NULL);
		if(savePath == NULL)
		{
			return 0;
		}
		return savePath;
		
	}
	
	
}