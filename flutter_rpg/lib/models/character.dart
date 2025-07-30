import 'package:flutter_rpg/models/stats.dart';
import 'package:flutter_rpg/models/vocation.dart';

class Character with Stats {
  // constructor
  Character({
    required this.vocation,
    required this.name,
    required this.slogan,
    required this.id,
  });

  // fields
  final Vocation vocation;
  final String name;
  final String slogan;
  final String id;
  bool _isFav = false;

  // methods
  void toggleIsFav() {
    _isFav = !_isFav;
  }

  // getter

  bool get isFav => _isFav;
}
