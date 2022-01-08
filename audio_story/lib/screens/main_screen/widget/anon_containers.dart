import 'package:flutter/material.dart';

class AnonimContainers extends StatelessWidget {
  
  const AnonimContainers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Flexible(
            child: Container(
              alignment: Alignment.center,
              child: const Text(
                "Здесь будет твой набор сказок",
                style: TextStyle(fontSize: 24, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              decoration: BoxDecoration(
                color: const Color(0xD971A59F),
                border: Border.all(
                  color: const Color(0xD971A59F),
                ),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 10,
                    blurRadius: 10,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              height: 200,
            ),
            flex: 1,
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    "Тут",
                    style: TextStyle(fontSize: 24, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xD9F1B488),
                    border: Border.all(
                      color: const Color(0xD9F1B488),
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 10,
                        blurRadius: 10,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  height: 94,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    "И тут",
                    style: TextStyle(fontSize: 24, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xD9678BD2),
                    border: Border.all(
                      color: const Color(0xD9678BD2),
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 10,
                        blurRadius: 10,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  height: 94,
                ),
              ],
            ),
            flex: 1,
          ),
        ],
      ),
    );
  }
}
