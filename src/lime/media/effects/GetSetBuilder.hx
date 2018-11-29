package lime.media.effects;

import haxe.macro.Context;
import haxe.macro.Expr;

class GetSetBuilder {
	macro public static function build(getter:String, setter:String, handle:String):Array<Field> {
		var fields = Context.getBuildFields();

		var getsets = fields.filter(function(field) return field.meta.filter(function(e) return e.name == "getset").length > 0);

    inline function getMetaParam(field:Field):String {
			var m = field.meta.filter(function(e) return e.name == "getset")[0];
      var v = switch(m.params[0].expr) {
        case EConst(CString(val)): val;
        case _: "";
      }

      return v;
    }

		function makeget(field:Field):Field {

      var param = getMetaParam(field);

      var call_str = "{ return AL."+getter+"("+handle+", "+param+"); }";
      var call =  Context.parse(call_str, Context.currentPos());

			var func:Function = {
        expr: call,
				ret: (macro:Float),
				args: [],
			}

			var newField = {
				name: 'get_${field.name}',
				access: [Access.APrivate, Access.AInline],
				pos: Context.currentPos(),
				kind: FieldType.FFun(func),
			}

			return newField;
		}

		function makeset(field:Field):Field {
      var param = getMetaParam(field);

      var call_str = "{ AL."+setter+"("+handle+", "+param+", value); return value; }";
      var call =  Context.parse(call_str, Context.currentPos());

			var func:Function = {
        expr: call,
				ret: (macro:Float),
        args: [{name:'value', type:(macro:Float)}],
			}

			var newField = {
				name: 'set_${field.name}',
				access: [Access.APrivate, Access.AInline],
				pos: Context.currentPos(),
				kind: FieldType.FFun(func),
			}

			return newField;
		}

		for(getset in getsets) {
			fields.push(makeget(getset));
			fields.push(makeset(getset));
		}

		return fields;
	}
}