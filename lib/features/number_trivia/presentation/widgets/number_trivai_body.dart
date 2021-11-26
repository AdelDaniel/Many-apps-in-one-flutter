import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../connection_check/widget/no_internet_widget.dart';
import 'bottom_half_widget.dart';
import 'top_half_widget.dart';

class NumberTriviaBody extends StatelessWidget {
  const NumberTriviaBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          const NoInternetWidget(),
          const SizedBox(height: 10),
          // Top half
          SizedBox(
            // Third of the size of the screen
            height: MediaQuery.of(context).size.height / 3,
            // Message Text widgets / CircularLoadingIndicator
            child: const TopHalf(),
          ),
          const SizedBox(height: 20),
          // Bottom half
          BottomHalf(),
        ],
      ),
    );
  }
}
