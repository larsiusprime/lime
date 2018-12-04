package lime.media.effects;

import lime.media.*;
import lime.media.openal.*;

@:access(lime.media.AudioSource)
@:access(lime._internal.backend.native.NativeAudioSource2)
class RingModulatorEffect extends Effect {
	@getset("AL.RING_MODULATOR_FREQUENCY") public var frequency(get, set):Float;
	@getset("AL.RING_MODULATOR_HIGHPASS_CUTOFF") public var highpass_cutoff(get, set):Float;

	public function new() {
		super();
	}

	override function createEffect() {
		super.createEffect();
		AL.effecti(effectHandle, AL.EFFECT_TYPE, AL.EFFECT_RING_MODULATOR);
	}

	public inline function useSinWaveform() {
		AL.effecti(effectHandle, AL.RING_MODULATOR_WAVEFORM, 0);
	}

	public inline function useTriangleWaveform() {
		AL.effecti(effectHandle, AL.RING_MODULATOR_WAVEFORM, 1);
	}

	public inline function useSawWaveform() {
		AL.effecti(effectHandle, AL.RING_MODULATOR_WAVEFORM, 2);
	}
}