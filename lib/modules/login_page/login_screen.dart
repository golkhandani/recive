import 'package:flutter/material.dart';

import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:recive/core/enums/loading_state.dart';
import 'package:recive/modules/dashboard/dashboard_screen.dart';
import 'package:recive/modules/introduction_page/splash_screen.dart';
import 'package:recive/modules/login_page/cubits/login_cubit.dart';
import 'package:recive/modules/login_page/widgets/lottie_safe_loading.dart';
import 'package:recive/shared/constants/ui_constants.dart';
import 'package:recive/shared/extensions/text_style_extension.dart';
import 'package:recive/shared/ioc/locator.dart';
import 'package:recive/shared/services/navigation_service.dart';

class LoginScreen extends StatefulHookWidget {
  static const name = 'login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final navigationService = locator.get<NavigationService>();
    final bloc = useBloc<LoginCubit>();
    final state = useBlocBuilder(bloc);
    return Scaffold(
      body: Container(
        color: context.colorTheme.background,
        child: Column(
          children: [
            Flexible(
              child: ClipPath(
                clipper: SinCosineWaveClipper(
                  verticalPosition: VerticalPosition.bottom,
                  horizontalPosition: HorizontalPosition.right,
                ),
                child: Container(
                  color: context.colorTheme.primary,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Center(
                        child: Text(
                          "Welcome to Wise Art City Guide",
                          textAlign: TextAlign.center,
                          style: context.textTheme.titleSmall.onPrimary.style,
                        ),
                      ),
                      const SizedBox(height: 40),
                      const LottieSafeLoading(),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Column(
                children: [
                  InkWell(
                    onTap: () => bloc.loginWithGoogle(
                        onSuccess: () => navigationService.moveTo(SplashScreen.name),
                        onFailure: () {
                          locator.logger.d("Failed");
                        }),
                    child: Container(
                      padding: kTinyPadding,
                      alignment: Alignment.center,
                      constraints: const BoxConstraints.expand(height: 64, width: 350),
                      decoration: const ShapeDecoration(
                        color: Colors.red,
                        shape: StadiumBorder(
                          side: BorderSide(width: 0, color: Colors.transparent),
                        ),
                      ),
                      child: state.googleLoginLoadingState == LoadingState.loading
                          ? const CircularProgressIndicator()
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const FaIcon(
                                  FontAwesomeIcons.google,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  "Login with Google",
                                  textAlign: TextAlign.center,
                                  style: context.textTheme.titleTiny.withColor(Colors.white).style,
                                ),
                              ],
                            ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  InkWell(
                    onTap: () => bloc.loginWithApple(
                      onSuccess: () => navigationService.moveTo(DashboardScreen.name),
                      onFailure: () {
                        locator.logger.d("Failed");
                      },
                    ),
                    child: Container(
                      padding: kTinyPadding,
                      constraints: const BoxConstraints.expand(height: 64, width: 350),
                      alignment: Alignment.center,
                      decoration: const ShapeDecoration(
                        color: Colors.black,
                        shape: StadiumBorder(
                          side: BorderSide(width: 0, color: Colors.transparent),
                        ),
                      ),
                      child: state.appleLoginLoadingState == LoadingState.loading
                          ? const CircularProgressIndicator()
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const FaIcon(
                                  FontAwesomeIcons.apple,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  "Login with Apple",
                                  textAlign: TextAlign.center,
                                  style: context.textTheme.titleTiny
                                      .withColor(
                                        Colors.white,
                                      )
                                      .style,
                                ),
                              ],
                            ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  InkWell(
                    onTap: () => bloc.loginWithApiKey(
                      onSuccess: () {
                        navigationService.moveTo(DashboardScreen.name);
                      },
                      onFailure: () {
                        locator.logger.d("Failed");
                      },
                    ),
                    child: Container(
                      padding: kTinyPadding,
                      constraints: const BoxConstraints.expand(height: 64, width: 350),
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        color: context.colorTheme.primary,
                        shape: const StadiumBorder(
                          side: BorderSide(width: 0, color: Colors.transparent),
                        ),
                      ),
                      child: state.appleLoginLoadingState == LoadingState.loading
                          ? const CircularProgressIndicator()
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const FaIcon(
                                  FontAwesomeIcons.keycdn,
                                  color: Colors.black,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  "Login with ApiKey",
                                  textAlign: TextAlign.center,
                                  style: context.textTheme.titleTiny.onPrimary.style,
                                ),
                              ],
                            ),
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () => launchUrl(Uri.parse('https://google.com')),
                    child: Text(
                      'Terms and Conditions',
                      style: context.textTheme.titleTiny.secondaryContainer.style,
                    ),
                  ),
                  const SizedBox(height: 88),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
