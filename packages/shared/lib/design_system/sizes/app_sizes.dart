class AppSizes {
  static const double iconSizeLarge = 24.0;
  static const double iconSizeMedium = 20.0;
  static const double iconSizeSmall = 18.0;

  static DeviceType getDeviceType(double screenWidth) {
    if (screenWidth <= 320) {
      return DeviceType.smallPhone;
    } else if (screenWidth <= 375) {
      return DeviceType.mediumPhone;
    } else if (screenWidth < 440) {
      return DeviceType.largePhone;
    } else if (screenWidth < 900) {
      return DeviceType.tablet;
    } else {
      return DeviceType.laptop;
    }
  }
}

enum DeviceType { smallPhone, mediumPhone, largePhone, tablet, laptop }
