class NoteModel {
  late final String title;
  late final String note;
  late final String dateStamp;
  late final bool pinned;

  NoteModel({
    required this.title,
    required this.note,
    required this.dateStamp,
    this.pinned = false,
  });

  NoteModel.fromJson(Map<String, dynamic> json) {
    title = json['title'].toString();
    note = json['note'].toString();
    dateStamp = json['date'].toString();
    pinned = json['pinned'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['note'] = note;
    data['date'] = dateStamp;
    data['pinned'] = pinned;
    return data;
  }
}
