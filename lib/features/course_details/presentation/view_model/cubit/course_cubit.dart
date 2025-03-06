// import 'package:dartz/dartz.dart';
// import 'package:e_learning/core/error/failure.dart';
// import 'package:e_learning/features/course_details/domain/entity/course_details_entity.dart';
// import 'package:e_learning/features/course_details/domain/use_case/get_course_by_id_usecase.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class CourseDetailsState {
//   final bool isLoading;
//   final CourseDetailsEntity? course;
//   final String? error;

//   CourseDetailsState({required this.isLoading, this.course, this.error});

//   factory CourseDetailsState.initial() => CourseDetailsState(isLoading: false);

//   CourseDetailsState copyWith({
//     bool? isLoading,
//     CourseDetailsEntity? course,
//     String? error,
//   }) {
//     return CourseDetailsState(
//       isLoading: isLoading ?? this.isLoading,
//       course: course ?? this.course,
//       error: error ?? this.error,
//     );
//   }
// }

// class CourseDetailsCubit extends Cubit<CourseDetailsState> {
//   final GetCourseByIdUseCase getCourseByIdUseCase;

//   CourseDetailsCubit(this.getCourseByIdUseCase)
//       : super(CourseDetailsState.initial());

//   /// ✅ **Fetch Course Details**
//   Future<void> fetchCourseDetails(String courseId) async {
//     emit(state.copyWith(isLoading: true, error: null));

//     final Either<Failure, CourseDetailsEntity> result =
//         await getCourseByIdUseCase(courseId);

//     result.fold(
//       (failure) =>
//           emit(state.copyWith(isLoading: false, error: failure.message)),
//       (course) => emit(state.copyWith(isLoading: false, course: course)),
//     );
//   }
// }
