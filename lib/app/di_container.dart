import 'package:get_it/get_it.dart';
import 'package:cryptoapp/data/datasources/remote/coin_market_cap_api_service.dart';
import 'package:cryptoapp/data/repositories/cryptocurrency_repository.dart';
import 'package:cryptoapp/domain/repositories/i_cryptocurrency_repository.dart';
import 'package:cryptoapp/domain/usecases/get_cryptocurrencies_usecase.dart';
import 'package:cryptoapp/presentation/home/viewmodel/home_viewmodel.dart';

final sl = GetIt.instance;

void setupLocator() {

  if (sl.isRegistered<HomeViewModel>()) {
    return;
  }

  sl.registerFactory(() => HomeViewModel(sl()));

  sl.registerLazySingleton(() => GetCryptocurrenciesUseCase(sl()));

  sl.registerLazySingleton<ICryptocurrencyRepository>(
    () => CryptocurrencyRepository(sl()),
  );

  sl.registerLazySingleton(() => CoinMarketCapApiService());
}