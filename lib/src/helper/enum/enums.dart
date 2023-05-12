enum SharedPrefType {
  init(title: null, des: 'Shared Preference in Isolate', path: null),
  setup(title: 'Code Preview', des: null, path: ''),
  error(title: 'Error', des: null, path: ''),
  fix(title: 'How can we fix this?', des: null, path: '');

  final String? title;
  final String? des;
  final String? path;
  const SharedPrefType(
      {required this.title, required this.des, required this.path});
}

