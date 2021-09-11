import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:number_trivia_tdd_riverpod/features/number_trivia/presentation/widgets/widgets.dart';
import 'package:number_trivia_tdd_riverpod/provider.dart';

class NumberTriviaPage extends ConsumerWidget {
  const NumberTriviaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final numberTriviaState = ref.watch(numberTriviaNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Trivia'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                numberTriviaState.map(
                  empty: (_) {
                    return const MessageDisplay(
                      message: 'Start Searching!',
                    );
                  },
                  loading: (_) {
                    return const LoadingWidget();
                  },
                  loaded: (_) {
                    return TriviaDisplay(
                      numberTrivia: _.trivia,
                    );
                  },
                  error: (_) {
                    return MessageDisplay(message: _.message);
                  },
                ),
                const SizedBox(height: 20),
                const TrivialControls(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
