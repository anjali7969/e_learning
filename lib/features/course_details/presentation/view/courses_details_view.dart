// import 'package:e_learning/features/course_details/presentation/view_model/cubit/course_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class CourseDetailsPage extends StatelessWidget {
//   final String courseId;

//   const CourseDetailsPage({super.key, required this.courseId});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CourseDetailsCubit, CourseDetailsState>(
//       builder: (context, state) {
//         if (state.isLoading) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (state.error != null) {
//           return Center(child: Text(state.error!));
//         }
//         final course = state.course!;

//         return Scaffold(
//           appBar: AppBar(
//             title: Text(course.title),
//           ),
//           body: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 Image.network(course.image),
//                 const SizedBox(height: 10),
//                 Text(course.title,
//                     style: const TextStyle(
//                         fontSize: 22, fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 5),
//                 Text(course.description),
//                 const SizedBox(height: 10),
//                 Text("Price: \$${course.price}",
//                     style: const TextStyle(
//                         fontSize: 18, fontWeight: FontWeight.bold)),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
