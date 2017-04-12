#include <lime_field_ids.h>
#include <math/Rectangle.h>


using namespace lime::field_ids;


namespace lime {
	
	
	Rectangle::Rectangle () {
		
		height = 0;
		width = 0;
		x = 0;
		y = 0;
		
	}
	
	
	Rectangle::Rectangle (double x, double y, double width, double height) {
		
		this->height = height;
		this->width = width;
		this->x = x;
		this->y = y;
		
	}
	
	
	Rectangle::Rectangle (value rect) {
		
		width = val_number (val_field (rect, id_width));
		height = val_number (val_field (rect, id_height));
		x = val_number (val_field (rect, id_x));
		y = val_number (val_field (rect, id_y));
		
	}
	
	
	void Rectangle::Contract (double x, double y, double width, double height) {
		
		if (this->width == 0 && this->height == 0) {
			
			return;
			
		}
		
		//double cacheRight = this->x + this->width;
		//double cacheBottom = this->y + this->height;
		
		if (this->x < x) this->x = x;
		if (this->y < y) this->y = y;
		if (this->x + this->width > x + width) this->width = x + width - this->x;
		if (this->y + this->height > y + height) this->height = y + height - this->y;
		
	}
	
	
	value Rectangle::Value () {
		
		value rect = alloc_empty_object ();
		alloc_field (rect, id_height, alloc_float (height));
		alloc_field (rect, id_width, alloc_float (width));
		alloc_field (rect, id_x, alloc_float (x));
		alloc_field (rect, id_y, alloc_float (y));
		return rect;
		
	}
	
	
}
