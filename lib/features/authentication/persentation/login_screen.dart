import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:kontena_pos/core/app_export.dart';
import 'package:kontena_pos/widgets/custom_elevated_button.dart';
import 'package:kontena_pos/core/theme/theme_helper.dart';

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

  TextEditingController? userFieldController;
  TextEditingController? pwFieldController;

  late bool pwFieldVisibility = false;

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

    userFieldController ??= TextEditingController();
    pwFieldController ??= TextEditingController();
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
                        width: MediaQuery.sizeOf(context).width * 0.4,
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
                              30.0, 30.0, 30.0, 30.0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 60.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(16.0, 16.0, 16.0, 16.0),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          child: Image.asset(
                                            'images/logo.png',
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.18,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
                                              0.0, 8.0, 0.0, 16.0),
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
                                                      0.0, 0.0, 0.0, 16.0),
                                              child: Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: theme
                                                      .colorScheme.background,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  border: Border.all(
                                                    color: theme
                                                        .colorScheme.surface,
                                                    width: 1.0,
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          16.0, 0.0, 16.0, 0.0),
                                                  child: TextFormField(
                                                    controller:
                                                        userFieldController,
                                                    onChanged: (_) =>
                                                        EasyDebounce.debounce(
                                                      '_model.userFieldController',
                                                      const Duration(
                                                          milliseconds: 100),
                                                      () => setState(() {}),
                                                    ),
                                                    autofocus: false,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          'Email/Username',
                                                      hintStyle: theme
                                                          .textTheme.labelSmall,
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                      errorBorder:
                                                          InputBorder.none,
                                                      focusedErrorBorder:
                                                          InputBorder.none,
                                                    ),
                                                    style: theme
                                                        .textTheme.labelSmall,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: theme
                                                    .colorScheme.background,
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                border: Border.all(
                                                  color:
                                                      theme.colorScheme.surface,
                                                  width: 1.0,
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        16.0, 0.0, 16.0, 0.0),
                                                child: TextFormField(
                                                  controller: pwFieldController,
                                                  onChanged: (_) =>
                                                      EasyDebounce.debounce(
                                                    '_model.pwFieldController',
                                                    const Duration(
                                                        milliseconds: 100),
                                                    () => setState(() {}),
                                                  ),
                                                  autofocus: false,
                                                  obscureText:
                                                      !pwFieldVisibility,
                                                  decoration: InputDecoration(
                                                    hintText: 'Password',
                                                    hintStyle: theme
                                                        .textTheme.labelSmall,
                                                    enabledBorder:
                                                        InputBorder.none,
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    errorBorder:
                                                        InputBorder.none,
                                                    focusedErrorBorder:
                                                        InputBorder.none,
                                                    suffixIcon: InkWell(
                                                      onTap: () => setState(
                                                        () => pwFieldVisibility =
                                                            !pwFieldVisibility,
                                                      ),
                                                      focusNode: FocusNode(
                                                          skipTraversal: true),
                                                      child: Icon(
                                                        pwFieldVisibility
                                                            ? Icons
                                                                .visibility_outlined
                                                            : Icons
                                                                .visibility_off_outlined,
                                                        color: appTheme.gray500,
                                                        size: 22.0,
                                                      ),
                                                    ),
                                                  ),
                                                  style: theme
                                                      .textTheme.labelSmall,
                                                  keyboardType: TextInputType
                                                      .visiblePassword,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    CustomElevatedButton(
                                      text: "Masuk",
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
}
