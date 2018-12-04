package lime.media.effects;

import lime.media.*;
import lime.media.openal.*;

@:access(lime.media.AudioSource)
@:access(lime._internal.backend.native.NativeAudioSource2)
class EchoEffect extends Effect {
	@getset("AL.ECHO_DELAY") public var delay(get, set):Float;
	@getset("AL.ECHO_LRDELAY") public var lrdelay(get, set):Float;
	@getset("AL.ECHO_DAMPING") public var damping(get, set):Float;
	@getset("AL.ECHO_FEEDBACK") public var feedback(get, set):Float;
	@getset("AL.ECHO_SPREAD") public var spread(get, set):Float;

	public function new() {
		super();
	}

	override function createEffect() {
		super.createEffect();
		AL.effecti(effectHandle, AL.EFFECT_TYPE, AL.EFFECT_ECHO);
	}
}