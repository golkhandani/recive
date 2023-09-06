import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:recive/features/dashboard/dashboard_screen.dart';
import 'package:recive/features/login_page/cubits/login_cubit.dart';
import 'package:recive/features/login_page/login_screen.dart';
import 'package:recive/features/login_page/widgets/lottie_safe_loading.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/router/navigation_service.dart';

class SplashScreen extends StatefulHookWidget {
  static const name = 'splash';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final navigationService = locator.get<NavigationService>();
    final bloc = useBloc<LoginCubit>();
    useEffect(() {
      Future.delayed(const Duration(seconds: 2)).then(
        (value) => bloc.checkLogin(
          onLogin: () => navigationService.moveTo(DashboardScreen.name),
          onNeedLogin: () => navigationService.moveTo(LoginScreen.name),
        ),
      );

      return;
    }, []);
    return Scaffold(
      body: Container(
        color: context.theme.colorScheme.surface,
        child: const LottieSafeLoading(),
      ),
    );
  }
}
