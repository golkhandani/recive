import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:recive/enums/loading_state.dart';

import 'package:recive/features/dashboard/dashboard_screen.dart';
import 'package:recive/features/login_page/cubits/login_cubit.dart';
import 'package:recive/features/login_page/widgets/lottie_safe_loading.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/router/navigation_service.dart';
import 'package:url_launcher/url_launcher.dart';

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
        color: context.theme.colorScheme.background,
        child: Column(
          children: [
            Flexible(
              child: ClipPath(
                clipper: SinCosineWaveClipper(
                  verticalPosition: VerticalPosition.bottom,
                  horizontalPosition: HorizontalPosition.right,
                ),
                child: Container(
                  color: context.theme.colorScheme.primary,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Center(
                        child: Text(
                          "Welcome to VanExplore",
                          textAlign: TextAlign.center,
                          style: context.titleLargePrimaryContainer,
                        ),
                      ),
                      const LottieSafeLoading(),
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
                        onSuccess: () =>
                            navigationService.navigateTo(DashboardScreen.name),
                        onFailure: () {
                          if (kDebugMode) {
                            print("Failed");
                          }
                        }),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      alignment: Alignment.center,
                      constraints:
                          const BoxConstraints.expand(height: 64, width: 350),
                      decoration: const ShapeDecoration(
                        color: Colors.red,
                        shape: StadiumBorder(
                          side: BorderSide(width: 0, color: Colors.transparent),
                        ),
                      ),
                      child: state.googleLoginLoadingState ==
                              LoadingState.loading
                          ? const CircularProgressIndicator()
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Iconify(
                                  Bx.bxl_google,
                                  color: context
                                      .theme.colorScheme.onErrorContainer,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "Login with Google",
                                  textAlign: TextAlign.center,
                                  style:
                                      context.textTheme.titleMedium!.withColor(
                                    context.theme.colorScheme.onErrorContainer,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  InkWell(
                    onTap: () => bloc.loginWithApple(
                      onSuccess: () =>
                          navigationService.navigateTo(DashboardScreen.name),
                      onFailure: () {
                        if (kDebugMode) {
                          print("Failed");
                        }
                      },
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      constraints:
                          const BoxConstraints.expand(height: 64, width: 350),
                      alignment: Alignment.center,
                      decoration: const ShapeDecoration(
                        color: Colors.black,
                        shape: StadiumBorder(
                          side: BorderSide(width: 0, color: Colors.transparent),
                        ),
                      ),
                      child: state.appleLoginLoadingState ==
                              LoadingState.loading
                          ? const CircularProgressIndicator()
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Iconify(
                                  Bx.bxl_apple,
                                  color: context
                                      .theme.colorScheme.onErrorContainer,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "Login with Apple",
                                  textAlign: TextAlign.center,
                                  style:
                                      context.textTheme.titleMedium!.withColor(
                                    context
                                        .theme.colorScheme.onPrimaryContainer,
                                  ),
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
                      style: context.titleLargePrimaryContainer,
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
