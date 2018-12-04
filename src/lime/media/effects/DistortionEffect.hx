package lime.media.effects;

import lime.media.*;
import lime.media.openal.*;

@:access(lime.media.AudioSource)
@:access(lime._internal.backend.native.NativeAudioSource2)
class DistortionEffect extends Effect {
	@getset("AL.DISTORTION_EDGE") public var edge(get, set):Float;
	@getset("AL.DISTORTION_GAIN") public var gain(get, set):Float;
	@getset("AL.DISTORTION_LOWPASS_CUTOFF") public var lowpass_cutoff(get, set):Float;
	@getset("AL.DISTORTION_EQCENTER") public var eqcenter(get, set):Float;
	@getset("AL.DISTORTION_EQBANDWIDTH") public var eqbandwidth(get, set):Float;

	public function new() {
		super();
	}

	override function createEffect() {
		super.createEffect();
		AL.effecti(effectHandle, AL.EFFECT_TYPE, AL.EFFECT_DISTORTION);
	}
}