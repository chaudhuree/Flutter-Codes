import 'package:flutter_rpg/models/skill.dart';
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
  final Set<Skill> skills = {};
  final Vocation vocation;
  final String name;
  final String slogan;
  final String id;
  bool _isFav = false;

  // methods
  void toggleIsFav() {
    _isFav = !_isFav;
  }

  void updateSkills(Skill skill) {
    skills.clear();
    skills.add(skill);
  }

  // getter

  bool get isFav => _isFav;
}

// dummy character data

List<Character> characters = [
  Character(
    id: '1',
    name: 'Klara',
    vocation: Vocation.wizard,
    slogan: 'Kapumf!',
  ),
  Character(
    id: '2',
    name: 'Jonny',
    vocation: Vocation.junkie,
    slogan: 'Light me up...',
  ),
  Character(
    id: '3',
    name: 'Crimson',
    vocation: Vocation.raider,
    slogan: 'Fire in the hole!',
  ),
  Character(
    id: '4',
    name: 'Shaun',
    vocation: Vocation.ninja,
    slogan: 'Alright then gang.',
  ),
];
