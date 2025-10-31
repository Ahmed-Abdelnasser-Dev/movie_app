import 'package:get_it/get_it.dart';
import '../network/dio_factory.dart';
import '../network/api_service.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Dio & ApiService
  final dio = DioFactory.getDio();
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));
}
