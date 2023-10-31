import 'package:flutter/material.dart';

class FutureAndStream extends StatefulWidget {
  const FutureAndStream({super.key});

  @override
  State<FutureAndStream> createState() => _FutureAndStreamState();
}

class _FutureAndStreamState extends State<FutureAndStream> {
// FutureBuilder
  Future<int> futureCounter(int counter) async {
    await Future.delayed(const Duration(seconds: 2));
    return counter + counter;
  }

// Stream Builder

  Stream<int> streamCounter(int counter) async* {
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      yield counter++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Future and Stream Builder"),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FutureBuilder(
                  future: futureCounter(10),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    return Text(
                      "Future: ${snapshot.data}",
                      style: const TextStyle(fontSize: 30),
                    );
                  }),
// Stream Builder
              StreamBuilder(
                  stream: streamCounter(10),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return LinearProgressIndicator();
                    }
                    return Text(
                      "Stream ${snapshot.data}",
                      style: const TextStyle(fontSize: 30),
                    );
                  }),
            ],
          ),
        ));
  }
}
