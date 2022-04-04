import 'package:flutter/material.dart';
import 'package:flutter_apps/screens/citation_screen/citation_screen.dart';
import 'package:flutter_apps/screens/home_screen/widgets/citation_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  void goToCitationScreen(
      {required BuildContext context, required String citationCategory}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CitationScreen(
          currentCitation: citationCategory,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/background.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Stack(
            children: [
              Positioned(
                top: 300,
                right: 20,
                child: CitationButton(
                  title: 'أذكار الصباح',
                  onPress: () {
                    goToCitationScreen(
                        context: context, citationCategory: 'Morning');
                  },
                ),
              ),
              Positioned(
                top: 550,
                left: 20,
                child: CitationButton(
                  title: 'أذكار المساء',
                  onPress: () {
                    goToCitationScreen(
                        context: context, citationCategory: 'Evening');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
