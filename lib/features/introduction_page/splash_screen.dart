import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';

import 'package:recive/features/dashboard/dashboard_screen.dart';
import 'package:recive/features/introduction_page/cubits/setting_loader_cubit.dart';
import 'package:recive/features/introduction_page/introduction_screen.dart';
import 'package:recive/features/login_page/login_screen.dart';
import 'package:recive/features/login_page/widgets/lottie_safe_loading.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/layout/ui_constants.dart';
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
    final bloc = useBloc<SettingLoaderCubit>();
    useEffect(() {
      Future.delayed(kLoadingDuration).then(
        (value) => bloc.checkInitialization(
          onIntro: () => navigationService.moveTo(IntroductionScreen.name),
          onLoggedin: () => navigationService.moveTo(DashboardScreen.name),
          onNeedLogin: () => navigationService.moveTo(LoginScreen.name),
        ),
      );
      return;
    }, []);
    return Scaffold(
      body: Container(
        color: context.theme.colorScheme.background,
        child: const LottieSafeLoading(),
      ),
    );
  }
}
