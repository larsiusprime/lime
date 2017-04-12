#include <lime_field_ids.h>
#include <graphics/ImageBuffer.h>


using namespace lime::field_ids;


namespace lime {
	
	
	ImageBuffer::ImageBuffer () {
		
		width = 0;
		height = 0;
		bitsPerPixel = 32;
		format = RGBA32;
		data = 0;
		premultiplied = false;
		transparent = false;
		
	}
	
	
	ImageBuffer::ImageBuffer (value imageBuffer) {
		
		width = val_int (val_field (imageBuffer, id_width));
		height = val_int (val_field (imageBuffer, id_height));
		bitsPerPixel = val_int (val_field (imageBuffer, id_bitsPerPixel));
		format = (PixelFormat)val_int (val_field (imageBuffer, id_format));
		transparent = val_bool (val_field (imageBuffer, id_transparent));
		value data_value = val_field (imageBuffer, id_data);
		value buffer_value = val_field (data_value, id_buffer);
		premultiplied = val_bool (val_field (imageBuffer, id_premultiplied));
		data = new Bytes (buffer_value);
		
	}
	
	
	ImageBuffer::~ImageBuffer () {
		
		delete data;
		
	}
	
	
	void ImageBuffer::Blit (const unsigned char *data, int x, int y, int width, int height) {
		
		if (x < 0 || x + width > this->width || y < 0 || y + height > this->height) {
			
			return;
			
		}
		
		int stride = Stride ();
		unsigned char *bytes = this->data->Data ();
		
		for (int i = 0; i < height; i++) {
			
			memcpy (&bytes[(i + y) * this->width + x], &data[i * width], stride);
			
		}
		
	}
	
	
	void ImageBuffer::BlitRow (const unsigned char *data, int sourcePosition, int destPosition, int sourceW) {
		
		int stride = (sourceW * (((bitsPerPixel + 3) & ~0x3) >> 3));
		
		unsigned char *bytes = this->data->Data ();
		
		memcpy (&bytes[destPosition], &data[sourcePosition], stride);
		
	}
	
	
	
	void ImageBuffer::Resize (int width, int height, int bitsPerPixel) {
		
		this->bitsPerPixel = bitsPerPixel;
		this->width = width;
		this->height = height;
		
		int stride = Stride ();
		
		if (!this->data) {
			
			this->data = new Bytes (height * stride);
			
		} else {
			
			this->data->Resize (height * stride);
			
		}
		
	}
	
	
	int ImageBuffer::Stride () {
		
		return width * (((bitsPerPixel + 3) & ~0x3) >> 3);
		
	}
	
	
	value ImageBuffer::Value () {
		
		mValue = alloc_empty_object ();
		alloc_field (mValue, id_width, alloc_int (width));
		alloc_field (mValue, id_height, alloc_int (height));
		alloc_field (mValue, id_bitsPerPixel, alloc_int (bitsPerPixel));
		alloc_field (mValue, id_data, data ? data->Value () : alloc_null ());
		alloc_field (mValue, id_transparent, alloc_bool (transparent));
		alloc_field (mValue, id_format, alloc_int (format));
		alloc_field (mValue, id_premultiplied, alloc_bool (premultiplied));
		return mValue;
		
	}
	
	
}
