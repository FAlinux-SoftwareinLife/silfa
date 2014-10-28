package utils {

	public class URLStringParser {

		private static var urlStringParser:URLStringParser;

		private const QUERY_MARK:String = "&";
		private const SCOPE_MARK:String = "+";
		private const EQUAL_MARK:String = "=";

		public function URLStringParser(blockURLStringParser:BlockURLStringParser) {


		}

		public function getQueryObj(queryStr:String):Object {

			var _queryObj:Object = {};

			var _queryList:Vector.<String> = Vector.<String>(queryStr.split(QUERY_MARK));

			for each (var _element:String in _queryList) {

				var _section:int = _element.indexOf(EQUAL_MARK);
				var _name:String = _element.substring(0, _section);
				var _value:String = _element.substr(_section + 1);

				_queryObj[_name] = _value;

			}

			return _queryObj;

		}

		public function getScopeList(scopeStr:String):Vector.<String> {

			var _scopeList:Vector.<String>;

			try {
				_scopeList = Vector.<String>(scopeStr.split(SCOPE_MARK));
			} catch (error:Error) {
				_scopeList = Vector.<String>([]);
			}

			return _scopeList;

		}

		public static function get urlStringParserObj():URLStringParser {

			if (urlStringParser == null)
				urlStringParser = new URLStringParser(new BlockURLStringParser());

			return urlStringParser;

		}

	}
}

/**
 *'URLStringParser' is not possible to create an instance.
 *
 */
class BlockURLStringParser {
}
