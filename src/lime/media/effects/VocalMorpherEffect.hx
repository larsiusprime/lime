package lime.media.effects;

import lime.media.*;
import lime.media.openal.*;

@:access(lime.media.AudioSource)
@:access(lime._internal.backend.native.NativeAudioSource2)
class VocalMorpherEffect extends Effect {
	@getset("AL.VOCAL_MORPHER_PHONEMEA") public var phonemea(get, set):Float;
	@getset("AL.VOCAL_MORPHER_PHONEMEB") public var phonemeb(get, set):Float;
	@getset("AL.VOCAL_MORPHER_PHONEMEA_COARSE_TUNING") public var phonemea_coarse_tuning(get, set):Float;
	@getset("AL.VOCAL_MORPHER_PHONEMEB_COARSE_TUNING") public var phonemeb_coarse_tuning(get, set):Float;
	@getset("AL.VOCAL_MORPHER_RATE") public var rate(get, set):Float;

	public function new() {
		super();
	}

	override function createEffect() {
		super.createEffect();
		AL.effecti(effectHandle, AL.EFFECT_TYPE, AL.EFFECT_VOCAL_MORPHER);
	}

	public inline function useSinWaveform() {
		AL.effecti(effectHandle, AL.VOCAL_MORPHER_WAVEFORM, 0);
	}

	public inline function useTriangleWaveform() {
		AL.effecti(effectHandle, AL.VOCAL_MORPHER_WAVEFORM, 1);
	}

	public inline function useSawWaveform() {
		AL.effecti(effectHandle, AL.VOCAL_MORPHER_WAVEFORM, 2);
	}
}