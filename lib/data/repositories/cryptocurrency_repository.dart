import 'package:cryptoapp/data/datasources/remote/coin_market_cap_api_service.dart';
import 'package:cryptoapp/domain/entities/cryptocurrency_entity.dart';
import 'package:cryptoapp/domain/repositories/i_cryptocurrency_repository.dart';

class CryptocurrencyRepository implements ICryptocurrencyRepository {
  final CoinMarketCapApiService apiService;

  CryptocurrencyRepository(this.apiService);

  @override
  Future<List<CryptocurrencyEntity>> getCryptocurrencies() async {
    try {
      final models = await apiService.getLatestCryptocurrencies(convert: 'USD');
      final double usdToBrlRate = await apiService.getUsdToBrlExchangeRate();

      return models.map((model) {
        final Map<String, QuoteEntity> entityQuotes = {};

        if (model.quotes.containsKey('USD')) {
          final usdQuote = model.quotes['USD']!;
          entityQuotes['USD'] = QuoteEntity(
            price: usdQuote.price,
            marketCap: usdQuote.marketCap,
            percentChange24h: usdQuote.percentChange24h,
          );

          entityQuotes['BRL'] = QuoteEntity(
            price: usdQuote.price * usdToBrlRate,
            marketCap: usdQuote.marketCap * usdToBrlRate,
            percentChange24h: usdQuote.percentChange24h,
          );
        } else {
          entityQuotes['USD'] = const QuoteEntity(price: 0.0, marketCap: 0.0, percentChange24h: 0.0);
          entityQuotes['BRL'] = const QuoteEntity(price: 0.0, marketCap: 0.0, percentChange24h: 0.0);
        }

        return CryptocurrencyEntity(
          id: model.id,
          name: model.name,
          symbol: model.symbol,
          slug: model.slug,
          dateAdded: model.dateAdded,
          quotes: entityQuotes,
        );
      }).toList();
    } catch (e) {
      throw Exception('Falha ao obter criptomoedas e taxas de câmbio do repositório: $e');
    }
  }
}