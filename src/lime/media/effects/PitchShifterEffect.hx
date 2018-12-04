package lime.media.effects;

import lime.media.*;
import lime.media.openal.*;

@:access(lime.media.AudioSource)
@:access(lime._internal.backend.native.NativeAudioSource2)
class PitchShifterEffecct extends Effect {
	@getset("AL.PITCH_SHIFTER_COARSE_TUNE") public var coarse_tune(get, set):Float;
	@getset("AL.PITCH_SHIFTER_FINE_TUNE") public var fine_tune(get, set):Float;

	public function new() {
		super();
	}

	override function createEffect() {
		super.createEffect();
		AL.effecti(effectHandle, AL.EFFECT_TYPE, AL.EFFECT_PITCH_SHIFTER);
	}
}