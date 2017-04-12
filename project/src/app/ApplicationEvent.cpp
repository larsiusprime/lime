#include <lime_field_ids.h>
#include <hx/CFFI.h>
#include <app/ApplicationEvent.h>


using namespace lime::field_ids;


namespace lime {
	
	
	AutoGCRoot* ApplicationEvent::callback = 0;
	AutoGCRoot* ApplicationEvent::eventObject = 0;
	
	
	ApplicationEvent::ApplicationEvent () {
		
		deltaTime = 0;
		type = UPDATE;
		
	}
	
	
	void ApplicationEvent::Dispatch (ApplicationEvent* event) {
		
		if (ApplicationEvent::callback) {
			
			value object = (ApplicationEvent::eventObject ? ApplicationEvent::eventObject->get () : alloc_empty_object ());
			
			alloc_field (object, id_deltaTime, alloc_int (event->deltaTime));
			alloc_field (object, id_type, alloc_int (event->type));
			
			val_call0 (ApplicationEvent::callback->get ());
			
		}
		
	}
	
	
}
