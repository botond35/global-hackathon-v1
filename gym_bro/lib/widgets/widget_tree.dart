import 'package:flutter/material.dart';
import 'package:gym_bro/data/notifier.dart';
import 'package:gym_bro/pages/bro_page.dart';
import 'package:gym_bro/pages/home_page.dart';
import 'package:gym_bro/pages/scaan_page.dart';
import 'package:gym_bro/widgets/navbar_widget.dart';

List<Widget> pages = [HomePage(), BroPage(), ScaanPage()];

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavbarWidget(),
      body: ValueListenableBuilder(
        valueListenable: selectedpageNotifier,
        builder: (context, selectedPage, child) {
          return pages.elementAt(selectedPage);
        },
      ),
    );
  }
}
