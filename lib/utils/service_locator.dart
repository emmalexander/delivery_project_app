// import 'package:get_it/get_it.dart';
// import 'package:http/http.dart' as http;
// import 'package:http_interceptor/http_interceptor.dart';
// import 'package:intercity/features/authentication/data/repositories/auth_repository.dart';
// import 'package:intercity/features/dashboard/data/repositories/ticket_repository.dart';
// import 'package:intercity/features/storage/local/user_data_storage_repository.dart';
//
// GetIt locator = GetIt.instance;
//
// void setupLocator() {
//   /// SERVICES
//   locator.registerLazySingleton<AuthRepository>(
//     () => AuthRepository(
//       client: http.Client(),
//     ),
//   );
//
//   locator.registerLazySingleton<UserDataStorageRepository>(
//     () => UserDataStorageRepository(),
//   );
//
//   locator.registerLazySingleton<TicketRepository>(
//         () => TicketRepository(
//           client: http.Client(),
//         ),
//   );
//
//   // locator.registerLazySingleton<HomeService>(
//   //   () => HomeService(
//   //     client: http.Client(),
//   //   ),
//   // );
//
//   // locator.registerLazySingleton<StorageRepository>(
//   //   () => StorageRepository(),
//   // );
// }
