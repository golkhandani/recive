import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';

import 'package:recive/core/components/card_container.dart';
import 'package:recive/core/components/screen_safe_area_header.dart';
import 'package:recive/core/enums/loading_state.dart';
import 'package:recive/modules/bookmarks_page/bookmarks_screen.dart';
import 'package:recive/modules/bookmarks_page/cubits/bookmarks_cubit.dart';
import 'package:recive/modules/introduction_page/cubits/setting_loader_cubit.dart';
import 'package:recive/modules/login_page/cubits/login_cubit.dart';
import 'package:recive/modules/login_page/login_screen.dart';
import 'package:recive/modules/profile/models/user_custom_data.dart';
import 'package:recive/modules/profile/widgets/comming_soon.dart';
import 'package:recive/modules/profile/widgets/profile_bookmarks_count.dart';
import 'package:recive/modules/profile/widgets/profile_pinned_header.dart';
import 'package:recive/modules/profile/widgets/setting_delete_account.dart';
import 'package:recive/modules/profile/widgets/setting_intro_review.dart';
import 'package:recive/modules/profile/widgets/setting_theme_selector.dart';
import 'package:recive/shared/constants/ui_constants.dart';
import 'package:recive/shared/extensions/context_ui_extension.dart';
import 'package:recive/shared/extensions/text_style_extension.dart';
import 'package:recive/shared/ioc/locator.dart';
import 'package:recive/shared/services/navigation_service.dart';
import 'package:recive/shared/services/realm_service.dart';
import 'package:recive/shared/utils/hooks.dart';
import 'package:recive/shared/utils/theme_cubit.dart';

class ProfileScreen extends StatefulHook {
  static const name = 'profile';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final navigationService = locator.get<NavigationService>();
  final currentUser = locator.get<RealmApplicationService>().currentUser;
  late final customData = UserCustomData.fromJson(currentUser?.customData ?? {});

  @override
  Widget build(BuildContext context) {
    final bloc = useBloc<LoginCubit>();
    final state = useBlocBuilder(bloc);

    final bookmarksBloc = context.read<BookmarksCubit>();
    final bookmarksState = useBlocBuilder(bookmarksBloc);

    final themeBloc = context.read<ReciveThemeCubit>();
    final theme = useBlocBuilder(themeBloc);

    final settingbloc = useBloc<SettingLoaderCubit>();
    final setting = useBlocBuilder(settingbloc);

    useEffect(() {
      settingbloc.loadSetting();
      bookmarksBloc.loadBookmarks();
      return;
    }, [bookmarksState.count]);
    return ColoredBox(
      color: context.colorTheme.background,
      child: CustomScrollView(
        slivers: [
          const ScreenSafeAreaHeader(title: 'Profile', elevation: false),
          SliverPinnedHeader(
            child: ProfilePinnedHeader(
              profileImageUrl: customData.imageUrl,
              profileName: customData.name,
              isLoading: state.logoutLoadingState == LoadingState.loading,
              onLogout: () => bloc.logout(
                onSuccess: () => navigationService.logoutTo(LoginScreen.name),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: kTinyPadding.horizontal / 2),
            sliver: SliverToBoxAdapter(
              child: CardContainer(
                color: context.colorTheme.cardBackground,
                borderRadius: kMediumBorderRadius,
                padding: kTinyPadding,
                constraints: BoxConstraints(
                  maxHeight: context.vHeight - 460,
                  maxWidth: double.infinity,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 12),
                    SettingThemeSelector(
                      selectedTheme: theme,
                      onThemeChanged: themeBloc.switchTheme,
                    ),
                    const SizedBox(height: 12),
                    SettingIntroReview(
                      isIntroViewed: setting.isIntroViewed,
                      onIntroViewedChanged: settingbloc.switchIntroSetting,
                    ),
                    const SizedBox(height: 12),
                    ProfileBookmarksCount(
                      count: bookmarksState.count,
                      isLoading: bookmarksState.loadingState == LoadingState.loading,
                      onCountClicked: () => navigationService.pushTo(BookmarksScreen.name),
                    ),
                    const Spacer(),
                    const CommingSoon(),
                    const Spacer(),
                    SettingDeleteAccount(
                      isLoading: state.logoutLoadingState == LoadingState.loading,
                      onAccountDeleted: () => bloc.deleteAccount(
                        onSuccess: () async => await navigationService.logoutTo(LoginScreen.name),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
