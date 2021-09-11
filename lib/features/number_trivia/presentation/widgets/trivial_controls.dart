import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:number_trivia_tdd_riverpod/features/number_trivia/presentation/provider/number_trivia_event.dart';
import 'package:number_trivia_tdd_riverpod/provider.dart';

class TrivialControls extends HookConsumerWidget {
  const TrivialControls({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inputStr = useState('');
    return Column(
      children: [
        TextField(
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input a number',
          ),
          onChanged: (value) {
            inputStr.value = value;
          },
          onSubmitted: (_) {
            ref
                .read(numberTriviaNotifierProvider.notifier)
                .mapEventToState(GetTriviaForConcreteNumber(inputStr.value));
            inputStr.value = '';
          },
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  ref
                      .read(numberTriviaNotifierProvider.notifier)
                      .mapEventToState(
                          GetTriviaForConcreteNumber(inputStr.value));
                  inputStr.value = '';
                },
                child: const Text('Search'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  ref
                      .read(numberTriviaNotifierProvider.notifier)
                      .mapEventToState(const GetTriviaForRandomNumber());
                },
                child: const Text('Get Random Trivia'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
