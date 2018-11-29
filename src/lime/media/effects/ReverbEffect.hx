package lime.media.effects;

import lime.media.*;
import lime.media.openal.*;

@:access(lime.media.AudioSource)
@:access(lime._internal.backend.native.NativeAudioSource2)
class ReverbEffect extends Effect {
	@getset("AL.REVERB_DENSITY") public var density(get, set):Float;
	@getset("AL.REVERB_DIFFUSION") public var diffusion(get, set):Float;
	@getset("AL.REVERB_GAIN") public var gain(get, set):Float;
	@getset("AL.REVERB_GAINHF") public var gainhf(get, set):Float;
	@getset("AL.REVERB_DECAY_TIME") public var decayTime(get, set):Float;
	@getset("AL.REVERB_DECAY_HFRATIO") public var decayHFRatio(get, set):Float;
	@getset("AL.REVERB_REFLECTIONS_GAIN") public var reflectionsGain(get, set):Float;
	@getset("AL.REVERB_REFLECTIONS_DELAY") public var reflectionsDelay(get, set):Float;
	@getset("AL.REVERB_LATE_REVERB_GAIN") public var lateReverbGain(get, set):Float;
	@getset("AL.REVERB_LATE_REVERB_DELAY") public var lateReverbDelay(get, set):Float;

	public function new() {
		super();
	}

	override function createEffect() {
		super.createEffect();
		AL.effecti(effectHandle, AL.EFFECT_TYPE, AL.EFFECT_REVERB);
	}

}
