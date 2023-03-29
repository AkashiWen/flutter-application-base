import 'startup.dart';

abstract class FlutterStartup extends Startup {

  @override
  int get priority => 1;

  @override
  bool get callCreateOnMainThread => true;

}
