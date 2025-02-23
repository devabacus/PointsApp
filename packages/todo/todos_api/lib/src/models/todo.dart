import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:meta/meta.dart';
// import 'json_map.dart';

part 'todo.g.dart';

@immutable
@JsonSerializable()
class Todo extends Equatable {
  Todo({
    required this.title,
    String? id,
    this.description = '',
    this.isCompleted = false,
  }) : assert(
         id == null || id.isNotEmpty,
         'id must either be null or not empty ',
       ),
       id = id ?? const Uuid().v4();

  final String id;
  final String title;
  final String description;
  final bool isCompleted;

  

  Todo copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
  }) {
    return Todo(
      title: title ?? this.title,
      id: id ?? this.id,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  static Todo fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  @override
  List<Object?> get props => [id, title, description, isCompleted];
}


