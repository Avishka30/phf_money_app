import 'package:equatable/equatable.dart';

class Account extends Equatable {
  final int id;
  final String name;
  final double balance;
  final DateTime createdAt;

  const Account({
    required this.id,
    required this.name,
    required this.balance,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, name, balance, createdAt];
}
