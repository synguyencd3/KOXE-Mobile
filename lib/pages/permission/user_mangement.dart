// import '/flutter_flow/flutter_flow_theme.dart';
// import '/flutter_flow/flutter_flow_util.dart';
// import '/flutter_flow/flutter_flow_widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

// import 'new_page_model.dart';
// export 'new_page_model.dart';

// class NewPageWidget extends StatefulWidget {
//   const NewPageWidget({super.key});

//   @override
//   State<NewPageWidget> createState() => _NewPageWidgetState();
// }

// class _NewPageWidgetState extends State<NewPageWidget> {
//   late NewPageModel _model;

//   final scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   void initState() {
//     super.initState();
//     _model = createModel(context, () => NewPageModel());
//   }

//   @override
//   void dispose() {
//     _model.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => _model.unfocusNode.canRequestFocus
//           ? FocusScope.of(context).requestFocus(_model.unfocusNode)
//           : FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         key: scaffoldKey,
//         backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
//         body: SafeArea(
//           top: true,
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
//                 child: Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: FlutterFlowTheme.of(context).secondaryBackground,
//                     boxShadow: [
//                       BoxShadow(
//                         blurRadius: 3,
//                         color: Color(0x33000000),
//                         offset: Offset(
//                           0,
//                           1,
//                         ),
//                         spreadRadius: 0,
//                       )
//                     ],
//                   ),
//                   child: Padding(
//                     padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.max,
//                       children: [
//                         Container(
//                           width: 60,
//                           height: 60,
//                           decoration: BoxDecoration(
//                             color: Color(0x4D9489F5),
//                             shape: BoxShape.circle,
//                           ),
//                           alignment: AlignmentDirectional(0, 0),
//                           child: Card(
//                             clipBehavior: Clip.antiAliasWithSaveLayer,
//                             color: FlutterFlowTheme.of(context).primary,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(40),
//                             ),
//                             child: Padding(
//                               padding: EdgeInsetsDirectional.fromSTEB(
//                                   12, 12, 12, 12),
//                               child: Icon(
//                                 Icons.group_outlined,
//                                 color: FlutterFlowTheme.of(context).info,
//                                 size: 24,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding:
//                               EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
//                           child: Column(
//                             mainAxisSize: MainAxisSize.max,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'User Management',
//                                 style: FlutterFlowTheme.of(context)
//                                     .labelMedium
//                                     .override(
//                                       fontFamily: 'Readex Pro',
//                                       letterSpacing: 0,
//                                     ),
//                               ),
//                               Padding(
//                                 padding:
//                                     EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
//                                 child: Text(
//                                   'Assign or remove permissions',
//                                   style: FlutterFlowTheme.of(context)
//                                       .bodySmall
//                                       .override(
//                                         fontFamily: 'Readex Pro',
//                                         letterSpacing: 0,
//                                       ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
//                 child: Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: FlutterFlowTheme.of(context).secondaryBackground,
//                     boxShadow: [
//                       BoxShadow(
//                         blurRadius: 4,
//                         color: Color(0x1F000000),
//                         offset: Offset(
//                           0,
//                           2,
//                         ),
//                         spreadRadius: 0,
//                       )
//                     ],
//                     borderRadius: BorderRadius.circular(8),
//                     border: Border.all(
//                       color: FlutterFlowTheme.of(context).primaryBackground,
//                       width: 1,
//                     ),
//                   ),
//                   child: Padding(
//                     padding: EdgeInsetsDirectional.fromSTEB(12, 8, 16, 4),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.max,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Padding(
//                           padding:
//                               EdgeInsetsDirectional.fromSTEB(4, 12, 12, 12),
//                           child: Column(
//                             mainAxisSize: MainAxisSize.max,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'User 1',
//                                 style: FlutterFlowTheme.of(context)
//                                     .headlineSmall
//                                     .override(
//                                       fontFamily: 'Outfit',
//                                       letterSpacing: 0,
//                                     ),
//                               ),
//                               Padding(
//                                 padding:
//                                     EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
//                                 child: Text(
//                                   'Permissions: None',
//                                   style: FlutterFlowTheme.of(context)
//                                       .labelMedium
//                                       .override(
//                                         fontFamily: 'Readex Pro',
//                                         letterSpacing: 0,
//                                       ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           width: 60,
//                           height: 60,
//                           decoration: BoxDecoration(
//                             color:
//                                 FlutterFlowTheme.of(context).primaryBackground,
//                             shape: BoxShape.circle,
//                           ),
//                           alignment: AlignmentDirectional(0, 0),
//                           child: Card(
//                             clipBehavior: Clip.antiAliasWithSaveLayer,
//                             color: FlutterFlowTheme.of(context)
//                                 .secondaryBackground,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(40),
//                             ),
//                             child: Padding(
//                               padding: EdgeInsetsDirectional.fromSTEB(
//                                   12, 12, 12, 12),
//                               child: Icon(
//                                 Icons.add_rounded,
//                                 color: FlutterFlowTheme.of(context).primaryText,
//                                 size: 24,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
//                 child: Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: FlutterFlowTheme.of(context).secondaryBackground,
//                     boxShadow: [
//                       BoxShadow(
//                         blurRadius: 4,
//                         color: Color(0x1F000000),
//                         offset: Offset(
//                           0,
//                           2,
//                         ),
//                         spreadRadius: 0,
//                       )
//                     ],
//                     borderRadius: BorderRadius.circular(8),
//                     border: Border.all(
//                       color: FlutterFlowTheme.of(context).primaryBackground,
//                       width: 1,
//                     ),
//                   ),
//                   child: Padding(
//                     padding: EdgeInsetsDirectional.fromSTEB(12, 8, 16, 4),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.max,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Padding(
//                           padding:
//                               EdgeInsetsDirectional.fromSTEB(4, 12, 12, 12),
//                           child: Column(
//                             mainAxisSize: MainAxisSize.max,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'User 2',
//                                 style: FlutterFlowTheme.of(context)
//                                     .headlineSmall
//                                     .override(
//                                       fontFamily: 'Outfit',
//                                       letterSpacing: 0,
//                                     ),
//                               ),
//                               Padding(
//                                 padding:
//                                     EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
//                                 child: Text(
//                                   'Permissions: Read',
//                                   style: FlutterFlowTheme.of(context)
//                                       .labelMedium
//                                       .override(
//                                         fontFamily: 'Readex Pro',
//                                         letterSpacing: 0,
//                                       ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           width: 60,
//                           height: 60,
//                           decoration: BoxDecoration(
//                             color:
//                                 FlutterFlowTheme.of(context).primaryBackground,
//                             shape: BoxShape.circle,
//                           ),
//                           alignment: AlignmentDirectional(0, 0),
//                           child: Card(
//                             clipBehavior: Clip.antiAliasWithSaveLayer,
//                             color: FlutterFlowTheme.of(context)
//                                 .secondaryBackground,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(40),
//                             ),
//                             child: Padding(
//                               padding: EdgeInsetsDirectional.fromSTEB(
//                                   12, 12, 12, 12),
//                               child: Icon(
//                                 Icons.remove_rounded,
//                                 color: FlutterFlowTheme.of(context).primaryText,
//                                 size: 24,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
//                 child: Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: FlutterFlowTheme.of(context).secondaryBackground,
//                     boxShadow: [
//                       BoxShadow(
//                         blurRadius: 4,
//                         color: Color(0x1F000000),
//                         offset: Offset(
//                           0,
//                           2,
//                         ),
//                         spreadRadius: 0,
//                       )
//                     ],
//                     borderRadius: BorderRadius.circular(8),
//                     border: Border.all(
//                       color: FlutterFlowTheme.of(context).primaryBackground,
//                       width: 1,
//                     ),
//                   ),
//                   child: Padding(
//                     padding: EdgeInsetsDirectional.fromSTEB(12, 8, 16, 4),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.max,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Padding(
//                           padding:
//                               EdgeInsetsDirectional.fromSTEB(4, 12, 12, 12),
//                           child: Column(
//                             mainAxisSize: MainAxisSize.max,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'User 3',
//                                 style: FlutterFlowTheme.of(context)
//                                     .headlineSmall
//                                     .override(
//                                       fontFamily: 'Outfit',
//                                       letterSpacing: 0,
//                                     ),
//                               ),
//                               Padding(
//                                 padding:
//                                     EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
//                                 child: Text(
//                                   'Permissions: Write',
//                                   style: FlutterFlowTheme.of(context)
//                                       .labelMedium
//                                       .override(
//                                         fontFamily: 'Readex Pro',
//                                         letterSpacing: 0,
//                                       ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           width: 60,
//                           height: 60,
//                           decoration: BoxDecoration(
//                             color:
//                                 FlutterFlowTheme.of(context).primaryBackground,
//                             shape: BoxShape.circle,
//                           ),
//                           alignment: AlignmentDirectional(0, 0),
//                           child: Card(
//                             clipBehavior: Clip.antiAliasWithSaveLayer,
//                             color: FlutterFlowTheme.of(context)
//                                 .secondaryBackground,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(40),
//                             ),
//                             child: Padding(
//                               padding: EdgeInsetsDirectional.fromSTEB(
//                                   12, 12, 12, 12),
//                               child: Icon(
//                                 Icons.remove_rounded,
//                                 color: FlutterFlowTheme.of(context).primaryText,
//                                 size: 24,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
