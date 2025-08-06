import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/models/vocation.dart';
import 'package:flutter_rpg/screens/create/vocation_card.dart';
import 'package:flutter_rpg/screens/home/home.dart';
import 'package:flutter_rpg/shared/styled_button.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:flutter_rpg/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class Create extends StatefulWidget {
  const Create({super.key});

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  // variable to store name and slogan
  final _nameController = TextEditingController();
  final _sloganContoller = TextEditingController();

  // cleanup
  @override
  void dispose() {
    _nameController.dispose();
    _sloganContoller.dispose();
    super.dispose();
  }

  Vocation selectedVocation = Vocation.junkie;

  void onVocationSelected(Vocation vocation) {
    setState(() {
      selectedVocation = vocation;
    });
  }

  // submit handler
  void handleSubmit() {
    if (_nameController.text.trim().isEmpty) {
      // print('name is empty');
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // backgroundColor: AppColors.secondaryAccent,
            // surfaceTintColor: Colors.transparent,
            title: const StyledHeading("Name is required"),
            content: const StyledText(
              "Every good RPG character need a great name..",
            ),
            actions: [
              StyledButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const StyledHeading("close"),
              ),
            ],
            actionsAlignment: MainAxisAlignment.center,
          );
        },
      );
      return;
    }
    if (_sloganContoller.text.trim().isEmpty) {
      // print('slogan is empty');
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // backgroundColor: AppColors.secondaryAccent,
            // surfaceTintColor: Colors.transparent,
            title: const StyledHeading("Slogan is required"),
            content: const StyledText("Remember to add a catchy slogan.."),
            actions: [
              StyledButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const StyledHeading("close"),
              ),
            ],
            actionsAlignment: MainAxisAlignment.center,
          );
        },
      );
      return;
    }

    // print('name: ${_nameController.text}');
    // print('slogan: ${_sloganContoller.text}');

    // create character
    characters.add(
      Character(
        id: uuid.v4(),
        name: _nameController.text.trim(),
        slogan: _sloganContoller.text.trim(),
        vocation: selectedVocation,
      ),
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Home()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const StyledTitle("Character Creation"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // welcome message
              Center(
                child: Icon(
                  Icons.code,
                  color: AppColors.primaryColor,
                  size: 50,
                ),
              ),
              Center(child: StyledHeading("Welcome, new player.")),
              Center(
                child: StyledText(
                  "Createa a name & slogan for your character.",
                ),
              ),
              SizedBox(height: 30),

              // input for name and slogan
              TextField(
                controller: _nameController,
                // for styling the input text design (what user type)
                style: GoogleFonts.kanit(
                  textStyle: Theme.of(context).textTheme.bodyMedium,
                ),
                // cursor color
                cursorColor: AppColors.textColor,
                // for styling the input field design
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_2),
                  label: StyledText("Character name"),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _sloganContoller,
                // for styling the input text design (what user type)
                style: GoogleFonts.kanit(
                  textStyle: Theme.of(context).textTheme.bodyMedium,
                ),
                // cursor color
                cursorColor: AppColors.textColor,
                // for styling the input field design
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.chat),
                  label: StyledText("Character slogan"),
                ),
              ),
              SizedBox(height: 30),

              // select vocation title
              Center(
                child: Icon(
                  Icons.person,
                  color: AppColors.primaryColor,
                  size: 50,
                ),
              ),
              Center(child: StyledHeading("Choose a vocation")),
              Center(
                child: StyledText("This determines your available skills."),
              ),
              SizedBox(height: 30),

              // vocation cards
              VocationCard(
                vocation: Vocation.wizard,
                onVocationSelected: onVocationSelected,
                selected: selectedVocation == Vocation.wizard,
              ),
              VocationCard(
                vocation: Vocation.junkie,
                onVocationSelected: onVocationSelected,
                selected: selectedVocation == Vocation.junkie,
              ),
              VocationCard(
                vocation: Vocation.raider,
                onVocationSelected: onVocationSelected,
                selected: selectedVocation == Vocation.raider,
              ),
              VocationCard(
                vocation: Vocation.ninja,
                onVocationSelected: onVocationSelected,
                selected: selectedVocation == Vocation.ninja,
              ),
              Center(
                child: StyledButton(
                  onPressed: handleSubmit,
                  child: const StyledHeading("Create character"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
