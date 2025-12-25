import 'package:lisa_beauty_salon/core/utils/message.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';

/// Shows a snackbar indicating that a feature is still under development.
void showFeatureUnderDevelopment() {
  MessageUtils.showInfoSnackBar(
    Strings.featureUnderDevelopment
  );
}
