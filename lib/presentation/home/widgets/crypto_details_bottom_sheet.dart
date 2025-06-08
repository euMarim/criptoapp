import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cryptoapp/domain/entities/cryptocurrency_entity.dart';

class CryptoDetailsBottomSheet extends StatelessWidget {
  final CryptocurrencyEntity crypto;

  const CryptoDetailsBottomSheet({Key? key, required this.crypto}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final NumberFormat currencyFormatterUSD = NumberFormat.currency(locale: 'en_US', symbol: '\$');
    final NumberFormat currencyFormatterBRL = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    final DateFormat dateFormatter = DateFormat('dd/MM/yyyy');

    final QuoteEntity? usdQuote = crypto.quotes['USD'];
    final QuoteEntity? brlQuote = crypto.quotes['BRL'];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          Center(
            child: Text(
              crypto.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              'Símbolo: ${crypto.symbol}',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
            ),
          ),
          const Divider(height: 24),
          _buildDetailRow('Data de Adição:', crypto.dateAdded != null ? dateFormatter.format(crypto.dateAdded!) : 'N/A'),
          _buildDetailRow('Preço Atual (USD):', usdQuote != null ? currencyFormatterUSD.format(usdQuote.price) : 'N/A'),
          _buildDetailRow('Preço Atual (BRL):', brlQuote != null ? currencyFormatterBRL.format(brlQuote.price) : 'N/A'),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}