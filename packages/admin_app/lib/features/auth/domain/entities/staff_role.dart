enum StaffRole {
  admin,
  cs;

  static StaffRole? fromString(String? value) {
    if (value == null) return null;
    return StaffRole.values.where((r) => r.name == value).firstOrNull;
  }

  bool get canAccessProducts => this == StaffRole.admin;
  bool get canAccessStoreConfig => this == StaffRole.admin;
}
