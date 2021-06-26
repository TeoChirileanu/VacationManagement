import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IstoricCereriWidget extends StatefulWidget {
  IstoricCereriWidget({Key key}) : super(key: key);

  @override
  _IstoricCereriWidgetState createState() => _IstoricCereriWidgetState();
}

class _IstoricCereriWidgetState extends State<IstoricCereriWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.primaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          'Istoric Concedii',
          style: FlutterFlowTheme.title1.override(
            fontFamily: 'Poppins',
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment(0, 0),
            child: StreamBuilder<List<VacationsRecord>>(
              stream: queryVacationsRecord(),
              builder: (context, snapshot) {
                // Customize what your widget looks like when it's loading.
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                List<VacationsRecord> columnVacationsRecordList = snapshot.data;
                // Customize what your widget looks like with no query results.
                if (snapshot.data.isEmpty) {
                  // return Container();
                  // For now, we'll just include some dummy data.
                  columnVacationsRecordList =
                      createDummyVacationsRecord(count: 4);
                }
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: List.generate(columnVacationsRecordList.length,
                      (columnIndex) {
                    final columnVacationsRecord =
                        columnVacationsRecordList[columnIndex];
                    return Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            dateTimeFormat(
                                'yMMMd', columnVacationsRecord.startDate),
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Text(
                            dateTimeFormat(
                                'yMMMd', columnVacationsRecord.endDate),
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Text(
                            columnVacationsRecord.status,
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Color(0x00EEEEEE),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
