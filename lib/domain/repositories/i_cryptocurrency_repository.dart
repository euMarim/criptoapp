import 'package:cryptoapp/domain/entities/cryptocurrency_entity.dart';

abstract class ICryptocurrencyRepository {
  Future<List<CryptocurrencyEntity>> getCryptocurrencies();
  // Future<CryptocurrencyEntity> getCryptocurrencyDetails(int id); // Se houver tela de detalhes
}