enum RoutesName {
  dashboard('/'),
  unknown('/unknown'),
  onboarding('/onboarding'),
  home('/home'),
  users('/users'),
  packages('/packages'),
  companySettings('/companySettings'),
  login('/login'),
  settings('/settings'),
  finance('/finance'),
  profile('/profile');

  final String path;
  const RoutesName(this.path);
}
