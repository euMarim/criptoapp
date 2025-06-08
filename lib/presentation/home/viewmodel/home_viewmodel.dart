import 'package:flutter/material.dart';
import 'package:cryptoapp/domain/entities/cryptocurrency_entity.dart';
import 'package:cryptoapp/domain/usecases/get_cryptocurrencies_usecase.dart';

enum HomeState { initial, loading, loaded, error }
enum CurrencyDisplay { usd, brl }

class HomeViewModel extends ChangeNotifier {
  final GetCryptocurrenciesUseCase _getCryptocurrenciesUseCase;

  HomeViewModel(this._getCryptocurrenciesUseCase);

  HomeState _state = HomeState.initial;
  HomeState get state => _state;

  List<CryptocurrencyEntity> _cryptocurrencies = [];
  List<CryptocurrencyEntity> get cryptocurrencies => _cryptocurrencies;

  List<CryptocurrencyEntity> _allCryptocurrencies = [];

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  CurrencyDisplay _currentCurrency = CurrencyDisplay.usd;
  CurrencyDisplay get currentCurrency => _currentCurrency;

  Future<void> fetchCryptocurrencies() async {
    _state = HomeState.loading;
    _errorMessage = '';
    notifyListeners();

    try {
      _allCryptocurrencies = await _getCryptocurrenciesUseCase.call();
      _cryptocurrencies = List.from(_allCryptocurrencies);
      _state = HomeState.loaded;
    } catch (e) {
      _errorMessage = 'Erro ao carregar criptomoedas: $e';
      _state = HomeState.error;
    } finally {
      notifyListeners();
    }
  }

  void filterCryptocurrenciesBySymbols(String query) {
    if (query.trim().isEmpty) {
      _cryptocurrencies = List.from(_allCryptocurrencies);
      notifyListeners();
      return;
    }

    final List<String> searchTerms = query
        .split(',')
        .map((term) => term.trim().toLowerCase())
        .where((term) => term.isNotEmpty)
        .toList();

    if (searchTerms.isEmpty) {
      _cryptocurrencies = List.from(_allCryptocurrencies);
    } else {
      _cryptocurrencies = _allCryptocurrencies.where((crypto) {
        final cryptoSymbolLower = crypto.symbol.toLowerCase();
        return searchTerms.any((term) => cryptoSymbolLower.contains(term));
      }).toList();
    }

    notifyListeners();
  }

  void changeCurrency(CurrencyDisplay newCurrency) {
    if (_currentCurrency != newCurrency) {
      _currentCurrency = newCurrency;
      notifyListeners();
    }
  }
}