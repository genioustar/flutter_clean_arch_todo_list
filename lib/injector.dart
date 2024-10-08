import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injector.config.dart';

final locator = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() => locator.init();
