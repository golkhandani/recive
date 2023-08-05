import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:recive/features/timer_page/bloc/fasting_bloc.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/layout/custom_shape_background_widget.dart';
import 'package:recive/models/fasting.model.dart';
import 'package:recive/router/navigation_service.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

class TimerScreen extends HookWidget {
  static const name = 'timer';
  const TimerScreen({super.key});

  final double _width = 30;
  final TextStyle style = const TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    final navigationService = locator.get<NavigationService>();
    final bloc = useBloc<FastingBloc>();
    final state = useBlocBuilder(bloc);
    useEffect(() {
      bloc.add(const FastingEvent.load());
      return;
    }, []);

    final selected = state.selectedFastings;

    final ranges = selected?.fastingHours.map((e) {
          return FastingHour(
            colorHex: e.colorHex,
            description: e.description,
            start: (e.start + selected.fastingWindowStart - 1) % 24,
            end: (e.end + selected.fastingWindowStart - 1) % 24,
          );
        }).toList() ??
        [];

    final nowHour = DateTime.now().hour;

    final currentRange = ranges.firstWhereOrNull(
        (element) => element.start <= nowHour && nowHour < element.end);

    final timerIsActive = useState(false);
    final fastingTimerState = useState(
      const FastingTimer(hours: 0, minutes: 0, seconds: 0),
    );

    void cancelTimer(Timer timer) {
      timerIsActive.value = false;
      timer.cancel();
      fastingTimerState.value =
          const FastingTimer(hours: 0, minutes: 0, seconds: 0);
    }

    Future<void> triggerFastingTimer() async {
      timerIsActive.value = !timerIsActive.value;
      Timer.periodic(
        const Duration(seconds: 1),
        (timer) async {
          if (!timerIsActive.value) {
            cancelTimer(timer);
            return;
          }
          fastingTimerState.value = fastingTimerState.value.copyWith(
            seconds: fastingTimerState.value.seconds + 1,
          );
          if (fastingTimerState.value.seconds >= 60) {
            fastingTimerState.value = fastingTimerState.value.copyWith(
              seconds: 00,
              minutes: fastingTimerState.value.minutes + 1,
            );
          }
          if (fastingTimerState.value.minutes >= 60) {
            fastingTimerState.value = fastingTimerState.value.copyWith(
              minutes: 00,
              hours: fastingTimerState.value.hours + 1,
            );
          }
          if (fastingTimerState.value.hours >=
              (selected?.fastingWindowDuration ?? 24)) {
            fastingTimerState.value = fastingTimerState.value.copyWith(
              hours: 00,
            );
            cancelTimer(timer);
            return;
          }
        },
      );
    }

    return CustomShapeBackgroundWidget(
      child: SingleChildScrollView(
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                'Fast Meter',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: SfRadialGauge(
                        axes: <RadialAxis>[
                          RadialAxis(
                            axisLineStyle: const AxisLineStyle(
                              thickness: 0.2,
                              thicknessUnit: GaugeSizeUnit.factor,
                              color: Colors.white,
                            ),
                            showLabels: false,
                            showTicks: false,
                            minimum: 0,
                            maximum: 24,
                            startAngle: 270,
                            endAngle: 270,
                            radiusFactor: 1,
                            tickOffset: 10,
                            ranges: ranges.isNotEmpty
                                ? <GaugeRange>[
                                    ...ranges.mapIndexed(
                                      (i, e) => GaugeRange(
                                        rangeOffset: 5,
                                        startValue: e.start.toDouble(),
                                        endValue: e.end.toDouble(),
                                        //  color: Colors.red,
                                        gradient: SweepGradient(
                                          colors: [
                                            HexColor.fromHex(e.colorHex),
                                            i + 1 < ranges.length
                                                ? HexColor.fromHex(
                                                    ranges[i + 1].colorHex)
                                                : HexColor.fromHex(e.colorHex)
                                          ],
                                        ),
                                        startWidth: _width,
                                        endWidth: _width,
                                      ),
                                    ),
                                    if (ranges.lastOrNull != null &&
                                        ranges.firstOrNull != null)
                                      GaugeRange(
                                        rangeOffset: 5,
                                        startValue: ranges.isNotEmpty
                                            ? ranges.last.start.toDouble()
                                            : 0,
                                        endValue: ranges.isNotEmpty
                                            ? ranges.first.start.toDouble()
                                            : 0,
                                        gradient: SweepGradient(
                                          stops: const [.2, 0.4, 0.7, 0.9, 1],
                                          colors: [
                                            HexColor.fromHex(
                                                ranges.last.colorHex),
                                            Colors.green,
                                            Colors.green,
                                            Colors.green,
                                            HexColor.fromHex(
                                                ranges.first.colorHex),
                                          ],
                                        ),
                                        startWidth: _width,
                                        endWidth: _width,
                                      ),
                                  ]
                                : [],
                            pointers: [
                              ...ranges.mapIndexed(
                                (i, e) => WidgetPointer(
                                  value: e.start.toDouble(),
                                  child: Container(
                                    width: _width,
                                    height: _width,
                                    decoration: BoxDecoration(
                                      color: i == 0
                                          ? Colors.green
                                          : HexColor.fromHex(
                                              ranges[i].colorHex),
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(e.start.toString()),
                                    ),
                                  ),
                                ),
                              ),
                              if (ranges.lastOrNull != null)
                                WidgetPointer(
                                  value: ranges.last.end.toDouble(),
                                  child: Container(
                                    width: _width,
                                    height: _width,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                          color: Colors.white, width: 1.5),
                                    ),
                                    child: Center(
                                        child:
                                            Text(ranges.last.end.toString())),
                                  ),
                                ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              currentRange != null
                                  ? 'Fasting Window'
                                  : 'Eating Window',
                              style: style,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                fastingTimerState.value.displayClock.toString(),
                style: const TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Material(
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    print('InkWell');
                    triggerFastingTimer();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: context.theme.colorScheme.primary, width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Center(
                      child: Text(
                        timerIsActive.value ? 'Stop Fasting' : 'Start Fasting',
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                currentRange?.description ?? selected?.description ?? '',
                style: const TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
