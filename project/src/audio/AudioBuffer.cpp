#include <lime_field_ids.h>
#include <audio/AudioBuffer.h>


using namespace lime::field_ids;


namespace lime {
	
	
	AudioBuffer::AudioBuffer () {
		
		bitsPerSample = 0;
		channels = 0;
		data = new Bytes ();
		sampleRate = 0;
		
	}
	
	
	AudioBuffer::~AudioBuffer () {
		
		delete data;
		
	}
	
	
	value AudioBuffer::Value () {
		
		mValue = alloc_empty_object ();
		alloc_field (mValue, id_bitsPerSample, alloc_int (bitsPerSample));
		alloc_field (mValue, id_channels, alloc_int (channels));
		alloc_field (mValue, id_data, data ? data->Value () : alloc_null ());
		alloc_field (mValue, id_sampleRate, alloc_int (sampleRate));
		return mValue;
		
	}
	
	
}
