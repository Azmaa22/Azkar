import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_apps/data/models/citation_model.dart';
import 'package:flutter_apps/data/repos/citation_repo.dart';
import 'package:flutter_apps/screens/citation_screen/widgets/app_bar_container.dart';
import 'package:flutter_apps/screens/citation_screen/widgets/citation_container.dart';
import 'package:flutter_apps/screens/citation_screen/widgets/citation_counter.dart';
import 'package:flutter_apps/screens/citation_screen/widgets/dialog_container.dart';
import 'package:flutter_apps/screens/citation_screen/widgets/navigation_button.dart';
import 'package:flutter_apps/utilities/constants/app_colors.dart';

class CitationScreen extends StatefulWidget {
  final String currentCitation;
  const CitationScreen({Key? key, required this.currentCitation})
      : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<CitationScreen> createState() =>
      _CitationScreenState(currentCitation: currentCitation);
}

class _CitationScreenState extends State<CitationScreen> {
  final String currentCitation;
  _CitationScreenState({required this.currentCitation});
  late List<Citation> citations;
  int citationNumber = 0;

  void nextCitation() {
    if (citationNumber >= 0 && citationNumber < citations.length - 1) {
      setState(() {
        citationNumber += 1;
      });
    } else {
      showDialog(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (context) {
          return const DialogContainer();
        },
      );
    }
  }

  void previousCitation() {
    if (citationNumber < 0 && citationNumber >= citations.length - 1) {
      setState(() {
        citationNumber -= 1;
      });
    } else {
      showDialog(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'لقد وصلت لبداية الأذكار',
              textDirection: TextDirection.rtl,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop('dialog');
                },
                child: const Text(
                  'حسناً',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCitations().then(
      (value) {
        setState(() {
          citations = value;
        });
      },
    );
  }

  Future<List<Citation>> getCitations() async {
    List<Citation> tempCitations =
        await getCurrentCitation(citation: currentCitation);

    return tempCitations;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: AppBarContainer(
            title: citations[0].category,
          ),
        ),
        body: SingleChildScrollView(
          child: RotatedBox(
            quarterTurns: 4,
            child: Container(
              height: size.height,
              width: size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/citation_container.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CitationContainer(
                    citationText: citations[citationNumber].zekr,
                    isReference: false,
                  ),
                  const Divider(
                    height: 5,
                    color: kPrimaryColor,
                    indent: 10,
                    endIndent: 10,
                    thickness: 2,
                  ),
                  CitationContainer(
                    citationText: citations[citationNumber].description,
                    isReference: true,
                  ),
                  CitationContainer(
                    citationText: citations[citationNumber].reference,
                    isReference: true,
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: size.height * 0.1,
                      left: 10.0,
                      right: 10.0,
                      top: 10.0,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            NavigationButton(
                              title: 'السابق',
                              onPress: () {
                                print('previous');
                                previousCitation();
                              },
                              isNext: false,
                            ),
                            CitationCounter(
                              count: citations[citationNumber].count.toString(),
                            ),
                            NavigationButton(
                              isNext: true,
                              title: 'التالي',
                              onPress: () {
                                print('next');
                                nextCitation();
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              'عدد الأذكار',
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                            Text(
                              '$citationNumber / ${citations.length} ',
                              style: const TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
