enum StaffRole {
  superAdmin,
  admin,
  cs;

  static StaffRole? fromString(String? value) {
    if (value == null) return null;
    return StaffRole.values.where((r) => r.name == value).firstOrNull;
  }

  bool get canAccessProducts =>
      this == StaffRole.superAdmin || this == StaffRole.admin;

  bool get canAccessStoreConfig =>
      this == StaffRole.superAdmin || this == StaffRole.admin;

  bool get canManageStaff => this == StaffRole.superAdmin;
}
