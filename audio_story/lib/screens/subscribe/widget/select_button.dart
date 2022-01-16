import 'package:audio_story/resources/app_icons.dart';
import 'package:flutter/material.dart';

class SelectButton extends StatefulWidget {
  const SelectButton({Key? key}) : super(key: key);

  @override
  State<SelectButton> createState() => _SelectButtonState();
}

class _SelectButtonState extends State<SelectButton> {
  List<bool> selected = [false, false];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "300p",
                  style: TextStyle(fontSize: 26),
                ),
                const Text(
                  "в месяц",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    if (selected[0]) {
                      selected[0] = false;
                    } else {
                      selected = [true, false];
                    }
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(width: 2, color: Colors.black)),
                    child: Image(
                      image: AppIcons.complite,
                      color: selected[0] ? Colors.black : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            height: 215,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "1800р",
                  style: TextStyle(fontSize: 26),
                ),
                const Text(
                  "в год",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    if (selected[1]) {
                      selected[1] = false;
                    } else {
                      selected = [false, true];
                    }
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(width: 2, color: Colors.black)),
                    child: Image(
                      image: AppIcons.complite,
                      color: selected[1] ? Colors.black : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            height: 215,
          ),
        ),
      ],
    );
  }
}
