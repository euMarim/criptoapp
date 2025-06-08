import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cryptoapp/data/models/cryptocurrency_model.dart';
import 'package:cryptoapp/presentation/shared/constants/app_constants.dart';

class CoinMarketCapApiService {
  final String _baseUrl = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency';
  final String _toolsUrl = 'https://pro-api.coinmarketcap.com/v1/tools';
  final String _apiKey = AppConstants.coinMarketCapApiKey;

  Future<List<CryptocurrencyModel>> getLatestCryptocurrencies({
    int start = 1,
    int limit = 100,
    String convert = 'USD',
  }) async {
    final uri = Uri.parse('$_baseUrl/listings/latest?start=$start&limit=$limit&convert=$convert');
    final response = await http.get(
      uri,
      headers: {
        'X-CMC_PRO_API_KEY': _apiKey,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> cryptoListJson = data['data'];
      return cryptoListJson.map((json) => CryptocurrencyModel.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar criptomoedas: ${response.statusCode} - ${response.body}');
    }
  }

  Future<double> getUsdToBrlExchangeRate() async {
    final uri = Uri.parse('$_toolsUrl/price-conversion?amount=1&symbol=USD&convert=BRL');
    final response = await http.get(
      uri,
      headers: {
        'X-CMC_PRO_API_KEY': _apiKey,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final Map<String, dynamic>? quote = data['data']['quote']['BRL'];
      if (quote != null && quote['price'] != null) {
        return quote['price'].toDouble();
      } else {
        throw Exception('Dados de taxa de câmbio USD/BRL não encontrados na resposta.');
      }
    } else {
      throw Exception('Falha ao obter taxa de câmbio USD/BRL: ${response.statusCode} - ${response.body}');
    }
  }
}