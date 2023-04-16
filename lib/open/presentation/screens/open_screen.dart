import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laboratory/constants.dart';
import 'package:laboratory/shared/data/data_source/get_appoitment_data.dart';
import 'package:laboratory/shared/presentation/model/appoitment_model.dart';
import 'package:laboratory/shared/presentation/screens/appoitment_detail_screen.dart';
import 'package:laboratory/shared/presentation/widget/show_card.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:skeletons/skeletons.dart';

import '../../../shared/presentation/widget/card_detail.dart';
import 'package:intl/intl.dart';

class OpenScreen extends StatefulWidget {
  final String staffId;
  const OpenScreen({Key? key, required this.staffId}) : super(key: key);

  @override
  State<OpenScreen> createState() => _OpenScreenState();
}

class _OpenScreenState extends State<OpenScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: ShowCard(staffId: widget.staffId, status: 'Open')
    );
  }
}
