import 'package:alice/alice.dart';
import 'package:dio/dio.dart' as dio_base;
import '/exporter.dart';

final _alice = kIsDeveloping && Platform.isAndroid ? Alice() : null;
final kAppNavigatorKey = _alice?.getNavigatorKey();
final dio = dio_base.Dio()
  ..interceptors.add(_alice?.getDioInterceptor() ?? dio_base.Interceptor());
