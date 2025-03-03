// import 'package:bloc/bloc.dart';
// import 'package:dartz/dartz.dart';
// import 'package:e_learning/core/error/failure.dart';
// import 'package:e_learning/features/courses/domain/entity/course_entity.dart';
// import 'package:e_learning/features/courses/domain/use_case/get_courses_by_id_usecase.dart';
// import 'package:e_learning/features/courses/domain/use_case/get_courses_usecase.dart';
// import 'package:equatable/equatable.dart';

// part 'course_event.dart';
// part 'course_state.dart';

// /// **📌 Course Bloc for Managing State & Events**
// class CourseBloc extends Bloc<CourseEvent, CourseState> {
//   final GetAllCourseUseCase _getAllCourseUseCase;
//   final GetCourseByIdUseCase _getCourseByIdUseCase;

//   CourseBloc({
//     required GetAllCourseUseCase getAllCourseUseCase,
//     required GetCourseByIdUseCase getCourseByIdUseCase,
//   })  : _getAllCourseUseCase = getAllCourseUseCase,
//         _getCourseByIdUseCase = getCourseByIdUseCase,
//         super(CourseState.initial()) {
//     on<LoadCourses>(_onLoadCourses);
//     on<LoadCourseById>(_onLoadCourseById);

//     // ✅ Trigger initial loading
//     add(LoadCourses());
//   }

//   /// **📌 Load All Courses**
//   Future<void> _onLoadCourses(
//       LoadCourses event, Emitter<CourseState> emit) async {
//     emit(state.copyWith(isLoading: true));
//     final Either<Failure, List<CourseEntity>> result =
//         await _getAllCourseUseCase.call();
//     result.fold(
//       (failure) =>
//           emit(state.copyWith(isLoading: false, error: failure.message)),
//       (courses) =>
//           emit(state.copyWith(isLoading: false, error: null, courses: courses)),
//     );
//   }

//   /// **📌 Load Course by ID**
//   /// **📌 Load Course by ID**
//   Future<void> _onLoadCourseById(
//       LoadCourseById event, Emitter<CourseState> emit) async {
//     emit(state.copyWith(isLoading: true));

//     // ✅ Fix: Wrap courseId inside `GetCourseByIdParams`
//     final Either<Failure, CourseEntity> result = await _getCourseByIdUseCase
//         .call(GetCourseByIdParams(courseId: event.courseId));

//     result.fold(
//       (failure) =>
//           emit(state.copyWith(isLoading: false, error: failure.message)),
//       (course) => emit(state.copyWith(
//           isLoading: false, error: null, selectedCourse: course)),
//     );
//   }
// }
