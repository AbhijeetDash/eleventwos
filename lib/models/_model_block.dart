import 'package:equatable/equatable.dart';

class Block extends Equatable {
  final int xaxis, yaxis, value;
  final bool canMerge;

  const Block(
      {required this.xaxis,
      required this.yaxis,
      required this.value,
      required this.canMerge});

  // Copy with
  Block copyWith({
    int? xaxis,
    int? yaxis,
    bool? canMerge,
    int? value,
  }) {
    return Block(
      xaxis: xaxis ?? this.xaxis,
      yaxis: yaxis ?? this.yaxis,
      canMerge: canMerge ?? this.canMerge,
      value: value ?? this.value,
    );
  }

  bool isEmpty() => value == 0;

  @override
  List<Object?> get props => [xaxis, yaxis, value];
}
