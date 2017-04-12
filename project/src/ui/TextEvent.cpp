#include <lime_field_ids.h>
#include <hx/CFFI.h>
#include <ui/TextEvent.h>


using namespace lime::field_ids;


namespace lime {
	
	
	AutoGCRoot* TextEvent::callback = 0;
	AutoGCRoot* TextEvent::eventObject = 0;
	
	
	TextEvent::TextEvent () {
		
		length = 0;
		start = 0;
		windowID = 0;
		
	}
	
	
	void TextEvent::Dispatch (TextEvent* event) {
		
		if (TextEvent::callback) {
			
			value object = (TextEvent::eventObject ? TextEvent::eventObject->get () : alloc_empty_object ());
			
			if (event->type != TEXT_INPUT) {
				
				alloc_field (object, id_length, alloc_int (event->length));
				alloc_field (object, id_start, alloc_int (event->start));
				
			}
			
			alloc_field (object, id_text, alloc_string (event->text));
			alloc_field (object, id_type, alloc_int (event->type));
			alloc_field (object, id_windowID, alloc_int (event->windowID));
			
			val_call0 (TextEvent::callback->get ());
			
		}
		
	}
	
	
}
