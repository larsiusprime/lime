package lime.media.effects;

import lime.media.*;
import lime.media.openal.*;

@:access(lime.media.AudioSource)
@:access(lime._internal.backend.native.NativeAudioSource2)
class CompressorEffect extends Effect {
	public var on(get, set):Bool;

	public function new() {
		super();
	}

	override function createEffect() {
		super.createEffect();
		AL.effecti(effectHandle, AL.EFFECT_TYPE, AL.EFFECT_COMPRESSOR);
	}

	inline function get_on() {
		return AL.getEffecti(effectHandle, AL.COMPRESSOR_ONOFF) == 1;
	}

	inline function set_on(value:Bool) {
		AL.effecti(effectHandle, AL.COMPRESSOR_ONOFF, value ? 1 : 0);
		return value;
	}
}