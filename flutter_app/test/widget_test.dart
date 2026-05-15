import 'package:flutter_test/flutter_test.dart';

import 'package:prodapp_flutter/core/theme/app_theme.dart';

void main() {
  test('AppTheme.base returns a valid ThemeData', () {
    final theme = AppTheme.base();
    expect(theme.colorScheme.primary, isNotNull);
  });

  test('AppTheme.paraSecao gera cor por seção', () {
    final t = AppTheme.paraSecao(SecaoTema.silo);
    expect(t.appBarTheme.backgroundColor, isNotNull);
  });
}
