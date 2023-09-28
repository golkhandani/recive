import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geolocator/geolocator.dart';
import 'package:introduction_screen/introduction_screen.dart' as intro;
import 'package:lottie/lottie.dart';

import 'package:recive/modules/introduction_page/cubits/setting_loader_cubit.dart';
import 'package:recive/modules/introduction_page/splash_screen.dart';
import 'package:recive/shared/constants/ui_constants.dart';
import 'package:recive/shared/extensions/color_extentions.dart';
import 'package:recive/shared/extensions/context_ui_extension.dart';
import 'package:recive/shared/extensions/text_style_extension.dart';
import 'package:recive/shared/ioc/locator.dart';
import 'package:recive/shared/services/geo_location_service.dart';
import 'package:recive/shared/services/navigation_service.dart';

class IntroductionScreen extends StatefulHookWidget {
  static const name = 'introduction';
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  @override
  Widget build(BuildContext context) {
    final navigationService = locator.get<NavigationService>();
    final settingCubit = locator.get<SettingLoaderCubit>();
    const bg = Colors.transparent;
    final fontColor = context.colorScheme.onSurface;
    final decoration = intro.PageDecoration(
      pageColor: bg,
      titleTextStyle: context.titleLargePrimaryContainer.withColor(fontColor)!,
      bodyTextStyle: context.textTheme.bodyLarge!.withColor(fontColor)!,
      imagePadding: EdgeInsets.only(top: context.vHeight / 10),
    );
    final pages = [
      intro.PageViewModel(
        decoration: decoration,
        title: "Art and Adventure Companion",
        body:
            "Get ready to explore amazing city landmarks and enjoy unforgettable experiences without the hassle of planning.",
        image: Center(
          child: Lottie.network(
            'https://lottie.host/17788b8b-d558-4e27-be8f-903dd2756659/ryjs3OSW7g.json',
            width: context.vWidth,
            reverse: false,
            frameRate: FrameRate(23),
            errorBuilder: (context, error, stackTrace) {
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
      intro.PageViewModel(
        decoration: decoration,
        title: "Unveiling the Magic of your City",
        body:
            "Dive into our app to discover hidden gems and thrilling events and arts that will make every day an unforgettable journey.",
        image: Center(
          child: Lottie.network(
            'https://lottie.host/b8593499-d23a-4d09-81fa-6d64d123bca0/FZeVBNlmTt.json',
            width: context.vWidth,
            reverse: false,
            frameRate: FrameRate(23),
            errorBuilder: (context, error, stackTrace) {
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
      intro.PageViewModel(
        decoration: decoration,
        title: "Personalized Adventures at Your Fingertips",
        body:
            "Your city adventures are personalized just for you. Find activities that match your preferences, ensuring that each experience is a perfect fit for your taste and style.",
        image: Center(
          child: Lottie.network(
            'https://lottie.host/8ed0ded0-d468-4be7-80bf-c68b427532be/UQexEa0cTs.json',
            width: context.vWidth,
            reverse: false,
            frameRate: FrameRate(23),
            errorBuilder: (context, error, stackTrace) {
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
      intro.PageViewModel(
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
                onTap: () {
                  locator.logger.d("Location Permission requested!");
                  locator.get<LocationService>().requestService(
                    onDone: (permission) {
                      switch (permission) {
                        case LocationPermission.whileInUse:
                        case LocationPermission.always:
                          locator.logger.d("Location Permission Granted");
                          _dialogBuilder(
                            context,
                            text: 'Location Permission Granted',
                          );
                          break;
                        default:
                          locator.logger.d("Location Permission NOT Granted");
                          _dialogBuilder(
                            context,
                            text: 'Location Permission NOT Granted',
                          );
                      }
                    },
                  );
                },
                child: Container(
                  padding: kTinyPadding,
                  alignment: Alignment.center,
                  constraints:
                      const BoxConstraints.expand(height: 48, width: 320),
                  decoration: ShapeDecoration(
                    color: context.colorScheme.tertiaryContainer,
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
                    style: context.titleMediumOnPrimaryContainer.withColor(
                      context.colorScheme.onTertiaryContainer,
                    ),
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
            frameRate: FrameRate(23),
            errorBuilder: (context, error, stackTrace) {
              return const CircularProgressIndicator();
            },
          ),
        ),
      )
    ];
    return Container(
      color: context.colorScheme.background,
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Stack(
        children: [
          intro.IntroductionScreen(
            globalBackgroundColor: bg,
            dotsDecorator: intro.DotsDecorator(
              size: const Size.square(10.0),
              activeSize: const Size(50.0, 10.0),
              activeColor: context.colorScheme.secondaryContainer,
              color: fontColor,
              spacing: const EdgeInsets.symmetric(horizontal: 3.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)),
            ),
            dotsContainerDecorator: const BoxDecoration(color: bg),
            pages: pages,
            showSkipButton: true,
            skip: _buildButton('Skip', context),
            next: _buildButton('Next', context),
            done: _buildButton('Done', context),
            onDone: () => onDone(navigationService, settingCubit),
            onSkip: () => onDone(navigationService, settingCubit),
          ),
        ],
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
          backgroundColor: context.colorScheme.surface,
          elevation: 1,
          title: Text(
            'Location Access',
            textAlign: TextAlign.center,
            style: context.textTheme.titleMedium!.withColor(
              context.colorScheme.onSurface,
            ),
          ),
          content: Text(
            text,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium!.withColor(
              context.colorScheme.onSurface,
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: context.textTheme.labelLarge!.withColor(
                  context.colorScheme.onSecondary,
                ),
                backgroundColor: context.colorScheme.secondaryContainer,
                foregroundColor: context.colorScheme.onSecondaryContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.all(8),
              ),
              child: const Padding(
                padding: EdgeInsets.all(4),
                child: Text('Undestood'),
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

  void onDone(
    NavigationService navigationService,
    SettingLoaderCubit settingCubit,
  ) {
    settingCubit.doneIntro();
    navigationService.moveTo(SplashScreen.name);
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
        color: context.colorScheme.tertiary,
        shape: const StadiumBorder(
          side: BorderSide(
            width: 0,
            color: Colors.transparent,
          ),
        ),
      ),
      child: Text(
        text,
        style: context.titleMediumOnPrimaryContainer.withColor(
          context.colorScheme.onTertiary,
        ),
      ),
    );
  }
}
