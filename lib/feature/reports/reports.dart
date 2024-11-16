import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healtheye/feature/auth/auth.dart';
import 'package:healtheye/feature/link/link_document.dart';
import 'package:healtheye/logging.dart';
import 'package:http/http.dart';
import 'package:uuid/uuid.dart';

import 'data/report.dart';

final reportAdditionClient = Client();

class UserReportsController extends Notifier<List<Report>> {
  @override
  List<Report> build() {
    return const [];
  }

  void addReport(
    VerifiedFile file,
    VerifiedDocument document,
  ) {
    final properties = document.properties;
    final report = Report(
      id: const Uuid().v4(),
      title: properties?['report_title'] ?? '',
      description: properties?['description'] ?? '',
      createdAt: DateTime.now(),
      file: file,
      document: document,
    );

    print('proof ${ref.read(authProvider).keys?.publicKey}');

    reportAdditionClient
        .post(
      Uri.parse('https://53fc-49-237-11-168.ngrok-free.app/proof'),
      body: json.encode({
        "imgProof": file.attestationOutput.toJson(),
        "aiProof": document.attestationOutput.toJson(),
        "fromAddress": //ref.read(authProvider).keys?.publicKey ??
            "0x925978064717107d621d0fb2c8e68b8809f8cfd8b046c84d0fee6b68cbc5f68e",
        "toAddress":
            "0x925978064717107d621d0fb2c8e68b8809f8cfd8b046c84d0fee6b68cbc5f68e",
      }),
    )
        .then((response) {
      $logger.child('addReport').info(response.body);
    }).catchError((e, s) {
      $logger.child('addReport').severe('failed', e, s);
    });

    state = [
      report,
      ...state,
    ];
  }
}

final userReportsProvider =
    NotifierProvider<UserReportsController, List<Report>>(
  () => UserReportsController(),
);
