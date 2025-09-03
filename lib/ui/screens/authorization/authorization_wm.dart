import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:practise/data/repositories/secure_storage_repository.dart';
import 'package:practise/data/router/task_router.dart';
import 'authorization_model.dart';
import 'authorization_screen.dart';
 
class AuthorizationWidgetModel extends WidgetModel<AuthorizationScreen, AuthorizationModel> {
  
  final isPinSet = StateNotifier<bool>(initValue: false);
  final pinInput = StateNotifier<String>(initValue: '');
  final isBiometricAvailable = StateNotifier<bool>(initValue: false);

  final auth = LocalAuthentication();
  
  AuthorizationWidgetModel(AuthorizationModel model) : super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _checkPinCodeExists();
    _checkBiometricAvailability();
  }

  Future<void> _checkPinCodeExists() async {
    final pinExists = await SecureStorageRepository().getValue('pinCode') != null;
    isPinSet.accept(pinExists);
  }

  void setPinCodeState(bool newState) {
    isPinSet.accept(newState);
  }

  void handleNumberClick(int number) {
  String curCode = pinInput.value ?? '';
    if (curCode.length < 4) {
      curCode = curCode + number.toString();
      pinInput.accept(curCode);
    }
  }

  void handleBackspaceClick() {
    String curCode = pinInput.value ?? '';
    if (curCode.isNotEmpty) {
      curCode = curCode
        .substring(0, curCode.length - 1);
    }
    pinInput.accept(curCode);
  }

  Future<void> _checkBiometricAvailability() async {
    try{
      bool available = await auth.canCheckBiometrics;
      isBiometricAvailable.accept(available);
    }
    catch(e) {
      
      log('Biometric check error: $e');
      isBiometricAvailable.accept(false);
    }
  }

  Future<void> checkBiometric() async {
    try {
      bool authenticate = await auth.authenticate(localizedReason: 'Подтвердите отпечатком пальца для входа',
      options: const AuthenticationOptions(
        biometricOnly: true,
        stickyAuth: true
      ));
      if (authenticate && context.mounted) {
        showSnackBar('Авторизация прошла успешно!');
        context.router.replaceAll([const TaskTabsWrapperRoute()]);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка аутентификации: ${e.toString()}')),
        );
      }
    } finally {
      
      log('Fingerprint authentication');
    }
  }

  void showSnackBar(String message) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void onPinCodePressed () async {
    final currentPinCode = await SecureStorageRepository()
                        .getValue('pinCode');
    if (currentPinCode == null) return;
    
    final newPinCode = pinInput.value;
    
    if (!context.mounted) return;
    
    if (currentPinCode == newPinCode) {
      showSnackBar('Пин-код верный');
      if (context.mounted) {
        context.router.replaceAll([const TaskTabsWrapperRoute()]);
      }
    } else {
      showSnackBar('Пин-код неверный');
    }
  }

  void onSavePinPressed() async {
    String curCode = pinInput.value ?? '';
    if (curCode.length < 4) {
      showSnackBar('Введите пин-код полностью');
      return;
    }
    await SecureStorageRepository().setValue(
      'pinCode', 
      curCode,
    );
    showSnackBar('Пин-код сохранён');
    setPinCodeState(true);
    pinInput.accept('');
  }

  
  @override
  void dispose() {
    super.dispose();
  }
}

AuthorizationWidgetModel createAuthorizationWidgetModel(BuildContext context) {
  return AuthorizationWidgetModel(AuthorizationModel());
}