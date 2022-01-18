// import 'package:flutter/material.dart';

// class SelectAudioList extends StatefulWidget {
//   SelectAudioList({Key? key}) : super(key: key);

//   @override
//   _SelectAudioListState createState() => _SelectAudioListState();
// }

// class _SelectAudioListState extends State<SelectAudioList> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: audio.length,
//       itemBuilder: (_, index) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(vertical: 5.0),
//           child: Container(
//             child: ListTile(
//               title: Text(
//                 audio[index].name,
//                 style: const TextStyle(color: Color(0xFF3A3A55)),
//               ),
//               subtitle: const Text(
//                 "30 минут",
//                 style: TextStyle(color: Color(0x803A3A55)),
//               ),
//               leading: IconButton(
//                 icon: audioProvider.audioName == audio[index].name
//                     ? Image(
//                         image: AppIcons.pause,
//                         color: AppColors.purpule,
//                       )
//                     : Image(
//                         image: AppIcons.play,
//                       ),
//                 onPressed: () {
//                   Scaffold.of(context).showBottomSheet(
//                     (context) => PlayerOnProgress(
//                       soundsList: audio,
//                       index: index,
//                       repeat: false,
//                       cycle: false,
//                       audioProvider: audioProvider,
//                     ),
//                   );
//                 },
//               ),
//               trailing: GestureDetector(
//                 onTap: () {
//                   if (select[index] == false) {
//                     select[index] = true;
//                     playList.add(audio[index]);
//                     setState(() {
//                       select;
//                     });
//                   } else {
//                     select[index] = false;
//                     playList.removeWhere(
//                       (element) => element == audio[index].id,
//                     );
//                     setState(() {
//                       select;
//                     });
//                   }
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(100),
//                       border: Border.all(width: 2, color: Colors.black)),
//                   child: Image(
//                     image: AppIcons.complite,
//                     color: select[index] ? Colors.black : Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(75),
//               border: Border.all(
//                 color: Colors.grey,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
