#include <hx/CFFI.h>
#include <graphics/RenderEvent.h>


namespace lime {
	
	
	AutoGCRoot* RenderEvent::callback = 0;
	AutoGCRoot* RenderEvent::eventObject = 0;
	
	
	RenderEvent::RenderEvent () {
		
		type = RENDER;
		
	}
	
	
	void RenderEvent::Dispatch (RenderEvent* event) {
		
		if (RenderEvent::callback) {
			
			value object = (RenderEvent::eventObject ? RenderEvent::eventObject->get () : alloc_empty_object ());
			
			val_call0 (RenderEvent::callback->get ());
			
		}
		
	}
	
	
}
