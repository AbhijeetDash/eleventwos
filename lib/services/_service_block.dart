import '../models/models.dart';

abstract class BlockService {
  /// To check if tqo given blocks can be merged or not.
  bool canMergeBlocks(Block block1, Block block2);

  /// To merge two given blocks
  List<Block?> mergeBlocks(Block mergeIn, Block mergeOut);
}

class BlockServiceImpl extends BlockService {
  @override
  bool canMergeBlocks(Block block1, Block block2) {
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

  /// The private function to merge two given tiles.
  /// Always returns the mergeIn block with the new value.
  @override
  List<Block?> mergeBlocks(Block mergeIn, Block mergeOut) {
    // If the blocks can't be merged, then return null.
    if (!canMergeBlocks(mergeIn, mergeOut)) {
      if (!mergeIn.isEmpty() && !mergeOut.canMerge) {
        mergeOut.copyWith(canMerge: true);
      }
      return [];
    }

    if (mergeOut.isEmpty()) {
      // If the mergeOut block is empty, then copy the value from mergeIn.
      mergeOut.copyWith(value: mergeIn.value, canMerge: true);
      mergeIn.copyWith(value: 0, canMerge: true);
    } else if (mergeIn.value == mergeOut.value) {
      // If the values are equal, then double the value of mergeOut.
      mergeOut.copyWith(value: mergeIn.value * 2, canMerge: true);
      mergeIn.copyWith(value: 0, canMerge: true);
    } else {
      // If the values are not equal, then copy the value from mergeIn.
      mergeOut.copyWith(canMerge: true);
    }

    // The updated blocks are returned.
    return [mergeIn, mergeOut];
  }
}
