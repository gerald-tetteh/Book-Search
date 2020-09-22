/*
  * Author: Gerald Addo-Tetteh
  * Book Search App
  * Navigation Buttons
*/

/*
  This widget returns a row of buttons used to 
  navigate between each group of search results.
*/

import 'package:flutter/material.dart';

import '../global/custom_button.dart';
import '../../utils/text_util.dart';
import '../../models/book_model.dart';

class NavigationButtons extends StatelessWidget {
  const NavigationButtons({
    Key key,
    @required this.textUtil,
    @required this.nextFunction,
    @required this.previousFunction,
    @required this.bookProvider,
  }) : super(key: key);

  final TextUtil textUtil;
  final Function() nextFunction;
  final Function() previousFunction;
  final BookModelProvider bookProvider;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          if (!(bookProvider.startIndex > 40))
            Padding(
              padding: EdgeInsets.only(
                top: 8.0,
                bottom: 8.0,
                left: bookProvider.startIndex > 40 ? 4.0 : 0.0,
              ),
              child: CustomButton(
                textUtil: textUtil,
                onPressed: nextFunction,
                text: "Next",
              ),
            ),
          if (bookProvider.startIndex > 40)
            FittedBox(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      bottom: 8.0,
                      right: 4.0,
                    ),
                    child: CustomButton(
                      text: "Back",
                      onPressed: previousFunction,
                      textUtil: textUtil,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 8.0,
                      bottom: 8.0,
                      left: 4.0,
                    ),
                    child: CustomButton(
                      textUtil: textUtil,
                      onPressed: nextFunction,
                      text: "Next",
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
