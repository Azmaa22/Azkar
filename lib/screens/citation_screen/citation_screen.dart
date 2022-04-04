import 'package:flutter/material.dart';
import 'package:flutter_apps/data/models/citation_model.dart';
import 'package:flutter_apps/data/repos/citation_repo.dart';
import 'package:flutter_apps/screens/citation_screen/widgets/app_bar_container.dart';
import 'package:flutter_apps/screens/citation_screen/widgets/citation_container.dart';
import 'package:flutter_apps/screens/citation_screen/widgets/citation_counter.dart';
import 'package:flutter_apps/screens/citation_screen/widgets/navigation_button.dart';
import 'package:flutter_apps/utilities/constants/app_colors.dart';

class CitationScreen extends StatefulWidget {
  final String currentCitation;
  const CitationScreen({Key? key, required this.currentCitation})
      : super(key: key);

  @override
  State<CitationScreen> createState() =>
      // ignore: no_logic_in_create_state
      _CitationScreenState(currentCitation: currentCitation);
}

class _CitationScreenState extends State<CitationScreen> {
  final String currentCitation;
  _CitationScreenState({required this.currentCitation});
  late List<Citation> citations;
  int citationNumber = 0;
  int completeNumber = 0;

  @override
  void initState() {
    super.initState();
    completeNumber = 0;
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

  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
              child: PageView.builder(
                controller: _pageController,
                itemCount: citations.length,
                itemBuilder: (
                  BuildContext context,
                  int index,
                ) {
                  citationNumber = index;
                  return CustomScrollView(
                    shrinkWrap: true,
                    slivers: [
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            CitationContainer(
                              citationText: citations[citationNumber].reference,
                              isReference: true,
                            ),
                            CitationContainer(
                              citationText: citations[index].zekr,
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
                              citationText:
                                  citations[citationNumber].description,
                              isReference: true,
                            ),
                          ],
                        ),
                      ),
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(
                              bottom: size.height * 0.15,
                              left: 10.0,
                              right: 10.0,
                              top: 10.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                NumberContainer(
                                  title: '${citations[citationNumber].count}',
                                  isLeft: false,
                                ),
                                CitationCounter(
                                  count: completeNumber.toString(),
                                  onPress: () {
                                    setState(() {
                                      completeNumber += 1;
                                      if (completeNumber ==
                                          citations[citationNumber].count) {
                                        _pageController.nextPage(
                                          duration:
                                              const Duration(milliseconds: 400),
                                          curve: Curves.easeInOut,
                                        );
                                        completeNumber = 0;
                                      }
                                    });
                                  },
                                ),
                                NumberContainer(
                                  isLeft: true,
                                  title:
                                      '${citationNumber + 1} / ${citations.length} ',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
