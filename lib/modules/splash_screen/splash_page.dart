import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/ioc/locator.dart';
import 'package:art_for_all/modules/dashboard_screen.dart';
import 'package:art_for_all/core/services/navigation_service.dart';
import 'package:art_for_all/core/theme/theme.dart';
import 'package:art_for_all/core/widgets/lottie_safe_loading.dart';
import 'package:art_for_all/modules/auth_screen/login_page.dart';
import 'package:art_for_all/modules/featured_art_screen/featured_art_bloc.dart';
import 'package:art_for_all/modules/map_art_screen/map_art_bloc.dart';
import 'package:art_for_all/modules/profile_screen/profile_bloc.dart';
import 'package:art_for_all/modules/splash_screen/splash_bloc.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static const name = 'splash';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final navigationService = locator.get<NavigationService>();
  final profileBloc = locator.get<ProfileBloc>();
  final featuredArtBloc = locator.get<FeaturedArtBloc>();
  final mapArtBloc = locator.get<MapArtBloc>();
  final bloc = locator.get<SplashBloc>();

  @override
  void initState() {
    Future.delayed(kLoadingDuration).then(
      (value) => bloc.checkInitialization(
        onIntro: (pageIndex) {
          // navigationService
          //     .moveTo(OnboardingScreen.name, queryParameters: {'page': '$pageIndex'});
        },
        onLoggedIn: () {
          // prepare cache
          profileBloc.getUser();
          featuredArtBloc.init();
          mapArtBloc.init(null);
          // navigate
          navigationService.moveTo(DashboardScreen.name);
        },
        onNeedLogin: () {
          navigationService.moveTo(LoginScreen.name);
        },
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: context.colorTheme.background,
        child: const LottieSafeLoading(),
      ),
    );
  }
}
