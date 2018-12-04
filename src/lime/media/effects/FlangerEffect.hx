package lime.media.effects;

import lime.media.*;
import lime.media.openal.*;

@:access(lime.media.AudioSource)
@:access(lime._internal.backend.native.NativeAudioSource2)
class FlangerEffect extends Effect {
	@getset("AL.FLANGER_PHASE") public var phase(get, set):Float;
	@getset("AL.FLANGER_RATE") public var rate(get, set):Float;
	@getset("AL.FLANGER_DEPTH") public var depth(get, set):Float;
	@getset("AL.FLANGER_FEEDBACK") public var feedback(get, set):Float;
	@getset("AL.FLANGER_DELAY") public var delay(get, set):Float;

	public function new() {
		super();
	}

	override function createEffect() {
		super.createEffect();
		AL.effecti(effectHandle, AL.EFFECT_TYPE, AL.EFFECT_ECHO);
	}

	public inline function useSinWaveform() {
		AL.effecti(effectHandle, AL.CHORUS_WAVEFORM, 0);
	}

	public inline function useTriangleWaveform() {
		AL.effecti(effectHandle, AL.CHORUS_WAVEFORM, 1);
	}
}