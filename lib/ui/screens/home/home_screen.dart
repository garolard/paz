import 'package:flutter/material.dart';
import 'package:paz/ui/navigation/custom_page_route.dart';
import 'package:paz/ui/screens/exercises/breath_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Relájate')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Card(
              color: colorTheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Respiración 4-7-8', style: textTheme.headlineSmall),
                    Text(
                      'Ejercicio básico de respiración para relajarse',
                      style: textTheme.bodyMedium,
                    ),
                    LayoutBuilder(
                      builder: (ctx, constraints) {
                        return Container(
                          width: constraints.maxWidth,
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(CustomPageRoute(const BreathScreen()));
                            },
                            child: const Text('Comenzar'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
