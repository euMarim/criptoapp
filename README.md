# Flutter Crypto App

   Um aplicativo móvel desenvolvido em Flutter para exibir as principais criptomoedas, suas cotações em USD e BRL, e detalhes básicos, utilizando a API da CoinMarketCap.
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## Funcionalidades

• Listagem das principais criptomoedas.
• Pesquisa de criptomoedas por símbolo (separados por vírgula para múltiplas moedas).
• Visualização de cotações em USD e BRL, com formatação monetária.
• Indicador visual para a moeda de exibição (USD/BRL).
• Detalhes da criptomoeda em um `BottomSheet` ao clicar (Nome, Símbolo, Data de Adição, Preço USD/BRL).
• Pull-to-refresh para atualizar a lista de criptomoedas.
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## Arquitetura

- Este projeto segue os princípios da Clean Architecture, separando as responsabilidades em três camadas principais:
	• Presentation Layer (lib/presentation): Contém a UI (Widgets) e o gerenciamento de estado (ViewModels). Interage diretamente com a camada de Domínio.
	• Domain Layer (lib/domain): O coração da aplicação, contendo as entidades (Entities) e os casos de uso (Use Cases). Independente de qualquer framework ou implementação.
	• Data Layer (lib/data): Responsável por buscar e armazenar dados. Inclui as fontes de dados (Datasources) e os repositórios (Repositories) que implementam as interfaces do Domínio.
- Gerenciamento de Estado e Injeção de Dependências
	• Provider: Utilizado para gerenciamento de estado na camada de Apresentação, permitindo que os Widgets acessem e reajam às mudanças nos ViewModels.
	• GetIt: Um Service Locator simples para Injeção de Dependências, facilitando a resolução e fornecimento de instâncias das classes (Services, Repositories, Use Cases, ViewModels) em
  todo o aplicativo.
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Como Executar o Projeto

Siga estas instruções para configurar e executar o projeto em sua máquina local.

Pré-requisitos
   Certifique-se de ter o Flutter SDK instalado.
   Flutter SDK: [Instruções de instalação](https://flutter.dev/docs/get-started/install)
   Editor de Código: Visual Studio Code (com extensão Flutter) ou Android Studio.

1-Passo: Clonar o Repositório

  git clone (HTTPS do repositório)

2-Passo: Configurar a Chave da CoinMarketCap API
   Este aplicativo utiliza a API da CoinMarketCap. Você precisará obter sua própria chave de API.
      Obtenha sua Chave de API:
	  • Vá para https://coinmarketcap.com/api/.
	  • Crie uma conta (o plano gratuito "Basic" é suficiente para este projeto).
	  • No seu Developer Dashboard, copie sua API Key.
      Insira a Chave no Código:
	  • Abra o arquivo lib\shared\constants/app_constants.dart no seu editor de código.
	  • Substitua 'SUA_CHAVE_API_AQUI' pela sua chave API key real.
3-Passo: Instalar Dependências:
	  • No terminal, na pasta raiz do projeto, execute: flutter pub get.
4-Passo: Executar o Aplicativo:
	  • Inicie um emulador/simulador recomendo o Android Studio.
	  • No terminal, na pasta raiz do projeto, execute: flutter run.
   Observação: Se por acaso não funcionar, execulta esses comando novamente
      1. flutter clean (Limpar as dependências)
      2. flutter pub get (Baixar as dependências)
      3. flutter run (Execultar o app)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
