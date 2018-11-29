package lime.media.effects;

import lime.media.*;
import lime.media.openal.*;

@:access(lime.media.AudioSource)
@:access(lime._internal.backend.native.NativeAudioSource2)
class LowPassFilter extends Filter {

	@getset("AL.LOWPASS_GAIN") public var gain(get, set):Float;
	@getset("AL.LOWPASS_GAINHF") public var gainhf(get, set):Float;

	public function new() {
		super();
	}

	override function createFilter() {
		super.createFilter();
		AL.filteri(filterHandle, AL.FILTER_TYPE, AL.FILTER_LOWPASS);
	}

}