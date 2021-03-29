import 'dart:io';
import 'package:test/test.dart';
import "package:path/path.dart" show dirname, join, normalize;

import '../../../lib/location.dart';
import '../../../lib/tokenize.dart';
import '../../types_helper.dart';
import '../../test_helper.dart';
import '../../../lib/error.dart';
import '../../../lib/parse.dart';

final ObjectNode Function(List<PropertyNode>, [Location]) object = createObject;
final ValueNode Function(String, String, [Location]) id = createIdentifier;
final PropertyNode Function(ValueNode, Node, [Location]) prop = createProperty;
final ArrayNode Function(List<Node>, [Location]) array = createArray;
final LiteralNode Function(dynamic, String, [Location]) literal = createLiteral;

final _n = array([literal('n', '"n"')]);
final _m = array([literal('m', '"m"'), _n]);
final _l = array([literal('l', '"l"'), _m]);
final _k = array([literal('k', '"k"'), _l]);
final _j = array([literal('j', '"j"'), _k]);
final _i = array([literal('i', '"i"'), _j]);
final _h = array([literal('h', '"h"'), _i]);
final _g = object([prop(id('g', '"g"'), _h)]);
final _f = object([prop(id('f', '"f"'), _g)]);
final _e = object([prop(id('e', '"e"'), _f)]);
final _d = object([prop(id('d', '"d"'), _e)]);
final _c = object([prop(id('c', '"c"'), _d)]);
final _b = object([prop(id('b', '"b"'), _c)]);
final _a = object([prop(id('a', '"a"'), _b)]);

final ast = new TestAST(_a, new Settings());

void main() {
  final currentDirectory = dirname(testScriptPath());
  group("deep json", () {
    test("should parse a deep json correctly", () {
      final jsonFilePath = normalize(join(currentDirectory, 'deep.json'));
      final rawJSON = new File(jsonFilePath).readAsStringSync();
      final parsedAST = parse(rawJSON, Settings());
      assertNode(ast.ast, parsedAST, assertLocation: false, assertIndex: false);
    });
  });
}
