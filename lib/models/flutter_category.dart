enum FlutterCategory {
  textField('Text Field', 'text_field'),
  button('Button', 'button'),
  dialog('Dialog', 'dialog'),
  appBar('App Bar', 'app_bar'),
  drawer('Drawer', 'drawer'),
  snackbar('Snackbar', 'snackbar'),
  bottomNavigationBar('Bottom Navigation Bar', 'bottom_navigation_bar'),
  loadingIndicator('Loading Indicator', 'loading_indicator'),
  image('Image', 'image'),
  listTile('List Tile', 'list_tile'),
  text('Text', 'text'),
  chip('Chip', 'chip'),
  customShape('Custom Shape', 'custom_shape'),
  icon('Icon', 'icon'),
  view('View', 'view'),
  layout('Layout', 'layout'),
  shimmer('Shimmer', 'shimmer'),
  other('Other', 'other');

  final String name;
  final String value;

  const FlutterCategory(this.name, this.value);
}
