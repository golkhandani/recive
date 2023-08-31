import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:recive/components/card_container.dart';
import 'package:recive/components/screen_safe_area_header.dart';
import 'package:recive/features/categories_page/models/category.dart';
import 'package:recive/features/login_page/cubits/login_cubit.dart';
import 'package:recive/features/login_page/login_screen.dart';
import 'package:recive/features/profile_page/models/user_custom_data.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/ioc/realm_service.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/router/navigation_service.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ProfileScreen extends HookWidget {
  static const name = 'profile';
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationService = locator.get<NavigationService>();
    final currentUser = locator.get<RealmApplicationService>().app.currentUser;
    final customData = UserCustomData.fromJson(currentUser?.customData ?? {});

    print("currentUser?.customData ${currentUser?.customData}");
    final bloc = useBloc<LoginCubit>();
    final state = useBlocBuilder(bloc);
    return ColoredBox(
      color: context.theme.colorScheme.background,
      child: LayoutBuilder(builder: (context, box) {
        return CustomScrollView(
          slivers: [
            ScreenSafeAreaHeader(
              color: context.theme.primaryColor,
              title: 'Profile',
            ),
            SliverPinnedHeader(
              child: ClipPath(
                clipper: SinCosineWaveClipper(
                  verticalPosition: VerticalPosition.bottom,
                  horizontalPosition: HorizontalPosition.right,
                ),
                child: Container(
                  height: 220,
                  color: context.theme.primaryColor,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 12,
                        right: 24,
                        child: CircleAvatar(
                          backgroundImage: customData.imageUrl != null
                              ? NetworkImage(customData.imageUrl!)
                              : null,
                          backgroundColor: Colors.grey,
                          radius: 72,
                        ),
                      ),
                      Positioned(
                        top: 24,
                        left: 24,
                        right: 72 * 2 + 24 + 12,
                        child: Text(
                          customData.name ?? '',
                          style: context.textTheme.titleMedium,
                        ),
                      ),
                      Positioned(
                        bottom: 64,
                        left: 24,
                        right: 72 * 2 + 24 + 12,
                        child: InkWell(
                          onTap: () => bloc.logout(
                            onSuccess: () async => await navigationService
                                .logoutTo(LoginScreen.name),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(12),
                            alignment: Alignment.center,
                            constraints: BoxConstraints.expand(height: 48),
                            decoration: ShapeDecoration(
                              color: context.theme.colorScheme.errorContainer,
                              shape: StadiumBorder(
                                side: BorderSide(
                                  width: 0,
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                            child:
                                state.logoutLoadingState == LoadingState.loading
                                    ? Center(
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
                                          context.theme.colorScheme
                                              .onErrorContainer,
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
              padding: const EdgeInsets.symmetric(horizontal: 12),
              sliver: MultiSliver(
                children: [
                  SliverToBoxAdapter(
                    child: CardContainer(
                      borderRadius: BorderRadius.circular(16),
                      padding: const EdgeInsets.all(12),
                      child: Container(
                        height: 400,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.yellowAccent,
                        ),
                        padding: EdgeInsets.all(12),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            InkWell(
                              onTap: () => bloc.deleteAccount(
                                onSuccess: () async => await navigationService
                                    .logoutTo(LoginScreen.name),
                              ),
                              child: Container(
                                padding: EdgeInsets.all(12),
                                alignment: Alignment.center,
                                constraints: BoxConstraints.expand(height: 48),
                                decoration: ShapeDecoration(
                                  color:
                                      context.theme.colorScheme.errorContainer,
                                  shape: StadiumBorder(
                                    side: BorderSide(
                                      width: 0,
                                      color: Colors.transparent,
                                    ),
                                  ),
                                ),
                                child: state.logoutLoadingState ==
                                        LoadingState.loading
                                    ? Center(
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
                            ),
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
}
