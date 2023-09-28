import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:lottie/lottie.dart';
import 'package:open_weather_client/enums/languages.dart';
import 'package:open_weather_client/models/details.dart';
import 'package:open_weather_client/open_weather.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:starsview/starsview.dart';

import 'package:recive/core/components/sliver_card_container.dart';
import 'package:recive/core/components/sliver_gap.dart';
import 'package:recive/shared/constants/ui_constants.dart';
import 'package:recive/shared/extensions/color_extentions.dart';
import 'package:recive/shared/extensions/context_ui_extension.dart';
import 'package:recive/shared/extensions/text_style_extension.dart';
import 'package:recive/shared/ioc/locator.dart';
import 'package:recive/shared/services/geo_location_service.dart';

class HomePageWeatherSection extends StatefulHookWidget {
  const HomePageWeatherSection({
    super.key,
  });

  @override
  State<HomePageWeatherSection> createState() => _HomePageWeatherSectionState();
}

class _HomePageWeatherSectionState extends State<HomePageWeatherSection> {
  @override
  Widget build(BuildContext context) {
    final openWeather = locator.get<OpenWeather>();
    final geoLocation = useLocationData(debugLabel: 'HomePageWeatherSection');
    final weatherData = useState<WeatherData?>(null);

    Future<void> getWeather() async {
      if (geoLocation == null) {
        return;
      }

      weatherData.value = await openWeather.currentWeatherByLocation(
        latitude: geoLocation.latitude,
        longitude: geoLocation.longitude,
        weatherUnits: WeatherUnits.METRIC,
        language: Languages.ENGLISH,
      );
    }

    useEffect(() {
      getWeather();
      return;
    }, [geoLocation?.timestamp]);

    return SliverAnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: weatherData.value == null
          ? const SliverToBoxAdapter(child: SizedBox.shrink())
          : MultiSliver(
              children: [
                SliverToBoxAdapter(
                  child: Text(
                    "Today's weather",
                    style: context.textTheme.headlineSmall?.withColor(
                      context.colorScheme.onBackground,
                    ),
                  ),
                ),
                const SliverGap(height: 12),
                SliverCardContainer(
                  borderRadius: kMediumBorderRadius,
                  padding: kTinyPadding,
                  sliver: SliverToBoxAdapter(
                    child: RepaintBoundary(
                      child: LayoutBuilder(builder: (context, box) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: kSmallBorderRadius,
                            color: Colors.orange,
                          ),
                          width: box.maxWidth,
                          height: min(box.maxWidth / 2.8, 120),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: ClipRRect(
                                  borderRadius: kSmallBorderRadius,
                                  child: RepaintBoundary(
                                    child: weatherData.value!.details.first
                                        .animatedWidget(
                                      context,
                                      weatherData.value,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

extension AnimatedWeatherWidget on Details {
  Widget animatedWidget(BuildContext context, WeatherData? weatherData) {
    final size = PlatformDispatcher.instance.views.first.physicalSize;
    String lottieFile = '';
    Color color = Colors.white;
    Color fontColor = Colors.black;

    switch (id.toString().characters.first) {
      case '2': // Thunderstorm
        lottieFile =
            'https://lottie.host/fa7764af-9877-4dda-8808-515136de20db/kAFTButpZc.json';
        color = const Color.fromARGB(255, 6, 41, 70);
        fontColor = Colors.white;
        break;
      case '3': // Drizzle
        lottieFile =
            'https://lottie.host/f18a5487-ddee-4fde-8bca-110758c60f6f/NrKgKH5phV.json';
        color = const Color.fromARGB(255, 150, 201, 242);
        fontColor = Colors.black;
        break;
      case '5': // Rain
        lottieFile =
            'https://lottie.host/fc3e0593-d17c-41c0-9585-8d887126a7a5/78zP9WDXsH.json';
        color = const Color.fromARGB(255, 72, 104, 131);
        fontColor = Colors.white;
        break;
      case '6': // Snow
        lottieFile =
            'https://lottie.host/747099a7-a4fd-44fb-908b-3e616a155839/ZGlAuUz9JK.json';
        color = const Color.fromARGB(255, 237, 239, 241);
        fontColor = const Color.fromARGB(255, 7, 2, 25);
        break;
      case '7': // Atmosphere
        lottieFile =
            'https://lottie.host/1bf7865f-13e8-4329-910c-6d3a3e22e8b5/arlsyb4STN.json';
        color = const Color.fromARGB(255, 34, 33, 47);
        fontColor = const Color.fromARGB(255, 200, 199, 202);
        break;
      case '8': // Clear OR Clouds
        if (id == 800) {
          lottieFile =
              'https://lottie.host/4d3ff186-4bbb-4e9a-8eb6-586525750e7c/NlAQhgT2Jk.json';
          color = const Color.fromARGB(255, 191, 239, 255);
          fontColor = const Color.fromARGB(255, 8, 9, 33);
          break;
        } else {
          lottieFile =
              'https://lottie.host/b71cd029-a355-4be9-a579-59671c380e39/cphDoA5WVB.json';
          color = const Color.fromARGB(255, 141, 178, 190);
          fontColor = const Color.fromARGB(255, 8, 9, 33);
          break;
        }

      default:
        lottieFile =
            'https://lottie.host/98412ca0-fe07-4d97-a3ee-006c8c28c1d2/roVKsQZ5P6.json';
        color = const Color.fromARGB(255, 29, 7, 55);
        fontColor = const Color.fromARGB(255, 210, 205, 218);
        break;
    }

    final lottie = Lottie.network(lottieFile);
    final style = context.textTheme.headlineMedium!.copyWith(
      color: fontColor,
    );
    return Container(
      color: color,
      child: Stack(
        children: [
          RepaintBoundary(
            child: Stack(
              children: [
                if (lottieFile.isNotEmpty) ...[
                  if (id != 800)
                    Positioned.fill(
                      left: size.width / 12,
                      child: lottie,
                    ),
                  Positioned.fill(
                    top: 24,
                    left: size.width / 6,
                    child: lottie,
                  ),
                ],
                if (id != 800) const Positioned.fill(child: StarsView(fps: 1)),
              ],
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            child: FittedBox(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: Text(
                        weatherLongDescription.capitalize(),
                        style: style,
                      ),
                    ),
                    const SizedBox(height: 8),
                    FittedBox(
                      child: Text(
                        '${weatherData?.temperature.currentTemperature.toStringAsFixed(0)} °C',
                        style: style,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
