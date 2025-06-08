import 'package:cryptoapp/domain/entities/cryptocurrency_entity.dart';
import 'package:cryptoapp/domain/repositories/i_cryptocurrency_repository.dart';

class GetCryptocurrenciesUseCase {
  final ICryptocurrencyRepository repository;

  GetCryptocurrenciesUseCase(this.repository);

  Future<List<CryptocurrencyEntity>> call() async {
    return await repository.getCryptocurrencies();
  }
}