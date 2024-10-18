import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kontena_pos/data/organisation.dart';
import 'package:kontena_pos/widgets/custom_elevated_button.dart';
import 'package:kontena_pos/core/theme/theme_helper.dart';
import 'package:kontena_pos/widgets/custom_text_form_field.dart';
import 'package:kontena_pos/core/app_export.dart';
import 'package:kontena_pos/core/animation/fade.dart';
import 'package:kontena_pos/core/utils/alert.dart' as alert;

class SelectOrganisationScreen extends StatefulWidget {
  const SelectOrganisationScreen({Key? key}) : super(key: key);

  @override
  _SelectOrganisationScreenState createState() =>
      _SelectOrganisationScreenState();
}

class _SelectOrganisationScreenState extends State<SelectOrganisationScreen> {
  // late LoginScreen _model;
  final unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  String? Function(BuildContext, String?)? userFieldControllerValidator;

  @override
  void initState() {
    super.initState();
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
                        width: MediaQuery.sizeOf(context).width * 0.6,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer,
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              30.0, 30.0, 30.0, 80.0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Select Organisation',
                                      style: theme.textTheme.titleLarge,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              8.0, 120.0, 8.0, 0.0),
                                      child: Align(
                                        child: SizedBox(
                                          width:
                                              MediaQuery.sizeOf(context).width,
                                          child: Column(
                                            children: [
                                              MasonryGridView.count(
                                                crossAxisCount: 4,
                                                mainAxisSpacing: 6,
                                                crossAxisSpacing: 6,
                                                shrinkWrap: true,
                                                itemCount: organisation.length,
                                                itemBuilder: (context, index) {
                                                  final currentItem =
                                                      organisation[index];
                                                  final String img =
                                                      currentItem['img'];
                                                  return Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4), // if you need this
                                                      side: BorderSide(
                                                        color: theme.colorScheme
                                                            .outline,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    elevation: 0,
                                                    child: InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () {
                                                        onTap(context);
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                          24.0,
                                                          24.0,
                                                          24.0,
                                                          24.0,
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            Image.asset(
                                                              'assets/images/$img.png',
                                                              fit: BoxFit.cover,
                                                            ),
                                                            const SizedBox(
                                                                height: 12.0),
                                                            AutoSizeText(
                                                              currentItem[
                                                                  'name'],
                                                              style: TextStyle(
                                                                color: theme
                                                                    .colorScheme
                                                                    .secondary,
                                                              ),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              minFontSize: 10,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
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

  void onTap(BuildContext context) async {
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.invoiceScreen,
      (route) => false,
    );
    // if (enterPhoneController.text != '' && enterPasswordController.text != '') {
    // } else {
    //   alert.alertError(context, 'Data Belum Lengkap!');
    // }
  }
}
