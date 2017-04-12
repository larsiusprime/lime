#include <lime_field_ids.h>
#include <system/System.h>
#include <utils/Bytes.h>


using namespace lime::field_ids;


namespace lime {
	
	
	static bool useBuffer = false;
	
	
	void Bytes::StaticInit () {
		
		buffer b = alloc_buffer_len (1);
		
		if (buffer_data (b)) {
			
			useBuffer = true;
			
		}
			
	}
	
	
	Bytes::Bytes () {
		
		_data = 0;
		_length = 0;
		_value = 0;
		_root = 0;
		
	}
	
	
	Bytes::Bytes (int size) {
		
		_data = 0;
		_length = 0;
		_value = 0;
		_root = 0;
		
		Resize (size);
		
	}
	
	
	Bytes::Bytes (value bytes) {
		
		_data = 0;
		_length = 0;
		_value = 0;
		_root = 0;
		
		Set (bytes);
		
	}
	
	
	Bytes::Bytes (const char* path) {
		
		_data = 0;
		_length = 0;
		_value = 0;
		_root = 0;
		
		FILE_HANDLE *file = lime::fopen (path, "rb");
		
		if (!file) {
			
			return;
			
		}
		
		lime::fseek (file, 0, SEEK_END);
		int size = lime::ftell (file);
		lime::fseek (file, 0, SEEK_SET);
		
		if (size > 0) {
			
			Resize (size);
			int status = lime::fread (_data, _length, 1, file);
			
		}
		
		lime::fclose (file);
		
	}
	
	
	Bytes::Bytes (const QuickVec<unsigned char> data) {
		
		_data = 0;
		_length = 0;
		_value = 0;
		_root = 0;
		
		Set (data);
		
	}
	
	
	Bytes::~Bytes () {
		
		if (_root) {
			
			*_root = 0;
			free_root (_root);
			
		}
		
	}
	
	
	unsigned char *Bytes::Data () {
		
		return (unsigned char*)_data;
		
	}
	
	
	const unsigned char *Bytes::Data () const {
		
		return (const unsigned char*)_data;
		
	}
	
	
	int Bytes::Length () const {
		
		return _length;
		
	}
	
	
	void Bytes::Resize (int size) {
		
		if (size != _length) {
			
			if (!_value) {
				
				_value = alloc_empty_object ();
				_root = alloc_root ();
				*_root = _value;
				
			}
			
			if (val_is_null (val_field (_value, id_b))) {
				
				value dataValue;
				
				if (useBuffer) {
					
					buffer b = alloc_buffer_len (size);
					dataValue = buffer_val (b);
					_data = (unsigned char*)buffer_data (b);
					
				} else {
					
					dataValue = alloc_raw_string (size);
					_data = (unsigned char*)val_string (dataValue);
					
				}
				
				alloc_field (_value, id_b, dataValue);
				
			} else {
				
				if (useBuffer) {
					
					buffer b = val_to_buffer (val_field (_value, id_b));
					buffer_set_size (b, size);
					_data = (unsigned char*)buffer_data (b);
					
				} else {
					
					value s = alloc_raw_string (size);
					memcpy ((char *)val_string (s), val_string (val_field (_value, id_b)), _length);
					alloc_field (_value, id_b, s);
					_data = (unsigned char*)val_string (s);
					
				}
				
			}
			
			alloc_field (_value, id_length, alloc_int (size));
			
		}
		
		_length = size;
		
	}
	
	
	void Bytes::Set (value bytes) {
		
		if (val_is_null (bytes)) {
			
			_length = 0;
			_data = 0;
			_value = 0;
			
			if (_root) {
				
				*_root = 0;
				free_root (_root);
				
			}
			
			_root = 0;
			
		} else {
			
			_value = bytes;
			
			if (!_root) {
				
				_root = alloc_root ();
				
			}
			
			*_root = _value;
			_length = val_int (val_field (bytes, id_length));
			
			if (_length > 0) {
				
				value b = val_field (bytes, id_b);
				
				if (val_is_string (b)) {
					
					_data = (unsigned char*)val_string (b);
					
				} else {
					
					_data = (unsigned char*)buffer_data (val_to_buffer (b));
					
				}
				
			} else {
				
				_data = 0;
				
			}
			
		}
		
	}
	
	
	void Bytes::Set (const QuickVec<unsigned char> data) {
		
		int size = data.size ();
		
		if (size > 0) {
			
			Resize (size);
			memcpy (_data, &data[0], _length);
			
		} else {
			
			_data = 0;
			_length = 0;
			
			if (_root) {
				
				*_root = 0;
				free_root (_root);
				
			}
			
			_root = 0;
			
		}
		
	}
	
	
	value Bytes::Value () {
		
		if (_value) {
			
			return _value;
			
		} else {
			
			return alloc_null ();
			
		}
		
	}
	
	
}
