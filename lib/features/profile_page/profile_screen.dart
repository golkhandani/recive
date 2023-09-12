import 'package:flutter/material.dart';

import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'package:recive/components/card_container.dart';
import 'package:recive/components/screen_safe_area_header.dart';
import 'package:recive/enums/loading_state.dart';
import 'package:recive/extensions/color_extentions.dart';
import 'package:recive/features/favourites_page/cubits/favourite_cubit.dart';
import 'package:recive/features/favourites_page/favourites_screen.dart';
import 'package:recive/features/introduction_page/cubits/setting_loader_cubit.dart';
import 'package:recive/features/login_page/cubits/login_cubit.dart';
import 'package:recive/features/login_page/login_screen.dart';
import 'package:recive/features/profile_page/models/user_custom_data.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/ioc/realm_service.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/layout/custom_shape_background_widget.dart';
import 'package:recive/layout/ui_constants.dart';
import 'package:recive/router/navigation_service.dart';
import 'package:recive/utils/theme_cubit.dart';

class ProfileScreen extends HookWidget {
  static const name = 'profile';
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationService = locator.get<NavigationService>();
    final currentUser = locator.get<RealmApplicationService>().currentUser;
    final customData = UserCustomData.fromJson(currentUser?.customData ?? {});

    final bloc = useBloc<LoginCubit>();
    final state = useBlocBuilder(bloc);

    final favouriteBloc = context.read<FavouritesCubit>();
    final favouriteState = useBlocBuilder(favouriteBloc);

    final themeBloc = context.read<ReciveThemeCubit>();
    final theme = useBlocBuilder(themeBloc);

    final settingbloc = useBloc<SettingLoaderCubit>();
    final setting = useBlocBuilder(settingbloc);

    useEffect(() {
      settingbloc.loadSetting();
      favouriteBloc.loadFavourites();
      return;
    }, [favouriteState.count]);
    return ColoredBox(
      color: context.theme.colorScheme.background,
      child: LayoutBuilder(builder: (context, box) {
        return CustomScrollView(
          slivers: [
            const ScreenSafeAreaHeader(
              title: 'Profile',
              elevation: false,
            ),
            SliverPinnedHeader(
              child: ClipperShadowPainter(
                clipper: SinCosineWaveClipper(
                  verticalPosition: VerticalPosition.bottom,
                  horizontalPosition: HorizontalPosition.right,
                ),
                shadow: Shadow(
                  color: context.colorScheme.shadow,
                  offset: Offset.zero,
                  blurRadius: 4,
                ),
                child: Container(
                  height: 220,
                  color: context.colorScheme.tertiaryContainer,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 12,
                        right: 24,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [
                              BoxShadow(
                                color: context.colorScheme.primary,
                                blurRadius: 2.0,
                                spreadRadius: 1.0,
                                offset: const Offset(1.0, 1.0),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            backgroundImage: customData.imageUrl != null
                                ? NetworkImage(customData.imageUrl!)
                                : null,
                            backgroundColor: context.colorScheme.primary,
                            radius: 72,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 24,
                        left: 24,
                        right: 72 * 2 + 24 + 12,
                        child: Text(
                          customData.name ?? '',
                          style: context.textTheme.titleMedium!.withColor(
                            context.colorScheme.onTertiaryContainer,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 80,
                        left: 24,
                        right: 72 * 2 + 24 + 12,
                        child: InkWell(
                          onTap: () => bloc.logout(
                            onSuccess: () async => await navigationService
                                .logoutTo(LoginScreen.name),
                          ),
                          child: Container(
                            padding: kTinyPadding,
                            alignment: Alignment.center,
                            constraints:
                                const BoxConstraints.expand(height: 48),
                            decoration: ShapeDecoration(
                              color: context.theme.colorScheme.tertiary,
                              shape: const StadiumBorder(
                                side: BorderSide(
                                  width: 0,
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                            child:
                                state.logoutLoadingState == LoadingState.loading
                                    ? const Center(
                                        child: SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(),
                                      ))
                                    : Text(
                                        "Logout",
                                        textAlign: TextAlign.center,
                                        style: context.textTheme.titleMedium!
                                            .withColor(
                                          context.theme.colorScheme.onTertiary,
                                        ),
                                      ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding:
                  EdgeInsets.symmetric(horizontal: kTinyPadding.horizontal / 2),
              sliver: MultiSliver(
                children: [
                  SliverToBoxAdapter(
                    child: CardContainer(
                      borderRadius: BorderRadius.circular(16),
                      padding: kTinyPadding,
                      child: Container(
                        height: context.vHeight - 460,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: kTinyPadding,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 12),
                                _buildThemeSettingSection(
                                  box,
                                  theme,
                                  context,
                                  themeBloc,
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    const Text("Intro has been viewed:"),
                                    const Spacer(),
                                    Theme(
                                      data: ThemeData(useMaterial3: true),
                                      child: Switch(
                                        value: setting.isIntroViewed,
                                        trackOutlineWidth:
                                            const MaterialStatePropertyAll(0),
                                        activeColor: context
                                            .colorScheme.primaryContainer,
                                        inactiveTrackColor:
                                            context.theme.colorScheme.tertiary,
                                        inactiveThumbColor: context
                                            .theme.colorScheme.onTertiary,
                                        onChanged: (value) {
                                          settingbloc.switchIntroSetting(value);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Text("Total favourites:"),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: InkWell(
                                        onTap: favouriteState.count == 0
                                            ? null
                                            : () => navigationService.pushTo(
                                                  FavouritesScreen.name,
                                                ),
                                        child: Container(
                                          padding: kTinyPadding,
                                          alignment: Alignment.center,
                                          constraints:
                                              const BoxConstraints.expand(
                                            height: 42,
                                          ),
                                          decoration: ShapeDecoration(
                                            color: favouriteState.count == 0
                                                ? context
                                                    .colorScheme.surfaceVariant
                                                : context
                                                    .theme.colorScheme.tertiary,
                                            shape: const StadiumBorder(
                                              side: BorderSide(
                                                width: 0,
                                                color: Colors.transparent,
                                              ),
                                            ),
                                          ),
                                          child: favouriteState.loadingState ==
                                                  LoadingState.loading
                                              ? const Center(
                                                  child: SizedBox(
                                                  width: 24,
                                                  height: 24,
                                                  child:
                                                      CircularProgressIndicator(),
                                                ))
                                              : Text(
                                                  favouriteState.count == 0
                                                      ? 'No items'
                                                      : 'View ${favouriteState.count} items',
                                                  textAlign: TextAlign.center,
                                                  style: context
                                                      .textTheme.titleSmall!
                                                      .copyWith(
                                                    color:
                                                        favouriteState.count ==
                                                                0
                                                            ? context
                                                                .colorScheme
                                                                .onTertiary
                                                                .withOpacity(.5)
                                                            : context
                                                                .theme
                                                                .colorScheme
                                                                .onTertiary,
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const Spacer(),
                            Center(
                              child: Text(
                                "COMMING SOON!",
                                style: context.titleLargeOnPrimaryContainer
                                    .copyWith(
                                  color:
                                      context.colorScheme.onTertiaryContainer,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Builder(builder: (context) {
                              return InkWell(
                                onTap: () => bloc.deleteAccount(
                                  onSuccess: () async => await navigationService
                                      .logoutTo(LoginScreen.name),
                                ),
                                child: Container(
                                  padding: kTinyPadding,
                                  alignment: Alignment.center,
                                  constraints:
                                      const BoxConstraints.expand(height: 48),
                                  decoration: ShapeDecoration(
                                    color: context
                                        .theme.colorScheme.errorContainer,
                                    shape: const StadiumBorder(
                                      side: BorderSide(
                                        width: 0,
                                        color: Colors.transparent,
                                      ),
                                    ),
                                  ),
                                  child: state.logoutLoadingState ==
                                          LoadingState.loading
                                      ? const Center(
                                          child: SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(),
                                        ))
                                      : Text(
                                          "Delete Account",
                                          textAlign: TextAlign.center,
                                          style: context.textTheme.titleMedium!
                                              .withColor(
                                            context.theme.colorScheme
                                                .onErrorContainer,
                                          ),
                                        ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Row _buildThemeSettingSection(BoxConstraints box, ReciveTheme theme,
      BuildContext context, ReciveThemeCubit themeBloc) {
    return Row(
      children: [
        const Text("Theme:"),
        const Spacer(),
        ToggleSwitch(
          minWidth: box.maxWidth / 4,
          minHeight: 42.0,
          fontSize: 16.0,
          initialLabelIndex: theme.index,
          activeBgColor: [context.theme.colorScheme.primaryContainer],
          activeFgColor: context.theme.colorScheme.onPrimaryContainer,
          inactiveBgColor: context.theme.colorScheme.tertiary,
          inactiveFgColor: context.theme.colorScheme.onTertiary,
          totalSwitches: ReciveTheme.values.length,
          animationDuration: 100,
          labels: ReciveTheme.values.map((e) => e.name.capitalize()).toList(),
          animate: true,
          onToggle: (index) {
            final val = index ?? 0;
            themeBloc.switchTheme(val);
          },
        ),
      ],
    );
  }
}
