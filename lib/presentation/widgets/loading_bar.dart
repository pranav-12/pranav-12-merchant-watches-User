import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            backgroundColor: primaryBackgroundColor,
            color: primaryFontColor,
          ),
          ksizedBoxheight20,
          Text('Loading.........')
        ],
      ),
    );
  }
}
