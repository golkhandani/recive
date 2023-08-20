import 'package:flutter/material.dart';
import 'package:flutter_use_geolocation/flutter_use_geolocation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:recive/features/categories_page/models/category.dart';

// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';

extension UiBreakPointDetection on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  ThemeData get theme => Theme.of(this);
  ColorScheme get schema => Theme.of(this).colorScheme;
  Size get size => MediaQuery.of(this).size;
  EdgeInsets get smallPadding => const EdgeInsets.all(8.0);

  double get vWidth => size.width;
  double get vHeight => size.height;
  bool get isNarrowWith => vWidth < (vHeight / 1.2);
  bool get isMediumWith => vWidth >= (vHeight / 1.2) && vWidth < vHeight * 1.8;
  bool get isWideWith => vWidth >= vHeight * 1.8 && vWidth < vHeight * 2.4;
  bool get isUltraWideWith => vWidth >= vHeight * 2.4;

  Widget? checkLoadingState(LoadingState loadingState) {
    if (loadingState == LoadingState.none) {
      return const SliverToBoxAdapter(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (loadingState == LoadingState.error) {
      return const SliverToBoxAdapter(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Iconify(Mdi.error, color: Colors.redAccent),
              SizedBox(width: 12),
              Text(
                'Something went wrong',
                style: TextStyle(color: Colors.redAccent),
              ),
            ],
          ),
        ),
      );
    }
    return null;
  }
}

extension CopyWithColor on TextStyle {
  TextStyle? withColor(Color color) => copyWith(color: color);
}

extension PositionToLatLon on GeolocationState {
  LatLng? get latLng => position != null
      ? LatLng(
          position!.latitude,
          position!.longitude,
        )
      : null;
}

extension ColorEffect on Color {
  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  Color lighten([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }
}

abstract class MaybeEmitHydratedCubit<State> extends HydratedCubit<State> {
  MaybeEmitHydratedCubit(super.state);

  @override
  State? fromJson(Map<String, dynamic> json);

  @override
  Map<String, dynamic>? toJson(State state);

  maybeEmit(State state) {
    if (isClosed) return;
    emit(state);
  }
}

abstract class MaybeEmitCubit<State> extends Cubit<State> {
  MaybeEmitCubit(super.state);

  maybeEmit(State state) {
    if (isClosed) return;
    emit(state);
  }
}
