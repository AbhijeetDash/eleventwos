import '../models/models.dart';

abstract class ServiceBlock {
  /// To check if tqo given blocks can be merged or not.
  bool canMerge(Block block1, Block block2);
}

class ServiceBlockImpl extends ServiceBlock {
  @override
  bool canMerge(Block block1, Block block2) {
    // If any block is empty, then they can't be merged.
    if (block1.isEmpty() || block2.isEmpty()) {
      return false;
    }

    // if the values in the blocks are not equal, then they can't be merged.
    if (block1.value != block2.value) {
      return false;
    }

    return true;
  }
}
