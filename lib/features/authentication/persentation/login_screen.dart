import 'package:flutter/material.dart';
import 'package:kontena_pos/app_state.dart';
import 'package:kontena_pos/core/api/frappe_thunder_authenticator/auth.dart'
    as frappeLogin;

import 'package:kontena_pos/core/api/frappe_thunder_authenticator/user_detail.dart'
    as frappeUserDetail;

import 'package:kontena_pos/widgets/custom_elevated_button.dart';
import 'package:kontena_pos/core/theme/theme_helper.dart';
import 'package:kontena_pos/widgets/custom_text_form_field.dart';
import 'package:kontena_pos/core/app_export.dart';
import 'package:kontena_pos/core/utils/alert.dart' as alert;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // late LoginScreen _model;
  final unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  String? Function(BuildContext, String?)? userFieldControllerValidator;

  @override
  void initState() {
    super.initState();
    // _model = createModel(context, () => LoginPageModel());

    // dynamic tmpOutlet = FFAppState().configSettingOutlet;
    // String tmpOuletCode = FFAppState().configSettingOutletCode;
    // dynamic tmpDevice = FFAppState().configSettingDevices;
    // dynamic tmpPrinter = FFAppState().configSettingPrinter;
    //
    // _model.settingValue = FFAppState().settingValue;
    // _model.settingOutlet = getJsonField(
    //                                     FFAppState().settingValue,
    //                                     r'''$.outlet''',
    //                                   );
    // _model.settingDevice = getJsonField(FFAppState().settingValue, r'''$.device''',);
    // _model.settingPrinter = getJsonField(FFAppState().settingValue, r'''$.printer''',);

    // userFieldController ??= TextEditingController();
    // pwFieldController ??= TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    // _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: theme.colorScheme.primaryContainer,
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(0.0, 60.0, 0.0, 60.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.2,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer,
                          border: Border.all(
                            color: theme.colorScheme.background,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                            30.0,
                            80.0,
                            30.0,
                            80.0,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/app_launcher_icon.png',
                                  height: 165.v,
                                  width: 165.v,
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Login',
                                      style: theme.textTheme.titleMedium,
                                    ),
                                    Text(
                                      'Masukkan username & password untuk melanjutkan',
                                      style: theme.textTheme.labelSmall,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                        0.0,
                                        16.0,
                                        0.0,
                                        16.0,
                                      ),
                                      child: Form(
                                        key: formKey,
                                        autovalidateMode:
                                            AutovalidateMode.disabled,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                0.0,
                                                0.0,
                                                0.0,
                                                16.0,
                                              ),
                                              child: _buildPhoneNumberSection(
                                                context,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                0.0,
                                                0.0,
                                                0.0,
                                                16.0,
                                              ),
                                              child: _buildPasswordSection(
                                                  context),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    if (isLoading)
                                      Container(
                                        width: double.infinity,
                                        height: 48.0,
                                        decoration: BoxDecoration(
                                          color: theme.colorScheme.primary,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  8.0, 0.0, 8.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Center(
                                                child: Container(
                                                  width: 23,
                                                  height: 23,
                                                  child:
                                                      CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                            Color>(
                                                      Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        10.0, 0.0, 8.0, 0.0),
                                                child: Text(
                                                  'Loading...',
                                                  style: TextStyle(
                                                      color: theme.colorScheme
                                                          .primaryContainer),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    if (isLoading == false)
                                      CustomElevatedButton(
                                        text: "Masuk",
                                        buttonTextStyle: TextStyle(
                                            color: theme
                                                .colorScheme.primaryContainer),
                                        buttonStyle:
                                            CustomButtonStyles.primaryButton,
                                        onPressed: () {
                                          onTapMasuk(context);
                                        },
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // widget input phone
  TextEditingController enterPhoneController = TextEditingController();
  FocusNode inputPhone = FocusNode();
  Widget _buildPhoneNumberSection(BuildContext context) {
    enterPhoneController.text = 'administrator';
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      CustomTextFormField(
        controller: enterPhoneController,
        focusNode: inputPhone,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 3.h,
          vertical: 12.v,
        ),
        hintText: "Masukin no hp / email mu",
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Nomor HP / Email tidak boleh kosong';
          }
          return null;
        },
        onTapOutside: (value) {
          inputPhone.unfocus();
        },
      ),
    ]);
  }

  // widget password
  TextEditingController enterPasswordController = TextEditingController();
  FocusNode inputPassword = FocusNode();
  late bool _obscurePassword = true;
  Widget _buildPasswordSection(BuildContext context) {
    enterPasswordController.text = 'adminkontena';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFormField(
          controller: enterPasswordController,
          focusNode: inputPassword,
          obscureText: _obscurePassword,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 3.h,
            vertical: 9.v,
          ),
          hintText: "Masukin password mu",
          suffix: IconButton(
            icon: Icon(
              _obscurePassword ? Icons.visibility : Icons.visibility_off,
            ),
            color: appTheme.gray500,
            onPressed: _togglePasswordView,
          ),
          textInputAction: TextInputAction.done,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Password tidak boleh kosong';
            }
            return null;
          },
          onTapOutside: (value) {
            inputPassword.unfocus();
          },
          onEditingComplete: () {
            // print('debug');
            inputPassword.unfocus();
            onTapMasuk(context);
          },
        ),
      ],
    );
  }

  void _togglePasswordView() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void onTapMasuk(BuildContext context) async {
    if (enterPhoneController.text != '' && enterPasswordController.text != '') {
      setState(() {
        isLoading = true;
      });

      final frappeLogin.loginRequest request = frappeLogin.loginRequest(
        username: enterPhoneController.text,
        password: enterPasswordController.text,
      );

      try {
        Map<String, dynamic> result = await frappeLogin.login(request);

        if ((result.containsKey('message')) &&
            (result['message'] == 'Logged In')) {
          final frappeUserDetail.UserDetailRequest requestUser =
              frappeUserDetail.UserDetailRequest(
            cookie: AppState().setCookie,
            id: enterPhoneController.text,
          );

          final callRequestUser =
              await frappeUserDetail.request(requestQuery: requestUser).timeout(
                    Duration(seconds: 30),
                  );

          print('check data req user, ${callRequestUser}');
          if (callRequestUser.isNotEmpty) {
            setState(() {
              AppState().configUser = callRequestUser;
            });
          }
          setState(() {
            isLoading = false;
          });

          if (context.mounted) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.selectOrganisationScreen,
              (route) => false,
            );
          }
        }

        // print('header, ${AppState().setCookie}');
      } catch (error) {
        if (error.toString() == 'Exception: Authentication Error!') {
          enterPasswordController.text = '';
          enterPhoneController.text = '';
          if (context.mounted) {
            alert.alertError(context, 'Sepertinya akun atau passwordmu salah');
          }
        } else {
          if (context.mounted) {
            alert.alertError(context, error.toString());
          }
        }
      }

      setState(() {
        isLoading = false;
      });
    } else {
      alert.alertError(context, 'Data Belum Lengkap!');
    }
  }
}
