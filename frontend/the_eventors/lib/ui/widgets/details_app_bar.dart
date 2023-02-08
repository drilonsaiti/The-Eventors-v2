import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DetailsAppBar extends StatelessWidget {
  const DetailsAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () {},
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              style: ButtonStyle(
                shape: MaterialStateProperty.all(const CircleBorder()),
                fixedSize: MaterialStateProperty.all(const Size(20, 20)),
                padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                backgroundColor:
                    MaterialStateProperty.all(Colors.white), // <-- Button color
                overlayColor:
                    MaterialStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.blueAccent; // <-- Splash color
                  }
                }),
              ),
            )),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.434,
        ),
        Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: ElevatedButton(
              onPressed: () {},
              child: const Icon(
                Icons.share,
                color: Colors.black,
              ),
              style: ButtonStyle(
                shape: MaterialStateProperty.all(const CircleBorder()),
                fixedSize: MaterialStateProperty.all(const Size(20, 20)),
                padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                backgroundColor:
                    MaterialStateProperty.all(Colors.white), // <-- Button color
                overlayColor:
                    MaterialStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.blueAccent; // <-- Splash color
                  }
                }),
              ),
            )),
        Padding(
            padding: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
            child: ElevatedButton(
              onPressed: () {},
              child: const Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              style: ButtonStyle(
                shape: MaterialStateProperty.all(const CircleBorder()),
                fixedSize: MaterialStateProperty.all(const Size(20, 20)),
                padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                backgroundColor:
                    MaterialStateProperty.all(Colors.white), // <-- Button color
                overlayColor:
                    MaterialStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.red; // <-- Splash color
                  }
                }),
              ),
            )),
      ],
    );
  }
}
