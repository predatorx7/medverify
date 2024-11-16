import 'package:healtheye/feature/link/link_document.dart';

class Report {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final VerifiedFile file;
  final VerifiedDocument document;

  const Report({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.file,
    required this.document,
  });
}
