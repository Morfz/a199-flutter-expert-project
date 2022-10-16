import 'package:equatable/equatable.dart';

class MovieGenre extends Equatable {
  const MovieGenre({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  @override
  List<Object> get props => [id, name];
}
