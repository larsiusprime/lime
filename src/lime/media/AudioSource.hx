package lime.media;


import lime.app.Event;
import lime.media.openal.AL;
import lime.media.openal.ALSource;
import lime.media.effects.*;
import lime.math.Vector4;

#if !lime_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end


class AudioSource {

	static var ID = 0;

	public var onComplete = new Event<Void->Void> ();

	public var id:Int = ID++;
	public var buffer:AudioBuffer;
	public var currentTime (get, set):Int;
	public var gain (get, set):Float;
	public var pitch (get, set):Float;
	public var length (get, set):Int;
	public var loops (get, set):Int;
	public var offset:Int;
	public var position (get, set):Vector4;

	@:noCompletion private var __backend:AudioSourceBackend;

	private var effect:Effect;
	private var filter:Filter;


	public function new (buffer:AudioBuffer = null, offset:Int = 0, length:Null<Int> = null, loops:Int = 0) {

		this.buffer = buffer;
		this.offset = offset;

		__backend = new AudioSourceBackend (this);

		if (length != null && length != 0) {

			this.length = length;

		}

		this.loops = loops;

		if (buffer != null) {

			init ();

		}

	}


	public function dispose ():Void {

		if(filter != null) {
			filter.removeSource(this);
		}
		if(effect != null) {
			effect.removeSource(this);
		}
		
		filter = null;
		effect = null;

		__backend.dispose ();
		AudioManager.removeAudioSource(this);

	}


	@:noCompletion private function init ():Void {

		__backend.init ();
		AudioManager.addAudioSource(this);


	}

	public function update() {
		__backend.update();
		if(filter != null) filter.update();
		if(effect != null) effect.update();
	}


	public function play ():Void {

		__backend.play ();

	}


	public function pause ():Void {

		__backend.pause ();

	}


	public function stop ():Void {

		__backend.stop ();

	}

	#if (cpp || neko)

	// EFFECTS

	public function useEffect(effect:Effect) {
		if(this.effect != null) {
			this.effect.removeSource(this);
		}

		this.effect = effect;
		this.effect.addSource(this);
	}

	public function getEffect():Effect {
		return effect;
	}

	public function removeEffect() {
		if(effect != null) {
			effect.removeSource(this);
		}

		effect = null;
	}

	public function useFilter(filter:Filter) {
		if(this.filter != null) {
			this.filter.removeSource(this);
		}

		this.filter = filter;
		this.filter.addSource(this);
	}

	public function getFilter():Filter {
		return filter;
	}

	public function removeFilter() {
		if(filter != null) {
			filter.removeSource(this);
		}

		filter = null;
	}

	#end

	// Get & Set Methods




	@:noCompletion private function get_currentTime ():Int {

		return __backend.getCurrentTime ();

	}


	@:noCompletion private function set_currentTime (value:Int):Int {

		return __backend.setCurrentTime (value);

	}


	@:noCompletion private function get_gain ():Float {

		return __backend.getGain ();

	}


	@:noCompletion private function set_gain (value:Float):Float {

		return __backend.setGain (value);

	}


	@:noCompletion private function get_length ():Int {

		return __backend.getLength ();

	}


	@:noCompletion private function set_length (value:Int):Int {

		return __backend.setLength (value);

	}


	@:noCompletion private function get_loops ():Int {

		return __backend.getLoops ();

	}


	@:noCompletion private function set_loops (value:Int):Int {

		return __backend.setLoops (value);

	}


	@:noCompletion private function get_position ():Vector4 {

		return __backend.getPosition ();

	}


	@:noCompletion private function set_position (value:Vector4):Vector4 {

		return __backend.setPosition (value);

	}


	#if (cpp || neko)

	@:noCompletion private function get_pitch():Float {

		return __backend.getPitch();

	}

	@:noCompletion private function set_pitch(value:Float):Float {

		return __backend.setPitch(value);

	}

	#else

	@:noCompletion private function get_pitch():Float {

		return 1.0;

	}

	@:noCompletion private function set_pitch(value:Float):Float {

		return value;

	}

	#end


}


#if flash
@:noCompletion private typedef AudioSourceBackend = lime._internal.backend.flash.FlashAudioSource;
#elseif (js && html5)
@:noCompletion private typedef AudioSourceBackend = lime._internal.backend.html5.HTML5AudioSource;
#else
@:noCompletion private typedef AudioSourceBackend = lime._internal.backend.native.NativeAudioSource2;
#end