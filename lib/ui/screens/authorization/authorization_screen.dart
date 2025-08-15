import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:practise/ui/widgets/num_button.dart';
import 'authorization_wm.dart';
 
@RoutePage()
class AuthorizationScreen extends ElementaryWidget<AuthorizationWidgetModel> {
  const AuthorizationScreen({super.key}) : super(createAuthorizationWidgetModel);
 
  @override
  Widget build(AuthorizationWidgetModel wm) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 209, 220, 1),
      body: StateNotifierBuilder<bool>(
        listenableState: wm.isPinSet,
        builder: (context, isPinCodeSet) {
        return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    isPinCodeSet ??false ? 'Введите ваш пин-код' : 'Создайте новый пин-код',
                    style: const TextStyle(
                      fontSize: 20, 
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32),
                  StateNotifierBuilder<String>(
                    listenableState: wm.pinInput,
                    builder: (_, pin) {
                      return Text(
                      (pin ?? '').padRight(4, '•'),
                      style: const TextStyle(fontSize: 24, letterSpacing: 10),
                    );
                  },
                ),                
                const SizedBox(height: 20),
                GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    padding: const EdgeInsets.all(20),
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: 1.5,
                    children: [
                      for (int i = 1; i <= 9; i++)
                        NumButton(
                          number: i,
                          onPressed: () => wm.handleNumberClick(i),
                        ),
                        StateNotifierBuilder<bool>(
                        listenableState: wm.isBiometricAvailable,
                        builder: (context, isBiometricAvailable) {
                          return isBiometricAvailable == true
                              ? IconButton(
                                  icon: const Icon(Icons.fingerprint_outlined),
                                  onPressed: () => wm.checkBiometric(),
                                  iconSize: 30,
                                )
                              : IconButton(
                                  icon: const Icon(Icons.heart_broken_outlined),
                                  onPressed: () {},
                                  iconSize: 30,
                                );
                        },
                      ),
                      NumButton(
                        number: 0,
                        onPressed: () => wm.handleNumberClick(0),
                      ),
                      IconButton(
                        icon: const Icon(Icons.backspace),
                        onPressed: wm.handleBackspaceClick,
                        iconSize: 30,
                      ),
                    ],
                ),
                const SizedBox(height: 24),
                ...( (isPinCodeSet ?? false) == false
                ? [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      onPressed: wm.onSavePinPressed,
                      child: const Text('Сохранить'),
                    ),
                  ]
                : [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      onPressed: wm.onPinCodePressed,
                      child: const Text('Войти через пин-код'),
                    ),
                  ]
              ),

                ],
              ),
            );
        },
            ),
          );
        }
}
