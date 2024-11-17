import 'package:art_for_all/core/ioc/locator.dart';
import 'package:art_for_all/core/services/navigation_service.dart';
import 'package:art_for_all/core/theme/theme.dart';
import 'package:art_for_all/modules/auth_screen/auth_bloc.dart';
import 'package:art_for_all/modules/auth_screen/login_page.dart';
import 'package:art_for_all/utils/afa_button.dart';
import 'package:art_for_all/utils/assets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_validator/form_validator.dart';
import 'package:gap/gap.dart';

class RegisterScreen extends StatefulWidget {
  static String name = 'register';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final bloc = locator.get<AuthBloc>();
  final _formKey = GlobalKey<FormBuilderState>();

  final TextEditingController _emailController = TextEditingController();
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
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
  }

  void _register() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    bloc.registerWithEmail(
      email: _emailController.text,
      password: _passwordController.text,
      onSuccess: _goToLogin,
      onFailure: () {},
    );
  }

  void _goToLogin() {
    context.neglectNamed(LoginScreen.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<AuthBloc, AuthBlocState>(
      bloc: bloc,
      builder: (context, state) {
        return Stack(
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
                            style: context.typographyTheme.titleMedium.onBackground.textStyle,
                          ),
                        ),
                        const Gap(16),
                        Text(
                          'Email',
                          style:
                              context.typographyTheme.subtitleMedium.onBackground.textStyle,
                        ),
                        const Gap(4),
                        FormBuilderTextField(
                          name: 'email_field',
                          style: context.typographyTheme.bodyMedium.onBackground.textStyle,
                          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                          controller: _emailController,
                          decoration: context.themeData.inputDecoration,
                          keyboardType: TextInputType.emailAddress,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.email(),
                          ]),
                        ),
                        const Gap(8),
                        Text(
                          'Password',
                          style:
                              context.typographyTheme.subtitleMedium.onBackground.textStyle,
                        ),
                        const Gap(4),
                        FormBuilderTextField(
                          name: 'password_field',
                          style: context.typographyTheme.bodyMedium.onBackground.textStyle,
                          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                          controller: _passwordController,
                          decoration: context.themeData.inputDecoration.copyWith(
                            suffix: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                              child: Icon(
                                _obscurePassword ? Icons.visibility : Icons.visibility_off,
                                size: 16,
                                color: context.colorTheme.onSurface,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: _obscurePassword,
                          validator: ValidationBuilder().minLength(8).maxLength(16).build(),
                        ),
                        const Gap(16),
                        Text(
                          'Repeat Password',
                          style:
                              context.typographyTheme.subtitleMedium.onBackground.textStyle,
                        ),
                        const Gap(4),
                        FormBuilderTextField(
                          name: 'password_confirmation_field',
                          style: context.typographyTheme.bodyMedium.onBackground.textStyle,
                          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                          controller: _passwordConfirmationController,
                          decoration: context.themeData.inputDecoration.copyWith(
                            suffix: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                              child: Icon(
                                _obscurePassword ? Icons.visibility : Icons.visibility_off,
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
                            state.isLoading ? null : _register();
                          },
                          child: state.isLoading
                              ? const CircularProgressIndicator()
                              : Text(
                                  'Register',
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
                        const Gap(16),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ));
  }
}
