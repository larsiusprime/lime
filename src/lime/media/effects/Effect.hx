package lime.media.effects;

import lime.media.*;
import lime.media.openal.*;

@:access(lime.media.AudioSource)
@:access(lime._internal.backend.native.NativeAudioSource2)
#if !macro
@:autoBuild(lime.media.effects.GetSetBuilder.build('getEffectf', 'effectf', 'effectHandle'))
#end
class Effect {

	var sources:Array<AudioSource> = [];
	var auxHandle:ALAuxiliaryEffectSlot;
	var effectHandle:ALEffect;

	function new() {
		createAux();
		createEffect();
		attachEffectToAux();
	}

	function createAux() {
		auxHandle = AL.createAux();
	}


	// Override this to create the effect
	function createEffect() {
		effectHandle = AL.createEffect();
	}

	function attachEffectToAux() {
		AL.auxi(auxHandle, AL.EFFECTSLOT_EFFECT, effectHandle);
	}

	inline function attachSource(source:AudioSource) {
		AL.source3i(source.__backend.handle, AL.AUXILIARY_SEND_FILTER, auxHandle, 0, effectHandle);
	}

	public function update() {

	}

	public function dispose() {
		for(source in sources) {
			removeSource(source);
		}
		sources.splice(0, sources.length);
		AL.auxi(auxHandle, AL.EFFECTSLOT_EFFECT, null);

		AL.deleteEffect(effectHandle);
		AL.deleteAuxiliaryEffectSlot(auxHandle);

	}

	public function addSource(source:AudioSource) {
		sources.push(source);
		attachSource(source);
	}

	public function removeSource(source:AudioSource) {
		sources.remove(source);
		AL.removeSend(source.__backend.handle, 0);
	}

}