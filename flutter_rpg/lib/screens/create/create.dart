import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/vocation.dart';
import 'package:flutter_rpg/screens/create/vocation_card.dart';
import 'package:flutter_rpg/shared/styled_button.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:flutter_rpg/theme.dart';
import 'package:google_fonts/google_fonts.dart';

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
      return;
    }
    if (_sloganContoller.text.trim().isEmpty) {
      // print('slogan is empty');
      return;
    }

    // print('name: ${_nameController.text}');
    // print('slogan: ${_sloganContoller.text}');
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
                  Icons.code,
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
