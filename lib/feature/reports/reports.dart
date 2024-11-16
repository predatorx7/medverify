import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healtheye/feature/link/link_document.dart';
import 'package:uuid/uuid.dart';

import 'data/report.dart';

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
