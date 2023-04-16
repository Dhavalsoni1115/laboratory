import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laboratory/constants.dart';
import 'package:laboratory/shared/presentation/screens/appoitment_detail_screen.dart';
import 'package:laboratory/shared/presentation/widget/show_card.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:skeletons/skeletons.dart';

import '../../../shared/presentation/widget/card_detail.dart';
import 'package:intl/intl.dart';

class OnGoingScreen extends StatelessWidget {
  final String staffId;
  const OnGoingScreen({Key? key, required this.staffId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: ShowCard(staffId: staffId, status: 'Ongoing'),
    );
  }
}
