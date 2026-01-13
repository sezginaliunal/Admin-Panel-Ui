import 'package:test_project/app/features/dashboard/core/models/user_model.dart';

class MockDb {
  static final users = List.generate(
    100,
    (i) => UserModel(
      id: i + 1,
      name: 'User ${i + 1}',
      email: 'user${i + 1}@mail.com',
      role: i.isEven ? 'Admin' : 'User',
      isActive: i.isEven ? true : false,
    ),
  );
}
