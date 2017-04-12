#include <lime_field_ids.h>
#include <math/Vector2.h>


using namespace lime::field_ids;


namespace lime {
	
	
	Vector2::Vector2 () {
		
		x = 0;
		y = 0;
		
	}
	
	
	Vector2::Vector2 (double x, double y) {
		
		this->x = x;
		this->y = y;
		
	}
	
	
	Vector2::Vector2 (value vec) {
		
		if (!val_is_null (vec)) {
			
			x = val_number (val_field (vec, id_x));
			y = val_number (val_field (vec, id_y));
			
		} else {
			
			x = 0;
			y = 0;
			
		}
		
	}
	
	
	value Vector2::Value () {
		
		value result = alloc_empty_object ();
		alloc_field (result, id_x, alloc_float (x));
		alloc_field (result, id_y, alloc_float (y));
		return result;
		
	}
	
	
}
