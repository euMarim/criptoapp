import 'package:equatable/equatable.dart';

class CryptocurrencyEntity extends Equatable {
  final int id;
  final String name;
  final String symbol;
  final String slug;
  final DateTime? dateAdded;
  final Map<String, QuoteEntity> quotes;

  const CryptocurrencyEntity({
    required this.id,
    required this.name,
    required this.symbol,
    required this.slug,
    this.dateAdded,
    required this.quotes,
  });

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

class QuoteEntity extends Equatable {
  final double price;
  final double marketCap;
  final double percentChange24h;

  const QuoteEntity({
    required this.price,
    required this.marketCap,
    required this.percentChange24h,
  });

  @override
  List<Object?> get props => [price, marketCap, percentChange24h];
}