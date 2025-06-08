import 'package:cryptoapp/domain/entities/cryptocurrency_entity.dart';

abstract class ICryptocurrencyRepository {
  Future<List<CryptocurrencyEntity>> getCryptocurrencies(); 
}