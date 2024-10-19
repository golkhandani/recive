import 'package:art_for_all/core/ioc/locator.dart';
import 'package:art_for_all/modules/dashboard_screen.dart';
import 'package:art_for_all/core/services/navigation_service.dart';
import 'package:art_for_all/core/theme/context_extensions.dart';
import 'package:art_for_all/core/theme/theme_decorations.dart';
import 'package:art_for_all/core/theme/typography_extensions.dart';
import 'package:art_for_all/modules/auth_screen/auth_bloc.dart';
import 'package:art_for_all/modules/auth_screen/register_page.dart';
import 'package:art_for_all/utils/afa_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_validator/form_validator.dart';

import 'package:gap/gap.dart';

class LoginScreen extends StatefulWidget {
  static String name = 'LoginScreen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final bloc = locator.get<AuthBloc>();
  final NavigationService navigationService = locator.get();
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

  void _login() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    bloc.loginWithEmail(
      email: _emailController.text,
      password: _passwordController.text,
      onSuccess: _goToDashboard,
      onFailure: () {},
    );
  }

  void _goToDashboard() {
    context.neglectNamed(DashboardScreen.name);
  }

  void _goToRegister() {
    navigationService.moveTo(RegisterScreen.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthBlocState>(
        bloc: bloc,
        builder: (context, state) {
          return SingleChildScrollView(
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
                        style: context.typographyTheme.titleMedium.onSurface.textStyle,
                      ),
                    ),
                    const Gap(64),
                    Text(
                      'Email',
                      style: context.typographyTheme.subtitleMedium.onBackground.textStyle,
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
                      style: context.typographyTheme.subtitleMedium.onBackground.textStyle,
                    ),
                    const Gap(4),
                    FormBuilderTextField(
                      name: 'password_field',
                      style: context.typographyTheme.bodyMedium.onBackground.textStyle,
                      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                      controller: _passwordController,
                      maxLines: 1,
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
                      keyboardType: TextInputType.text,
                      obscureText: _obscurePassword,
                      validator: ValidationBuilder().minLength(8).maxLength(16).build(),
                    ),
                    const Gap(16),
                    AFAElevatedButton(
                      width: MediaQuery.sizeOf(context).width,
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        state.isLoading ? null : _login();
                      },
                      child: state.isLoading
                          ? const CircularProgressIndicator()
                          : Text(
                              'Login',
                              style: context
                                  .typographyTheme.subtitleMedium.onBackground.textStyle,
                            ),
                    ),
                    const Gap(32),
                    Row(children: <Widget>[
                      const Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "OR",
                          style: context.typographyTheme.hint.onBackground.textStyle,
                        ),
                      ),
                      const Expanded(child: Divider()),
                    ]),
                    const Gap(32),
                    AFAElevatedButton(
                      width: MediaQuery.sizeOf(context).width,
                      padding: EdgeInsets.zero,
                      background: context.colorTheme.onPrimaryContainer,
                      onPressed: () {
                        state.isLoading ? null : _goToRegister();
                      },
                      child: state.isLoading
                          ? const CircularProgressIndicator()
                          : Text(
                              'Register',
                              style: context
                                  .typographyTheme.subtitleMedium.primaryContainer.textStyle,
                            ),
                    ),
                    const Gap(16),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
