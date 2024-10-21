import 'package:flutter/material.dart';
import 'package:kontena_pos/widgets/custom_elevated_button.dart';
import 'package:kontena_pos/core/theme/theme_helper.dart';
import 'package:kontena_pos/widgets/custom_text_form_field.dart';
import 'package:kontena_pos/core/app_export.dart';
import 'package:kontena_pos/core/animation/fade.dart';
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
                            30.0,
                            30.0,
                            80.0,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomImageView(
                                  imagePath: ImageConstant.imgAppLauncherIcon,
                                  // imagePath: 'images/img_app_launcher_icon.png',
                                  height: 156,
                                  width: 168,
                                  alignment: Alignment.centerRight,
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
    enterPhoneController.text = 'test';
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // const Padding(
      //   padding: EdgeInsets.only(left: 1),
      //   child: Text(
      //     "No Hp / Email",
      //     style: TextStyle(
      //       fontSize: 16,
      //     ),
      //   ),
      // ),
      // const SizedBox(height: 6),
      CustomTextFormField(
        controller: enterPhoneController,
        focusNode: inputPhone,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 3.h,
          vertical: 9.v,
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
  late bool _obscurePassword = false;
  Widget _buildPasswordSection(BuildContext context) {
    enterPasswordController.text = 'test';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const Padding(
        //   padding: EdgeInsets.only(left: 1),
        //   child: Text(
        //     "Password",
        //     style: TextStyle(
        //       fontSize: 16,
        //     ),
        //   ),
        // ),
        // const SizedBox(height: 6),
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
      Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoutes.selectOrganisationScreen,
        (route) => false,
      );
    } else {
      alert.alertError(context, 'Data Belum Lengkap!');
    }
  }
}
