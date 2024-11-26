import 'dart:math';

import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/extensions/context_ui_extension.dart';
import 'package:art_for_all/core/ioc/locator.dart';
import 'package:art_for_all/core/models/art_abstract_model.dart';
import 'package:art_for_all/core/services/navigation_service.dart';
import 'package:art_for_all/core/theme/theme.dart';
import 'package:art_for_all/core/theme/theme_cubit.dart';
import 'package:art_for_all/modules/auth_screen/auth_bloc.dart';
import 'package:art_for_all/modules/auth_screen/login_page.dart';
import 'package:art_for_all/modules/auth_screen/register_page.dart';
import 'package:art_for_all/modules/dashboard_setting_screen/profile_bloc.dart';
import 'package:art_for_all/utils/afa_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  static String name = 'settings';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final authBloc = locator.get<AuthBloc>();
  late final profileBloc = BlocProvider.of<ProfileBloc>(context);
  late final themeBloc = BlocProvider.of<ThemeCubit>(context);
  late final emailController = TextEditingController(text: profileBloc.state.user?.email);
  late final nameController = TextEditingController(text: profileBloc.state.user?.name);
  final NavigationService navigationService = locator.get();
  void _goToLogin() {
    navigationService.moveTo(LoginScreen.name);
  }

  void _goToRegister() {
    navigationService.moveTo(RegisterScreen.name);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileBlocState>(
      listener: (context, state) {
        if (state.user == null) {
          return;
        }
        emailController.text = state.user!.email;
        if (nameController.text != state.user!.name) {
          nameController.text = state.user!.name;
        }
      },
      bloc: profileBloc,
      builder: (context, state) {
        if (state.user == null) {
          return SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Gap(kMediumPadding.bottom),
                Text(
                  "Please Login or Register\n to access your profile",
                  style: context.typographyTheme.onBackground.textStyle,
                ),
                const Gap(64),
                ClipRRect(
                  borderRadius: kMediumBorderRadius,
                  child: Image.asset(
                    'assets/app_icon.png',
                    width: context.vWidth / 2,
                    height: context.vWidth / 2,
                  ),
                ),
                Gap(kMediumPadding.bottom),
                BlocBuilder<ThemeCubit, ThemeCubitState>(
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Gap(kSmallPadding.left),
                        Text(
                          "Theme",
                          style: context.typographyTheme.subtitleLarge.onBackground.textStyle,
                        ),
                        Gap(kSmallPadding.left),
                        ThemeSwitch(
                          currentTheme: state,
                          onThemeChanged: (ThemeCubitState mode) {
                            themeBloc.switchTheme(mode);
                          },
                        ),
                        // Switch(
                        //     value: state == ThemeCubitState.dark,
                        //     inactiveThumbColor: context.colorTheme.primary,
                        //     inactiveTrackColor: context.colorTheme.onBackground,
                        //     activeColor: context.colorTheme.primary,
                        //     activeTrackColor: context.colorTheme.onBackground,
                        //     trackOutlineColor: const WidgetStatePropertyAll(Colors.black),
                        //     onChanged: (v) {
                        //       themeBloc.switchTheme(
                        //         state == ThemeCubitState.dark
                        //             ? ThemeCubitState.light
                        //             : ThemeCubitState.dark,
                        //       );
                        //     })
                      ],
                    );
                  },
                ),
                const Gap(64),
                Align(
                  alignment: Alignment.center,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(text: 'Don\'t have an account?\n'),
                        TextSpan(
                          text: 'Register',
                          style: context.typographyTheme.primary.textStyle,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              state.isLoading ? null : _goToRegister();
                            },
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    style: context.typographyTheme.onBackground.textStyle,
                  ),
                ),
                const Gap(16),
                Align(
                  alignment: Alignment.center,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(text: 'You have an account?\n'),
                        TextSpan(
                          text: 'Login',
                          style: context.typographyTheme.primary.textStyle,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              state.isLoading ? null : _goToLogin();
                            },
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    style: context.typographyTheme.onBackground.textStyle,
                  ),
                ),
                Gap(kMediumPadding.bottom),
              ],
            ),
          );
        }
        return NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                scrolledUnderElevation: 1,
                expandedHeight: 210,
                collapsedHeight: kToolbarHeight,
                pinned: true,
                title: Text(
                  'Profile',
                  style: context.typographyTheme.titleSmall.textStyle.copyWith(
                    color: context.colorTheme.onPrimaryContainer,
                  ),
                ),
                flexibleSpace: Container(
                  margin: EdgeInsets.only(
                    top: context.vTopSafeHeight + kToolbarHeight,
                    bottom: kMediumPadding.bottom,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: () async {
                            final ImagePicker picker = ImagePicker();
                            final XFile? image = await picker.pickImage(
                              source: ImageSource.gallery,
                              maxHeight: 480,
                              maxWidth: 640,
                              imageQuality: 50,
                            );
                            if (image == null) {
                              return;
                            }
                            profileBloc.uploadAvatar(image.path);
                          },
                          child: CircleAvatar(
                            backgroundColor: context.colorTheme.primaryContainer,
                            radius: min(context.vWidth / 5, 64),
                            foregroundImage: (state.user?.imageUrl.isEmpty ?? true)
                                ? null
                                : NetworkImage(state.user!.imageUrl),
                            child: (state.user?.imageUrl.isEmpty ?? state.isLoading)
                                ? const Icon(Icons.upload)
                                : state.isLoadingImage
                                    ? const CircularProgressIndicator()
                                    : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              SliverMainAxisGroup(slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    margin: kMediumPadding.copyWith(bottom: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'Account information',
                            style:
                                context.typographyTheme.subtitleLarge.onBackground.textStyle,
                          ),
                        ),
                        Gap(kMediumPadding.bottom),
                        Text(
                          'Email',
                          style:
                              context.typographyTheme.subtitleMedium.onBackground.textStyle,
                        ),
                        Gap(kExtraTinyPadding.bottom),
                        TextField(
                          controller: emailController,
                          style: context.typographyTheme.bodyMedium.onBackground.textStyle,
                          decoration: context.themeData.inputDecoration,
                          enabled: false,
                        ),
                        Gap(kExtraTinyPadding.bottom),
                        Text(
                          'Name',
                          style:
                              context.typographyTheme.subtitleMedium.onBackground.textStyle,
                        ),
                        Gap(kExtraTinyPadding.bottom),
                        TextField(
                          style: context.typographyTheme.bodyMedium.onBackground.textStyle,
                          onTapOutside: (v) {
                            FocusScope.of(context).unfocus();
                          },
                          decoration: context.themeData.inputDecoration,
                          controller: nameController,
                          enabled: true,
                          onChanged: (name) {
                            profileBloc.updateName(name);
                          },
                        ),
                        Gap(kExtraTinyPadding.bottom),
                        const Divider(),
                      ],
                    ),
                  ),
                ),
              ]),
              SliverMainAxisGroup(slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    margin: kMediumPadding.copyWith(bottom: 0, top: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(kExtraTinyPadding.bottom),
                        Center(
                          child: Text(
                            'Apperance',
                            style:
                                context.typographyTheme.subtitleLarge.onBackground.textStyle,
                          ),
                        ),
                        Gap(kMediumPadding.bottom),
                        BlocBuilder<ThemeCubit, ThemeCubitState>(
                          builder: (context, state) {
                            return Row(
                              children: [
                                Text(
                                  "Theme",
                                  style: context
                                      .typographyTheme.subtitleMedium.onBackground.textStyle,
                                ),
                                const Spacer(),
                                ThemeSwitch(
                                  currentTheme: state,
                                  onThemeChanged: (ThemeCubitState mode) {
                                    themeBloc.switchTheme(mode);
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                        Gap(kExtraTinyPadding.bottom),
                        const Divider(),
                      ],
                    ),
                  ),
                ),
              ]),
              SliverMainAxisGroup(slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    margin: kMediumPadding.copyWith(bottom: 0, top: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(kExtraTinyPadding.bottom),
                        Center(
                          child: Text(
                            'FAQ',
                            style:
                                context.typographyTheme.subtitleLarge.onBackground.textStyle,
                          ),
                        ),
                        Gap(kMediumPadding.bottom),
                        Row(
                          children: [
                            Text(
                              "Find a problem or have a feedback?",
                              style: context
                                  .typographyTheme.subtitleMedium.onBackground.textStyle,
                            ),
                            const Spacer(),
                            TextButton(
                              style: ButtonStyle(
                                foregroundColor:
                                    WidgetStateProperty.all(context.colorTheme.primary),
                              ),
                              onPressed: () async {
                                final style = context.typographyTheme.onBackground.textStyle;
                                final confirmed = await showDialog<bool>(
                                  context: context,
                                  builder: (BuildContext context) => AlertDialog(
                                    backgroundColor: context.colorTheme.background,
                                    contentTextStyle: style,
                                    title: Text('Are you having a problem?!', style: style),
                                    content: IntrinsicHeight(
                                      child: Column(
                                        children: [
                                          const Text(
                                              'Let us know and we will do our best to solve it!'),
                                          Gap(kMediumPadding.bottom),
                                          Expanded(
                                            child: TextField(
                                              maxLines: 4,
                                              style: context.typographyTheme.bodyMedium
                                                  .onBackground.textStyle,
                                              decoration:
                                                  context.themeData.inputDecoration.copyWith(
                                                contentPadding: kMediumPadding,
                                                enabledBorder: context
                                                    .themeData.inputDecoration.enabledBorder!
                                                    .copyWith(
                                                  borderSide:
                                                      const BorderSide(color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    actionsAlignment: MainAxisAlignment.spaceBetween,
                                    actions: <Widget>[
                                      AFAElevatedButton(
                                        background: context.colorTheme.warning,
                                        foreground: context.colorTheme.onWarning,
                                        constraints: const BoxConstraints.expand(height: 48),
                                        onPressed: () {},
                                        child: state.isLoading
                                            ? const CircularProgressIndicator()
                                            : const Text("Submit"),
                                      ),
                                    ],
                                  ),
                                );

                                if (confirmed == true) {
                                  authBloc.logout();
                                }
                              },
                              child: state.isLoading
                                  ? const CircularProgressIndicator()
                                  : const Text("Report Issue"),
                            ),
                          ],
                        ),
                        Gap(kExtraTinyPadding.bottom),
                        const Divider(),
                      ],
                    ),
                  ),
                ),
              ]),
              SliverMainAxisGroup(slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    margin: kMediumPadding.copyWith(bottom: 0, top: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(kExtraTinyPadding.bottom),
                        Center(
                          child: Text(
                            'Account management',
                            style:
                                context.typographyTheme.subtitleLarge.onBackground.textStyle,
                          ),
                        ),
                        Gap(kMediumPadding.bottom),
                        BlocBuilder<AuthBloc, AuthBlocState>(
                          bloc: authBloc,
                          builder: (context, state) {
                            return Column(
                              children: [
                                AFAElevatedButton(
                                  background: context.colorTheme.warning,
                                  foreground: context.colorTheme.onWarning,
                                  constraints: const BoxConstraints.expand(height: 48),
                                  onPressed: () {
                                    authBloc.logout();
                                  },
                                  child: state.isLoading
                                      ? const CircularProgressIndicator()
                                      : const Text("Logout"),
                                ),
                                Gap(kMediumPadding.bottom),
                                TextButton(
                                  style: ButtonStyle(
                                    foregroundColor:
                                        WidgetStateProperty.all(context.colorTheme.primary),
                                  ),
                                  onPressed: () async {
                                    final style =
                                        context.typographyTheme.onBackground.textStyle;
                                    final confirmed = await showDialog<bool>(
                                      context: context,
                                      builder: (BuildContext context) => AlertDialog(
                                        backgroundColor: context.colorTheme.background,
                                        contentTextStyle: style,
                                        title: Text('Are you leaving us?!', style: style),
                                        content: const Text(
                                            'Be careful, all your data will be deleted!'),
                                        actionsAlignment: MainAxisAlignment.spaceBetween,
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => Navigator.pop(context, true),
                                            child: Text(
                                              'YES',
                                              style: context.typographyTheme.error.textStyle,
                                            ),
                                          ),
                                          AFAElevatedButton(
                                            background: context.colorTheme.success,
                                            onPressed: () => Navigator.pop(context, false),
                                            child: Text(
                                              'NO',
                                              style:
                                                  context.typographyTheme.onSuccess.textStyle,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );

                                    if (confirmed == true) {
                                      authBloc.logout();
                                    }
                                  },
                                  child: state.isLoading
                                      ? const CircularProgressIndicator()
                                      : const Text("Delete Account"),
                                ),
                              ],
                            );
                          },
                        ),
                        Gap(kMediumPadding.bottom),
                      ],
                    ),
                  ),
                ),
              ]),
            ],
          ),
        );
      },
    );
  }
}

class ItemList extends StatelessWidget {
  const ItemList({
    super.key,
    this.items = const [],
  });

  final List<ArtAbstractModel> items;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final item = items[index];
          return Card(
            color: colorScheme.onSecondary,
            child: ListTile(
              textColor: colorScheme.secondary,
              title: Text(item.title),
            ),
          );
        },
        childCount: items.length,
      ),
    );
  }
}

class ThemeSwitch extends StatelessWidget {
  final ThemeCubitState currentTheme;
  final ValueChanged<ThemeCubitState> onThemeChanged;

  const ThemeSwitch({
    super.key,
    required this.currentTheme,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final style = context.typographyTheme.bodyMedium.onBackground.textStyle;
    return ToggleButtons(
      highlightColor: Colors.green,
      color: Colors.amber,
      selectedColor: Colors.amber,
      borderRadius: kSmallBorderRadius,
      fillColor: context.colorTheme.primary,
      borderWidth: 0,
      borderColor: context.colorTheme.onBackground,
      renderBorder: true,
      isSelected: [
        currentTheme == ThemeCubitState.light,
        currentTheme == ThemeCubitState.dark,
        currentTheme == ThemeCubitState.system,
      ],
      onPressed: (index) {
        ThemeCubitState selectedTheme;
        switch (index) {
          case 0:
            selectedTheme = ThemeCubitState.light;
            break;
          case 1:
            selectedTheme = ThemeCubitState.dark;
            break;
          case 2:
          default:
            selectedTheme = ThemeCubitState.system;
            break;
        }
        onThemeChanged(selectedTheme);
      },
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text("Light", style: style),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text("Dark", style: style),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text("System", style: style),
        ),
      ],
    );
  }
}
