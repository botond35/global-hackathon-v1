import 'package:flutter/material.dart';
import 'package:gym_bro/data/notifier.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedpageNotifier,
      builder: (context, selectedPage, child) {
        return NavigationBar(
          destinations: [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.person), label: 'Bro'),
            NavigationDestination(icon: Icon(Icons.qr_code), label: 'Scann'),
          ],
          onDestinationSelected: (int value) {
            selectedpageNotifier.value = value;
          },
          selectedIndex: selectedPage,
        );
      },
    );
  }
}
