#include <lime_field_ids.h>
#include <hx/CFFI.h>
#include <ui/MouseEvent.h>


using namespace lime::field_ids;


namespace lime {
	
	
	AutoGCRoot* MouseEvent::callback = 0;
	AutoGCRoot* MouseEvent::eventObject = 0;
	
	
	MouseEvent::MouseEvent () {
		
		button = 0;
		type = MOUSE_DOWN;
		windowID = 0;
		x = 0.0;
		y = 0.0;
		movementX = 0.0;
		movementY = 0.0;
		
	}
	
	
	void MouseEvent::Dispatch (MouseEvent* event) {
		
		if (MouseEvent::callback) {
			
			value object = (MouseEvent::eventObject ? MouseEvent::eventObject->get () : alloc_empty_object ());
			
			if (event->type != MOUSE_WHEEL) {
				
				alloc_field (object, id_button, alloc_int (event->button));
				
			}
			
			alloc_field (object, id_movementX, alloc_float (event->movementX));
			alloc_field (object, id_movementY, alloc_float (event->movementY));
			alloc_field (object, id_type, alloc_int (event->type));
			alloc_field (object, id_windowID, alloc_int (event->windowID));
			alloc_field (object, id_x, alloc_float (event->x));
			alloc_field (object, id_y, alloc_float (event->y));
			
			val_call0 (MouseEvent::callback->get ());
			
		}
		
	}
	
	
}
