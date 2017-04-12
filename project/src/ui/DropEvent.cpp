#include <lime_field_ids.h>
#include <hx/CFFI.h>
#include <ui/DropEvent.h>


using namespace lime::field_ids;


namespace lime {
	
	
	AutoGCRoot* DropEvent::callback = 0;
	AutoGCRoot* DropEvent::eventObject = 0;
	
	
	DropEvent::DropEvent () {
		
		file = 0;
		type = DROP_FILE;
		
	}
	
	
	void DropEvent::Dispatch (DropEvent* event) {
		
		if (DropEvent::callback) {
			
			value object = (DropEvent::eventObject ? DropEvent::eventObject->get () : alloc_empty_object ());
			
			alloc_field (object, id_file, alloc_string (event->file));
			alloc_field (object, id_type, alloc_int (event->type));
			
			val_call0 (DropEvent::callback->get ());
			
		}
		
	}
	
	
}
