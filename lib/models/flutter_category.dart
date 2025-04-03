enum FlutterCategory {
  textField('Text Field', 'text_field'),
  button('Button', 'button'),
  dialog('Dialog', 'dialog'),
  appBar('App Bar', 'app_bar'),
  drawer('Drawer', 'drawer'),
  snackbar('Snackbar', 'snackbar'),
  bottomNavigationBar('Bottom Navigation Bar', 'bottom_navigation_bar'),
  loadingIndicator('Loading Indicator', 'loading_indicator');

  final String name;
  final String value;

  const FlutterCategory(this.name, this.value);
}
