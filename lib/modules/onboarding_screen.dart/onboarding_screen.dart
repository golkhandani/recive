import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/extensions/context_ui_extension.dart';
import 'package:art_for_all/core/ioc/locator.dart';
import 'package:art_for_all/core/services/location_service.dart';
import 'package:art_for_all/core/services/navigation_service.dart';
import 'package:art_for_all/core/theme/theme.dart';
import 'package:art_for_all/modules/onboarding_screen.dart/onboarding_bloc.dart';
import 'package:art_for_all/modules/splash_screen/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

class OnboardingScreen extends StatefulWidget {
  static const name = 'onboarding';
  final int initialPage;
  const OnboardingScreen({super.key, required this.initialPage});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final carouselController = CarouselController(initialItem: 0);
  final bloc = locator.get<OnboardingBloc>();
  final geolocator = locator.get<ILocationService>();
  final navigationService = locator.get<NavigationService>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    bloc.clear();
    super.dispose();
  }

  final _introKey = GlobalKey<IntroductionScreenState>();
  final bg = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colorTheme.background,
      child: BlocBuilder<OnboardingBloc, OnboardingBlocState>(
        bloc: bloc,
        builder: (context, state) {
          final fontColor = context.colorTheme.onBackground;
          final decoration = PageDecoration(
            pageColor: bg,
            titleTextStyle:
                context.typographyTheme.titleMedium.copyWithColor(color: fontColor).textStyle,
            bodyTextStyle:
                context.typographyTheme.bodyMedium.copyWithColor(color: fontColor).textStyle,
            imagePadding: EdgeInsets.only(top: context.vHeight / 10),
          );
          final pages = [
            buildWelcomePage(decoration, context),
            buildUnveilingPage(decoration, context),
            buildPersonalizedPage(decoration, context),
            buildPermissionPage(decoration, context)
          ];
          return Container(
            color: context.colorTheme.background,
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Stack(
              children: [
                IntroductionScreen(
                  key: _introKey,
                  globalBackgroundColor: bg,
                  dotsDecorator: DotsDecorator(
                    size: const Size.square(10.0),
                    activeSize: const Size(50.0, 10.0),
                    activeColor: context.colorTheme.secondaryContainer,
                    color: fontColor,
                    spacing: const EdgeInsets.symmetric(horizontal: 3.0),
                    activeShape:
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                  ),
                  dotsContainerDecorator: BoxDecoration(color: bg),
                  pages: pages,
                  showSkipButton: true,
                  skip: _buildButton('Skip', context),
                  next: _buildButton('Next', context),
                  done: _buildButton('Done', context),
                  onDone: onDone,
                  onSkip: () {
                    _introKey.currentState?.controller.jumpToPage(pages.length - 1);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  PageViewModel buildPersonalizedPage(PageDecoration decoration, BuildContext context) {
    return PageViewModel(
      decoration: decoration,
      title: "Personalized Adventures at Your Fingertips",
      body:
          "Your city adventures are personalized just for you. Find activities that match your preferences, ensuring that each experience is a perfect fit for your taste and style.",
      image: Center(
        child: Lottie.network(
          'https://lottie.host/8ed0ded0-d468-4be7-80bf-c68b427532be/UQexEa0cTs.json',
          width: context.vWidth,
          reverse: false,
          frameRate: const FrameRate(23),
          errorBuilder: (context, error, stackTrace) {
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  PageViewModel buildUnveilingPage(PageDecoration decoration, BuildContext context) {
    return PageViewModel(
      decoration: decoration,
      title: "Unveiling the Magic of your City",
      body:
          "Dive into our app to discover hidden gems and thrilling events and arts that will make every day an unforgettable journey.",
      image: Center(
        child: Lottie.network(
          'https://lottie.host/b8593499-d23a-4d09-81fa-6d64d123bca0/FZeVBNlmTt.json',
          width: context.vWidth,
          reverse: false,
          frameRate: const FrameRate(23),
          errorBuilder: (context, error, stackTrace) {
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  PageViewModel buildWelcomePage(PageDecoration decoration, BuildContext context) {
    return PageViewModel(
      decoration: decoration,
      title: "Art and Adventure Companion",
      body:
          "Get ready to explore amazing city landmarks and enjoy unforgettable experiences without the hassle of planning.",
      image: Center(
        child: Lottie.network(
          'https://lottie.host/17788b8b-d558-4e27-be8f-903dd2756659/ryjs3OSW7g.json',
          width: context.vWidth,
          reverse: false,
          frameRate: const FrameRate(23),
          errorBuilder: (context, error, stackTrace) {
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  PageViewModel buildPermissionPage(PageDecoration decoration, BuildContext context) {
    return PageViewModel(
      decoration: decoration,
      title: "“Speak Friend and Enter”",
      bodyWidget: Column(
        children: [
          Text(
            "In thy neighborhood, if thou wishest to discern the happenings, grant access to thy location, thou must.",
            style: decoration.bodyTextStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          Center(
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () async {
                geolocator.getPermission().then((permission) {
                  if (!context.mounted) return;
                  switch (permission) {
                    case LocationPermission.whileInUse:
                    case LocationPermission.always:
                      _dialogBuilder(
                        context,
                        text: 'Location Permission Granted',
                      );
                      break;
                    default:
                      _dialogBuilder(
                        context,
                        text: 'Location Permission NOT Granted',
                      );
                  }
                });
              },
              child: Container(
                padding: kTinyPadding,
                alignment: Alignment.center,
                constraints: const BoxConstraints.expand(height: 48, width: 320),
                decoration: ShapeDecoration(
                  color: context.colorTheme.primary,
                  shape: const StadiumBorder(
                    side: BorderSide(
                      width: 0,
                      color: Colors.transparent,
                    ),
                  ),
                ),
                child: Text(
                  'Location Permission',
                  textAlign: TextAlign.center,
                  style: context.typographyTheme.titleTiny.onPrimary.textStyle,
                ),
              ),
            ),
          ),
        ],
      ),
      image: Center(
        child: Lottie.network(
          'https://lottie.host/1b128ccd-0b44-46a8-91c1-3e46f9d0f201/MHvxwRXfFG.json',
          height: context.vHeight / 3,
          reverse: false,
          fit: BoxFit.cover,
          frameRate: const FrameRate(23),
          errorBuilder: (context, error, stackTrace) {
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(
    BuildContext context, {
    required String text,
  }) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: kMediumBorderRadius,
          ),
          backgroundColor: context.colorTheme.tertiaryContainer,
          elevation: 1,
          title: Text(
            'Location Access',
            textAlign: TextAlign.center,
            style: context.typographyTheme.titleSmall.onTertiaryContainer.textStyle,
          ),
          content: Text(
            text,
            textAlign: TextAlign.center,
            style: context.typographyTheme.bodyMedium.onTertiaryContainer.textStyle,
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: context.typographyTheme.label.onPrimary.textStyle,
                backgroundColor: context.colorTheme.onPrimary,
                foregroundColor: context.colorTheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.all(8),
              ),
              child: const Padding(
                padding: EdgeInsets.all(4),
                child: Text('Understood'),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void onDone() async {
    bloc.done(() => navigationService.moveTo(SplashScreen.name));
  }

  Widget _buildButton(
    String text,
    BuildContext context,
  ) {
    return Container(
      padding: kTinyPadding,
      alignment: Alignment.center,
      constraints: const BoxConstraints.expand(height: 48),
      decoration: ShapeDecoration(
        color: context.colorTheme.tertiary,
        shape: const StadiumBorder(
          side: BorderSide(
            width: 0,
            color: Colors.transparent,
          ),
        ),
      ),
      child: Text(
        text,
        style: context.typographyTheme.titleTiny.onTertiary.textStyle,
      ),
    );
  }
}
