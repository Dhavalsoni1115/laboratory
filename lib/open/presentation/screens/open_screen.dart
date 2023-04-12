import 'package:flutter/material.dart';
import 'package:laboratory/constants.dart';
import 'package:laboratory/open/presentation/screens/open_detail_screen.dart';

import '../../../shared/presentation/widget/card_detail.dart';

class OpenScreen extends StatelessWidget {
  const OpenScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: CardDetail(
        name: 'Dhaval Soni',
        email: 'Dhaval@gmail.com',
        mobileNumber: '8320069125',
        date: '26 jan 2023',
        time: '12:40 PM',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OpenDetailScreen(),
            ),
          );
        },
      ),
    );
  }
}
