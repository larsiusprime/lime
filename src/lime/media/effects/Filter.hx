package lime.media.effects;

import lime.media.*;
import lime.media.openal.*;

@:access(lime.media.AudioSource)
@:access(lime._internal.backend.native.NativeAudioSource2)
#if !macro
@:autoBuild(lime.media.effects.GetSetBuilder.build('getFilterf', 'filterf', 'filterHandle'))
#end
class Filter {

	var sources:Array<AudioSource> = [];
	var auxHandle:ALAuxiliaryEffectSlot;
	var filterHandle:ALFilter;

	function new() {
		createFilter();
	}

	// Override this to create the filter
	function createFilter() {
		filterHandle = AL.createFilter();
	}

	inline function attachSource(source:AudioSource) {
		AL.sourcei(source.__backend.handle, AL.DIRECT_FILTER, filterHandle);
	}

	public function update() {

	}

	public function dispose() {
		for(source in sources) {
			removeSource(source);
		}
		sources.splice(0, sources.length);

		AL.deleteFilter(filterHandle);
	}

	public function addSource(source:AudioSource) {
		sources.push(source);
		attachSource(source);
	}

	public function removeSource(source:AudioSource) {
		sources.remove(source);
		AL.removeDirectFilter(source);
	}

}