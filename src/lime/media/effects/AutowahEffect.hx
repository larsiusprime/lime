package lime.media.effects;

import lime.media.*;
import lime.media.openal.*;

@:access(lime.media.AudioSource)
@:access(lime._internal.backend.native.NativeAudioSource2)
class AutowahEffect extends Effect {
	@getset("AL.AUTOWAH_ATTACK_TIME") public var attack_time(get, set):Float;
	@getset("AL.AUTOWAH_RELEASE_TIME") public var release_time(get, set):Float;
	@getset("AL.AUTOWAH_RESONANCE") public var resonance(get, set):Float;
	@getset("AL.AUTOWAH_PEAK_GAIN") public var peak_gain(get, set):Float;

	public function new() {
		super();
	}

	override function createEffect() {
		super.createEffect();
		AL.effecti(effectHandle, AL.EFFECT_TYPE, AL.EFFECT_AUTOWAH);
	}
}