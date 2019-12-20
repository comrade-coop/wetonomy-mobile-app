import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wetonomy/repositories/terminals_repository.dart';
import 'package:wetonomy/services/contracts_api_client.dart';
import 'package:wetonomy/services/shared_preferences_terminals_dao.dart';
import 'package:wetonomy/services/strongforce_api_client_cosmos.dart';
import 'package:wetonomy/repositories/repositories.dart';
import 'package:wetonomy/services/wallet_storage.dart';
import 'package:wetonomy/services/wallet_utility.dart';

GetIt locator = GetIt();

Future<void> setupServiceLocator() async {
  await _registerTerminalsRepository();
  await _registerAccountRepository();
}

_registerAccountRepository() {
  final walletUtility = WalletCrypto();
  final walletStorage = WalletStorage(FlutterSecureStorage());
  locator.registerSingleton(AccountRepository(walletUtility, walletStorage));
}

Future<void> _registerTerminalsRepository() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  final terminalManager = SharedPreferencesTerminalsDao(sharedPrefs);

  ContractsApiClient apiClient = StrongForceApiClientCosmos();

  locator.registerSingleton<TerminalsRepository>(
      TerminalsRepository(terminalManager, apiClient));
}
