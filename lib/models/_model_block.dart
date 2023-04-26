import 'package:equatable/equatable.dart';

class Block extends Equatable {
  final int xaxis, yaxis, value;
  final bool canMerge;

  const Block({
    required this.xaxis,
    required this.yaxis,
    required this.value,
    required this.canMerge
  });

  bool isEmpty() => value == 0;

  @override
  List<Object?> get props => [xaxis, yaxis, value];
}
