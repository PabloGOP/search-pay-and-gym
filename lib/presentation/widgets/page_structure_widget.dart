import 'package:flutter/material.dart';
import 'package:spag/presentation/widgets/nav_bar.dart';

class CommonPageStructure extends StatelessWidget {
  final Widget child;
  final String title;

  const CommonPageStructure(
      {super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBar(withBorder: false),
      body: Column(
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Center(
                child: SingleChildScrollView(
                    child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: child,
            ))),
          ),
        ],
      ),
    );
  }
}
