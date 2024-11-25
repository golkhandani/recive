import 'package:art_for_all/core/ioc/locator.dart';
import 'package:art_for_all/core/services/navigation_service.dart';
import 'package:art_for_all/core/theme/context_extensions.dart';
import 'package:art_for_all/core/theme/theme_decorations.dart';
import 'package:art_for_all/core/theme/typography_extensions.dart';
import 'package:art_for_all/modules/auth_screen/auth_bloc.dart';
import 'package:art_for_all/modules/auth_screen/login_page.dart';
import 'package:art_for_all/modules/auth_screen/register_page.dart';
import 'package:art_for_all/modules/auth_screen/reset_password_page.dart';
import 'package:art_for_all/utils/afa_button.dart';
import 'package:art_for_all/utils/assets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_validator/form_validator.dart';

import 'package:gap/gap.dart';

class ResetPasswordCodePage extends StatefulWidget {
  static String name = 'reset-password-code';
  const ResetPasswordCodePage({
    super.key,
  });

  @override
  State<ResetPasswordCodePage> createState() => _ResetPasswordCodePageState();
}

class _ResetPasswordCodePageState extends State<ResetPasswordCodePage> {
  final bloc = locator.get<AuthBloc>();
  final NavigationService navigationService = locator.get();
  final _formKey = GlobalKey<FormBuilderState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _codeController = TextEditingController();

  bool _showCodeInput = false;

  @override
  void initState() {
    super.initState();
  }

  void _resetPasswordRequest() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    bloc.resetPasswordRequest(
      email: _emailController.text,
      onSuccess: () {
        setState(() {
          _showCodeInput = true;
        });
      },
      onFailure: () {},
    );
  }

  @override
  void dispose() {
    super.dispose();
    _codeController.dispose();
  }

  void _goToRegister() {
    navigationService.moveTo(RegisterScreen.name);
  }

  void _goToLogin() {
    navigationService.moveTo(LoginScreen.name);
  }

  void _checkCode() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    bloc.resetPasswordCode(
      email: _emailController.text.trim(),
      code: _codeController.text.trim(),
      onSuccess: () {
        navigationService.moveTo(ResetPasswordPage.name);
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
                    opacity: 0.05,
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
                              child: SizedBox(
                                width: 64,
                                height: 64,
                                child: Opacity(
                                  opacity: 1,
                                  child: AssetsLoader.appSplash,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                'Welcome',
                                style:
                                    context.typographyTheme.titleMedium.onSurface.textStyle,
                              ),
                            ),
                            const Gap(16),
                            Text(
                              'Email',
                              style: context
                                  .typographyTheme.subtitleMedium.onBackground.textStyle,
                            ),
                            const Gap(4),
                            FormBuilderTextField(
                              name: 'email_field',
                              style:
                                  context.typographyTheme.bodyMedium.onBackground.textStyle,
                              onTapOutside: (_) =>
                                  FocusManager.instance.primaryFocus?.unfocus(),
                              controller: _emailController,
                              decoration: context.themeData.inputDecoration,
                              keyboardType: TextInputType.emailAddress,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                                FormBuilderValidators.email(),
                              ]),
                            ),
                            const Gap(8),
                            if (_showCodeInput) ...[
                              Text(
                                'Code',
                                style: context
                                    .typographyTheme.subtitleMedium.onBackground.textStyle,
                              ),
                              const Gap(4),
                              FormBuilderTextField(
                                name: 'code_field',
                                style:
                                    context.typographyTheme.bodyMedium.onBackground.textStyle,
                                onTapOutside: (_) =>
                                    FocusManager.instance.primaryFocus?.unfocus(),
                                controller: _codeController,
                                decoration: context.themeData.inputDecoration,
                                keyboardType: TextInputType.number,
                                validator:
                                    ValidationBuilder().minLength(6).maxLength(6).build(),
                              ),
                            ],
                            const Gap(42),
                            AFAElevatedButton(
                              width: MediaQuery.sizeOf(context).width,
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                state.isLoading
                                    ? null
                                    : _showCodeInput
                                        ? _checkCode()
                                        : _resetPasswordRequest();
                              },
                              child: state.isLoading
                                  ? const CircularProgressIndicator()
                                  : Text(
                                      _showCodeInput ? 'Verify Code' : 'Request Code',
                                      style: context
                                          .typographyTheme.subtitleMedium.onPrimary.textStyle,
                                    ),
                            ),
                            const Gap(64),
                            Align(
                              alignment: Alignment.center,
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Register',
                                      style: context.typographyTheme.primary.textStyle,
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          state.isLoading ? null : _goToRegister();
                                        },
                                    ),
                                    TextSpan(
                                      text: '  or  ',
                                      style: context.typographyTheme.onBackground.textStyle,
                                    ),
                                    TextSpan(
                                      text: 'Login!',
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
                            const Gap(32),
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
