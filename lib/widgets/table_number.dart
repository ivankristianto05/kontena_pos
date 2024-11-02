import 'package:flutter/material.dart';
import 'package:kontena_pos/app_state.dart';
import 'package:kontena_pos/core/theme/theme_helper.dart';

class TableNumber extends StatefulWidget {
  TableNumber({Key? key, this.selected}) : super(key: key);

  String? selected;

  @override
  _TableNumberState createState() => _TableNumberState();
}

class _TableNumberState extends State<TableNumber> {
  String TableNumber = '1';

  @override
  void initState() {
    super.initState();
    if (widget.selected != null) {
      TableNumber = widget.selected!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width * 0.25,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 16.0, 16.0, 16.0),
                        child: Text(
                          'Pilih Nomor Meja',
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 16.0, 16.0, 16.0),
                          child: Icon(
                            Icons.close_rounded,
                            color: theme.colorScheme.secondary,
                            size: 24.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 1.0,
                    thickness: 1.0,
                    color: theme.colorScheme.surface,
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        primary: false,
                        shrinkWrap: true,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          String currentNumber = (index + 1).toString();
                          return Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8.0, 6.0, 8.0, 6.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                setState(() {
                                  if (TableNumber == currentNumber) {
                                    TableNumber = '';
                                  } else {
                                    TableNumber = currentNumber;
                                  }
                                });
                                print('Selected Table: $TableNumber');
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: (TableNumber == currentNumber)
                                      ? theme.colorScheme.primary
                                      : theme.colorScheme.primaryContainer,
                                  border: Border.all(
                                    color: (TableNumber == currentNumber)
                                        ? theme.colorScheme.primary
                                        : theme.colorScheme.surface,
                                    width: 1.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 0.0, 6.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        currentNumber,
                                        style: (TableNumber == currentNumber)
                                            ? TextStyle(
                                                color: theme.colorScheme.primaryContainer,
                                              )
                                            : theme.textTheme.labelMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Divider(
                    height: 1.0,
                    thickness: 1.0,
                    color: theme.colorScheme.surface,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              setState(() {});
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              width: double.infinity,
                              height: 48.0,
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                              alignment: AlignmentDirectional(0.00, 0.00),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(4.0, 4.0, 4.0, 4.0),
                                child: Text(
                                  'Terapkan',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: theme.colorScheme.primaryContainer,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
