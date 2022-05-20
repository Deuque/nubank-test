import 'package:equatable/equatable.dart';

class ShortenedUrl extends Equatable {
  final String alias, short, original;

  const ShortenedUrl({
    required this.alias,
    required this.short,
    required this.original,
  });

  @override
  List<Object?> get props => [alias, short, original];
}
