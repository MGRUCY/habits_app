import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:habits_app/db/db.dart';

part 'db_provider.g.dart';

@Riverpod(keepAlive: true)
AppDb appDb(Ref ref) {
  return AppDb();
}
