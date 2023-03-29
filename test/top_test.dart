import 'package:common/common/top.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("get value via .value ext", () {
    num zero = 0;
    expect(0, zero.val);
    num? nullNum;
    expect(0, nullNum.val);

    bool? bol;
    expect(false, bol.val);
    bool? t = true;
    expect(true, t.val);
  });
}
