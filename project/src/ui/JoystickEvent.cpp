#include <lime_field_ids.h>
#include <hx/CFFI.h>
#include <ui/JoystickEvent.h>


using namespace lime::field_ids;


namespace lime {
	
	
	AutoGCRoot* JoystickEvent::callback = 0;
	AutoGCRoot* JoystickEvent::eventObject = 0;
	
	
	JoystickEvent::JoystickEvent () {
		
		id = 0;
		index = 0;
		eventValue = 0;
		x = 0;
		y = 0;
		type = JOYSTICK_AXIS_MOVE;
		
	}
	
	
	void JoystickEvent::Dispatch (JoystickEvent* event) {
		
		if (JoystickEvent::callback) {
			
			value object = (JoystickEvent::eventObject ? JoystickEvent::eventObject->get () : alloc_empty_object ());
			
			alloc_field (object, id_id, alloc_int (event->id));
			alloc_field (object, id_index, alloc_int (event->index));
			alloc_field (object, id_type, alloc_int (event->type));
			alloc_field (object, id_value, alloc_float (event->eventValue));
			alloc_field (object, id_x, alloc_int (event->x));
			alloc_field (object, id_y, alloc_int (event->y));
			
			val_call0 (JoystickEvent::callback->get ());
			
		}
		
	}
	
	
}
