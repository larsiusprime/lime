package lime.media.effects;

import lime.media.*;
import lime.media.openal.*;

@:access(lime.media.AudioSource)
@:access(lime._internal.backend.native.NativeAudioSource2)
class FrequencyShifterEffect extends Effect {
	@getset("AL.FREQUENCY_SHIFTER_FREQUENCY") public var frequency(get, set):Float;
	@getset("AL.FREQUENCY_SHIFTER_LEFT_DIRECTION") public var left_direction(get, set):Float;
	@getset("AL.FREQUENCY_SHIFTER_RIGHT_DIRECTION") public var right_direction(get, set):Float;

	public function new() {
		super();
	}

	override function createEffect() {
		super.createEffect();
		AL.effecti(effectHandle, AL.EFFECT_TYPE, AL.EFFECT_FREQUENCY_SHIFTER);
	}
}