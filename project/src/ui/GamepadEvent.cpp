#include <lime_field_ids.h>
#include <hx/CFFI.h>
#include <ui/GamepadEvent.h>


using namespace lime::field_ids;


namespace lime {
	
	
	AutoGCRoot* GamepadEvent::callback = 0;
	AutoGCRoot* GamepadEvent::eventObject = 0;
	
	GamepadEvent::GamepadEvent () {
		
		axis = 0;
		axisValue = 0;
		button = 0;
		id = 0;
		type = GAMEPAD_AXIS_MOVE;
		
	}
	
	
	void GamepadEvent::Dispatch (GamepadEvent* event) {
		
		if (GamepadEvent::callback) {
			
			value object = (GamepadEvent::eventObject ? GamepadEvent::eventObject->get () : alloc_empty_object ());
			
			alloc_field (object, id_axis, alloc_int (event->axis));
			alloc_field (object, id_button, alloc_int (event->button));
			alloc_field (object, id_id, alloc_int (event->id));
			alloc_field (object, id_type, alloc_int (event->type));
			alloc_field (object, id_value, alloc_float (event->axisValue));
			
			val_call0 (GamepadEvent::callback->get ());
			
		}
		
	}
	
	
}
