package lime.media.effects;

import lime.media.*;
import lime.media.openal.*;

@:access(lime.media.AudioSource)
@:access(lime._internal.backend.native.NativeAudioSource2)
class EqualizerEffect extends Effect {
	@getset("AL.EQUALIZER_LOW_GAIN") public var low_gain(get, set):Float;
	@getset("AL.EQUALIZER_LOW_CUTOFF") public var low_cutoff(get, set):Float;
	@getset("AL.EQUALIZER_MID1_GAIN") public var mid1_gain(get, set):Float;
	@getset("AL.EQUALIZER_MID1_CENTER") public var mid1_center(get, set):Float;
	@getset("AL.EQUALIZER_MID1_WIDTH") public var mid1_width(get, set):Float;
	@getset("AL.EQUALIZER_MID2_GAIN") public var mid2_gain(get, set):Float;
	@getset("AL.EQUALIZER_MID2_CENTER") public var mid2_center(get, set):Float;
	@getset("AL.EQUALIZER_MID2_WIDTH") public var mid2_width(get, set):Float;
	@getset("AL.EQUALIZER_HIGH_GAIN") public var high_gain(get, set):Float;
	@getset("AL.EQUALIZER_HIGH_CUTOFF") public var high_cutoff(get, set):Float;

	public function new() {
		super();
	}

	override function createEffect() {
		super.createEffect();
		AL.effecti(effectHandle, AL.EFFECT_TYPE, AL.EFFECT_EQUALIZER);
	}
}