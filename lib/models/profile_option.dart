class ProfileOptionModel {
  final String title;
  final String subtitle;
  final dynamic icon;
  final Function() onTap;

  ProfileOptionModel({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });
}
