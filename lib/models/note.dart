import 'package:sqflite/sqflite.dart';

class Note {
  final int? id;
  final String title;
  final String description;
  final DateTime time;
  Note({
    this.id,
    required this.title,
    required this.description,
    required this.time,
  });

  Note copywith ({
    int? id,
    String? title,
    String? description,
    DateTime? time,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      time: time ?? this.time
    ); 
  }

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'title' : title,
      'description' : description,
      'time' : time.microsecondsSinceEpoch,
    };
  }

  factory Note.fromMap(Map<String, dynamic>map){
    return Note(
      id: map['id']?.toInt(),
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      time: DateTime.fromMillisecondsSinceEpoch(int.parse(map['time']))  
    );
  }

}