import 'package:art_for_all/core/ioc/locator.dart';
import 'package:art_for_all/core/services/navigation_service.dart';
import 'package:art_for_all/core/theme/context_extensions.dart';
import 'package:art_for_all/core/theme/theme_decorations.dart';
import 'package:art_for_all/core/theme/typography_extensions.dart';
import 'package:art_for_all/modules/auth_screen/auth_bloc.dart';
import 'package:art_for_all/modules/dashboard_home_screen/featured_art_page.dart';
import 'package:art_for_all/utils/afa_button.dart';
import 'package:art_for_all/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_validator/form_validator.dart';

import 'package:gap/gap.dart';

class ResetPasswordPage extends StatefulWidget {
  static String name = 'reset-password';
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final bloc = locator.get<AuthBloc>();
  final NavigationService navigationService = locator.get();
  final _formKey = GlobalKey<FormBuilderState>();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
  }

  void _updatePassword() {
    bloc.resetPassword(
      password: _passwordController.text.trim(),
      onSuccess: () {
        context.neglectNamed(HomeScreen.name);
      },
      onFailure: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<AuthBloc, AuthBlocState>(
        bloc: bloc,
        builder: (context, state) {
          return AbsorbPointer(
            absorbing: state.isLoading,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Opacity(
                    opacity: 0.1,
                    child: AssetsLoader.background,
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: Text(
                    'Photo by Masaru Suzuki on Unsplash',
                    style: context.typographyTheme.onBackground.subtitleTiny.textStyle,
                  ),
                ),
                Positioned.fill(
                  child: SingleChildScrollView(
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Padding(
                      padding: const EdgeInsets.all(16).copyWith(top: 64),
                      child: FormBuilder(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.disabled,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                'Welcome',
                                style:
                                    context.typographyTheme.titleMedium.onSurface.textStyle,
                              ),
                            ),
                            const Gap(16),
                            Text(
                              'Password',
                              style: context
                                  .typographyTheme.subtitleMedium.onBackground.textStyle,
                            ),
                            const Gap(4),
                            FormBuilderTextField(
                              name: 'password_field',
                              style:
                                  context.typographyTheme.bodyMedium.onBackground.textStyle,
                              onTapOutside: (_) =>
                                  FocusManager.instance.primaryFocus?.unfocus(),
                              controller: _passwordController,
                              decoration: context.themeData.inputDecoration.copyWith(
                                suffix: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                  child: Icon(
                                    _obscurePassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    size: 16,
                                    color: context.colorTheme.onSurface,
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: _obscurePassword,
                              validator:
                                  ValidationBuilder().minLength(8).maxLength(16).build(),
                            ),
                            const Gap(16),
                            Text(
                              'Repeat Password',
                              style: context
                                  .typographyTheme.subtitleMedium.onBackground.textStyle,
                            ),
                            const Gap(4),
                            FormBuilderTextField(
                              name: 'password_confirmation_field',
                              style:
                                  context.typographyTheme.bodyMedium.onBackground.textStyle,
                              onTapOutside: (_) =>
                                  FocusManager.instance.primaryFocus?.unfocus(),
                              controller: _passwordConfirmationController,
                              decoration: context.themeData.inputDecoration.copyWith(
                                suffix: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                  child: Icon(
                                    _obscurePassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: context.colorTheme.onSurface,
                                    size: 16,
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: _obscurePassword,
                              validator: (value) {
                                if (_formKey.currentState?.fields['password_field']?.value !=
                                    value) {
                                  return 'Password Confirmation does not match!';
                                }
                                return null;
                              },
                            ),
                            const Gap(42),
                            AFAElevatedButton(
                              width: MediaQuery.sizeOf(context).width,
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                state.isLoading ? null : _updatePassword();
                              },
                              child: state.isLoading
                                  ? const CircularProgressIndicator()
                                  : Text(
                                      'Register',
                                      style: context
                                          .typographyTheme.subtitleMedium.onPrimary.textStyle,
                                    ),
                            ),
                            const Gap(16),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
