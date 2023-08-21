import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:open_weather_client/enums/languages.dart';
import 'package:open_weather_client/models/details.dart';
import 'package:open_weather_client/open_weather.dart';
import 'package:recive/components/sliver_card_container.dart';
import 'package:recive/components/sliver_gap.dart';
import 'package:recive/ioc/geo_location_service.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:weather_animation/weather_animation.dart';

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
    final geoLocation = useUserLocation();
    final weatherData = useState<WeatherData?>(null);

    Future<void> getWeather() async {
      if (geoLocation.fetched == false) {
        return;
      }

      weatherData.value = await openWeather.currentWeatherByLocation(
        latitude: geoLocation.position!.latitude!,
        longitude: geoLocation.position!.longitude!,
        weatherUnits: WeatherUnits.METRIC,
        language: Languages.ENGLISH,
      );
    }

    useEffect(() {
      getWeather();
      return;
    }, [geoLocation.timestamp]);

    final style = context.textTheme.headlineMedium!.copyWith(
      color: context.theme.colorScheme.onPrimary,
    );

    return SliverAnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: weatherData.value == null
          ? const SliverToBoxAdapter(child: SizedBox.shrink())
          : MultiSliver(
              children: [
                SliverToBoxAdapter(
                  child: Text(
                    "Today's weather",
                    style: context.textTheme.headlineSmall,
                  ),
                ),
                const SliverGap(height: 12),
                SliverCardContainer(
                  borderRadius: BorderRadius.circular(16),
                  padding: const EdgeInsets.all(12),
                  sliver: SliverToBoxAdapter(
                    child: LayoutBuilder(builder: (context, box) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.orange,
                        ),
                        width: box.maxWidth,
                        height: min(box.maxWidth / 2.8, 120),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: weatherData.value!.details.first.widget,
                              ),
                            ),
                            Positioned.fill(
                              top: 12,
                              bottom: 12,
                              child: FittedBox(
                                child: Padding(
                                  padding: const EdgeInsets.all(32),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FittedBox(
                                        child: Text(
                                          weatherData.value!.details.first
                                              .weatherLongDescription
                                              .capitalize(),
                                          style: style,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      FittedBox(
                                        child: Text(
                                          '${weatherData.value!.temperature.currentTemperature.toStringAsFixed(0)} °C',
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
                    }),
                  ),
                ),
              ],
            ),
    );
  }
}

extension WeatherWidget on Details {
  Widget get widget {
    final size = PlatformDispatcher.instance.views.first.physicalSize;
    final clear = WrapperScene(
      isLeftCornerGradient: true,
      colors: const [
        Color(0xff1976d2),
        Color(0xffe1f5fe),
      ],
      children: [
        SunWidget(
          sunConfig: SunConfig(
            width: size.width / 2,
            blurSigma: 13,
            blurStyle: BlurStyle.solid,
            isLeftLocation: true,
            coreColor: const Color(0xffff9800),
            midColor: const Color(0xffffee58),
            outColor: const Color(0xffffa726),
            animMidMill: 1500,
            animOutMill: 1500,
          ),
        ),
      ],
    );

    final cloud = WrapperScene(
      isLeftCornerGradient: true,
      colors: const [
        Color(0xff1976d2),
        Color.fromARGB(255, 132, 190, 216),
      ],
      children: [
        CloudWidget(
          cloudConfig: CloudConfig(
            size: size.width / 1.4,
            color: Colors.white70,
            icon: const IconData(63056, fontFamily: 'MaterialIcons'),
            widgetCloud: null,
            x: 134,
            y: 0,
            scaleBegin: 1,
            scaleEnd: 1.1,
            scaleCurve: Curves.bounceIn,
            slideX: 11,
            slideY: 5,
            slideDurMill: 2000,
            slideCurve: Curves.bounceInOut,
          ),
        ),
        CloudWidget(
          cloudConfig: CloudConfig(
            size: size.width / 2.4,
            color: Colors.white70,
            icon: const IconData(63056, fontFamily: 'MaterialIcons'),
            widgetCloud: null,
            x: size.width / 1.6,
            y: 0,
            scaleBegin: 1,
            scaleEnd: 1.1,
            scaleCurve: Curves.bounceIn,
            slideX: 20,
            slideY: 2,
            slideDurMill: 2000,
            slideCurve: Curves.bounceInOut,
          ),
        ),
        CloudWidget(
          cloudConfig: CloudConfig(
            size: size.width / 3,
            color: Colors.white70,
            icon: const IconData(63056, fontFamily: 'MaterialIcons'),
            widgetCloud: null,
            x: 35,
            y: 6,
            scaleBegin: 1,
            scaleEnd: 1.1,
            scaleCurve: Curves.bounceIn,
            slideX: 20,
            slideY: 2,
            slideDurMill: 2000,
            slideCurve: Curves.bounceInOut,
          ),
        ),
      ],
    );

    switch (id.toString().characters.first) {
      case '2': // Thunderstorm
        return WeatherScene.stormy.getWeather();
      case '3': // Drizzle
        return WeatherScene.showerSleet.getWeather();
      case '5': // Rain
        return WeatherScene.rainyOvercast.getWeather();
      case '6': // Snow
        return WeatherScene.snowfall.getWeather();
      case '7': // Atmosphere
        return WeatherScene.frosty.getWeather();
      case '8': // Clear OR Clouds
        if (id == 800) {
          return clear;
        } else {
          return cloud;
        }

      default:
        return WeatherScene.weatherEvery.getWeather();
    }
  }
}
