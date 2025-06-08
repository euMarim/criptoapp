import 'package:flutter/material.dart';
import 'package:cryptoapp/domain/entities/cryptocurrency_entity.dart';
import 'package:intl/intl.dart';
import 'package:cryptoapp/presentation/home/viewmodel/home_viewmodel.dart';
import 'package:cryptoapp/presentation/home/widgets/crypto_details_bottom_sheet.dart';

class CryptocurrencyListItem extends StatelessWidget {
  final CryptocurrencyEntity crypto;
  final CurrencyDisplay currency;

  const CryptocurrencyListItem({
    Key? key,
    required this.crypto,
    required this.currency,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String currencySymbol;
    String locale;
    QuoteEntity? selectedQuote;

    if (currency == CurrencyDisplay.usd) {
      currencySymbol = '\$';
      locale = 'en_US';
      selectedQuote = crypto.quotes['USD'];
    } else {
      currencySymbol = 'R\$';
      locale = 'pt_BR';
      selectedQuote = crypto.quotes['BRL'];
    }

    selectedQuote ??= const QuoteEntity(price: 0.0, marketCap: 0.0, percentChange24h: 0.0);

    final NumberFormat currencyFormatter = NumberFormat.currency(locale: locale, symbol: currencySymbol);
    final NumberFormat percentFormatter = NumberFormat.decimalPercentPattern(decimalDigits: 2);

    Color percentChangeColor = Colors.grey;
    if (selectedQuote.percentChange24h > 0) {
      percentChangeColor = Colors.green;
    } else if (selectedQuote.percentChange24h < 0) {
      percentChangeColor = Colors.red;
    }

    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return CryptoDetailsBottomSheet(crypto: crypto);
          },
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      crypto.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      crypto.symbol,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    currencyFormatter.format(selectedQuote.price),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    percentFormatter.format(selectedQuote.percentChange24h / 100),
                    style: TextStyle(
                      color: percentChangeColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}