#include <lime_field_ids.h>
#include <graphics/Image.h>


using namespace lime::field_ids;


namespace lime {
	
	
	Image::Image () {
		
		buffer = 0;
		height = 0;
		offsetX = 0;
		offsetY = 0;
		width = 0;
		
	}
	
	
	Image::Image (value image) {
		
		width = val_int (val_field (image, id_width));
		height = val_int (val_field (image, id_height));
		buffer = new ImageBuffer (val_field (image, id_buffer));
		offsetX = val_int (val_field (image, id_offsetX));
		offsetY = val_int (val_field (image, id_offsetY));
		
	}
	
	
	Image::~Image () {
		
		delete buffer;
		
	}
	
	
}
