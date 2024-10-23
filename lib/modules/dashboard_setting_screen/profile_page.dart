import 'dart:math';

import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/extensions/context_ui_extension.dart';
import 'package:art_for_all/core/ioc/locator.dart';
import 'package:art_for_all/core/models/art_abstract_model.dart';
import 'package:art_for_all/core/theme/theme.dart';
import 'package:art_for_all/core/theme/theme_cubit.dart';
import 'package:art_for_all/modules/auth_screen/auth_bloc.dart';
import 'package:art_for_all/modules/dashboard_setting_screen/profile_bloc.dart';
import 'package:art_for_all/utils/afa_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  static String name = 'ProfileScreen';
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

  @override
  Widget build(BuildContext context) {
    final Widget header = Container(
      decoration: BoxDecoration(
        color: context.colorTheme.primaryContainer,
        border: Border(
          bottom: kExtraTinyBorder.copyWith(
            color: context.colorTheme.onPrimaryContainer,
          ),
        ),
      ),
      padding: EdgeInsets.only(top: context.vTopSafeHeight),
      child: Material(
        color: context.colorTheme.primaryContainer,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            'Build your artistic character!',
            style: context.typographyTheme.titleSmall.textStyle.copyWith(
              color: context.colorTheme.onPrimaryContainer,
            ),
          ),
        ),
      ),
    );
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
        return CustomScrollView(
          slivers: [
            PinnedHeaderSliver(child: header),
            SliverFillRemaining(
              hasScrollBody: false,
              fillOverscroll: true,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(kMediumPadding.bottom),
                    Align(
                      alignment: Alignment.topCenter,
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
                        child: Material(
                          elevation: 10,
                          borderRadius: BorderRadius.circular(100),
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
                    ),
                    Gap(kLargePadding.bottom),
                    TextField(
                      controller: emailController,
                      style: context.typographyTheme.bodyMedium.onBackground.textStyle,
                      enabled: false,
                    ),
                    Gap(kMediumPadding.bottom),
                    Row(children: <Widget>[
                      const Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "CHARACTER",
                          style: context.typographyTheme.hint.onBackground.textStyle,
                        ),
                      ),
                      const Expanded(child: Divider()),
                    ]),
                    Gap(kMediumPadding.bottom),
                    Text(
                      'Name',
                      style: context.typographyTheme.subtitleMedium.onBackground.textStyle,
                    ),
                    const Gap(4),
                    TextField(
                      style: context.typographyTheme.bodyMedium.onBackground.textStyle,
                      onTapOutside: (v) {
                        FocusScope.of(context).unfocus();
                      },
                      controller: nameController,
                      enabled: true,
                      onChanged: (name) {
                        profileBloc.updateName(name);
                      },
                    ),
                    Gap(kMediumPadding.bottom),
                    BlocBuilder<ThemeCubit, ThemeCubitState>(
                      builder: (context, state) {
                        return Row(
                          children: [
                            Gap(kSmallPadding.left),
                            Text(
                              "You want it darker?",
                              style: context
                                  .typographyTheme.subtitleLarge.onBackground.textStyle,
                            ),
                            const Spacer(),
                            Switch(
                                value: state == ThemeCubitState.dark,
                                inactiveThumbColor: Colors.black,
                                inactiveTrackColor: Colors.white,
                                activeColor: Colors.white,
                                activeTrackColor: Colors.black,
                                trackOutlineColor: const WidgetStatePropertyAll(Colors.black),
                                onChanged: (v) {
                                  themeBloc.switchTheme(
                                    state == ThemeCubitState.dark
                                        ? ThemeCubitState.light
                                        : ThemeCubitState.dark,
                                  );
                                })
                          ],
                        );
                      },
                    ),
                    Gap(kMediumPadding.bottom),
                    const Spacer(),
                    BlocBuilder<AuthBloc, AuthBlocState>(
                      bloc: authBloc,
                      builder: (context, state) {
                        return Column(
                          children: [
                            AFAElevatedButton(
                              background: context.colorTheme.error,
                              foreground: context.colorTheme.onError,
                              constraints: const BoxConstraints.expand(height: 48),
                              onPressed: () {
                                authBloc.logout();
                              },
                              child: state.isLoading
                                  ? const CircularProgressIndicator()
                                  : const Text("Logout"),
                            ),
                            Gap(kMediumPadding.bottom),
                            AFAElevatedButton(
                              background: context.colorTheme.error,
                              foreground: context.colorTheme.onError,
                              constraints: const BoxConstraints.expand(height: 48),
                              onPressed: () async {
                                final confirmed = await showDialog<bool>(
                                  context: context,
                                  builder: (BuildContext context) => AlertDialog(
                                    title: const Text('Are you leaving us?!'),
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
                                          style: context.typographyTheme.onSuccess.textStyle,
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
            )
            // ItemList(items: state.featuredArts),
          ],
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
