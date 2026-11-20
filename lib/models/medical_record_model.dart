/// Medical-center record entry. Mock data uses one record per visit;
/// the real backend may extend with attachments / prescriptions.
library;

class MedicalRecord {
  final String id;
  final DateTime visitDate;
  final String doctor;
  final String diagnosis;
  final String prescription;
  final String? notes;

  const MedicalRecord({
    required this.id,
    required this.visitDate,
    required this.doctor,
    required this.diagnosis,
    required this.prescription,
    this.notes,
  });

  factory MedicalRecord.fromJson(Map<String, dynamic> json) => MedicalRecord(
        id: json['id'].toString(),
        visitDate: DateTime.parse(json['visit_date'].toString()),
        doctor: (json['doctor'] ?? '').toString(),
        diagnosis: (json['diagnosis'] ?? '').toString(),
        prescription: (json['prescription'] ?? '').toString(),
        notes: json['notes']?.toString(),
      );
}




