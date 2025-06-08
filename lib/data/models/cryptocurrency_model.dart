import 'package:equatable/equatable.dart';

class CryptocurrencyModel extends Equatable {
  final int id;
  final String name;
  final String symbol;
  final String slug;
  final DateTime? dateAdded;
  final Map<String, QuoteModel> quotes;

  const CryptocurrencyModel({
    required this.id,
    required this.name,
    required this.symbol,
    required this.slug,
    this.dateAdded, 
    required this.quotes,
  });

  factory CryptocurrencyModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic>? quoteJson = json['quote'];
    final Map<String, QuoteModel> parsedQuotes = {};

    if (quoteJson != null) {
      quoteJson.forEach((currency, quoteData) {
        parsedQuotes[currency] = QuoteModel.fromJson(quoteData);
      });
    }

    DateTime? parsedDateAdded;
    if (json['date_added'] != null) {
      try {
        parsedDateAdded = DateTime.parse(json['date_added']);
      } catch (e) {
        print('Erro ao parsear date_added: ${json['date_added']} - $e');
      }
    }

    return CryptocurrencyModel(
      id: json['id'],
      name: json['name'],
      symbol: json['symbol'],
      slug: json['slug'],
      dateAdded: parsedDateAdded,
      quotes: parsedQuotes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'symbol': symbol,
      'slug': slug,
      'date_added': dateAdded?.toIso8601String(),
      'quote': quotes.map((key, value) => MapEntry(key, value.toJson())),
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        symbol,
        slug,
        dateAdded,
        quotes,
      ];
}

class QuoteModel extends Equatable {
  final double price;
  final double marketCap;
  final double percentChange24h;

  const QuoteModel({
    required this.price,
    required this.marketCap,
    required this.percentChange24h,
  });

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      price: json['price']?.toDouble() ?? 0.0,
      marketCap: json['market_cap']?.toDouble() ?? 0.0,
      percentChange24h: json['percent_change_24h']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'price': price,
      'market_cap': marketCap,
      'percent_change_24h': percentChange24h,
    };
  }

  @override
  List<Object?> get props => [price, marketCap, percentChange24h];
}