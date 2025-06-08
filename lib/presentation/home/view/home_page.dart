import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cryptoapp/presentation/home/viewmodel/home_viewmodel.dart';
import 'package:cryptoapp/presentation/home/widgets/cryptocurrency_list_item.dart';
import 'package:cryptoapp/presentation/common/widgets/loading_indicator.dart';
import 'package:cryptoapp/presentation/common/widgets/error_message.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeViewModel>(context, listen: false).fetchCryptocurrencies();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {

        final Color usdButtonColor = viewModel.currentCurrency == CurrencyDisplay.usd ? Colors.red : const Color.fromARGB(255, 39, 39, 39);
        final Color brlButtonColor = viewModel.currentCurrency == CurrencyDisplay.brl ? Colors.green : const Color.fromARGB(255, 39, 39, 39);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Criptomoedas'),
            centerTitle: true,
            actions: [
              TextButton(
                onPressed: () {
                  viewModel.changeCurrency(CurrencyDisplay.usd);
                },
                child: Text(
                  'USD',
                  style: TextStyle(
                    color: usdButtonColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              TextButton(
                onPressed: () {
                  viewModel.changeCurrency(CurrencyDisplay.brl);
                },
                child: Text(
                  'BRL',
                  style: TextStyle(
                    color: brlButtonColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: 'Pesquisar pelo símbolo (ex: BTC, ETH)',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        viewModel.filterCryptocurrenciesBySymbols('');
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: (query) {
                    viewModel.filterCryptocurrenciesBySymbols(query);
                  },
                ),
              ),
              Expanded(
                child: Builder(
                  builder: (context) {
                    switch (viewModel.state) {
                      case HomeState.loading:
                        return const LoadingIndicator();
                      case HomeState.error:
                        return ErrorMessage(message: viewModel.errorMessage);
                      case HomeState.loaded:
                        if (viewModel.cryptocurrencies.isEmpty) {
                          return const Center(child: Text('Nenhuma criptomoeda encontrada com os símbolos informados.'));
                        }
                        return RefreshIndicator(
                          onRefresh: () => viewModel.fetchCryptocurrencies(),
                          child: ListView.builder(
                            itemCount: viewModel.cryptocurrencies.length,
                            itemBuilder: (context, index) {
                              final crypto = viewModel.cryptocurrencies[index];
                              return CryptocurrencyListItem(
                                crypto: crypto,
                                currency: viewModel.currentCurrency,
                              );
                            },
                          ),
                        );
                      case HomeState.initial:
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}