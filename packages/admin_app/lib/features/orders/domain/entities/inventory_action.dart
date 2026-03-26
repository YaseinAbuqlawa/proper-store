enum InventoryAction {
  /// pending / confirmed / shipped → delivered
  delivery,

  /// delivered → cancelled
  cancellation,

  /// cancelled → any other status
  uncancellation,

  /// no inventory change needed
  none,
}
