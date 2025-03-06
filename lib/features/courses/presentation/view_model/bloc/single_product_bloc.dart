// import 'package:bloc/bloc.dart';
// import 'package:dartz/dartz.dart';
// import 'package:e_learning/core/error/failure.dart';
// import 'package:e_learning/features/courses/domain/entity/course_entity.dart';
// import 'package:e_learning/features/courses/domain/use_case/get_courses_by_id_usecase.dart';
// import 'package:e_learning/features/courses/presentation/view_model/bloc/single_product_event.dart';
// import 'package:e_learning/features/courses/presentation/view_model/bloc/single_product_state.dart';

// /// **📌 Single Course Bloc for Handling Course Details**
// class SingleCourseBloc extends Bloc<SingleCourseEvent, SingleCourseState> {
//   final GetCourseByIdUseCase _getCourseByIdUseCase;

//   SingleCourseBloc({required GetCourseByIdUseCase getCourseByIdUseCase})
//       : _getCourseByIdUseCase = getCourseByIdUseCase,
//         super(SingleCourseInitial()) {
//     on<LoadSingleCourse>(_onLoadSingleCourse);
//   }

//   /// **📌 Fetch Single Course by ID**
//   Future<void> _onLoadSingleCourse(
//       LoadSingleCourse event, Emitter<SingleCourseState> emit) async {
//     emit(SingleCourseLoading());

//     final Either<Failure, CourseEntity> result =
//         await _getCourseByIdUseCase.call(
//       GetCourseByIdParams(courseId: event.courseId),
//     );

//     result.fold(
//       (failure) => emit(SingleCourseError(failure.message)),
//       (course) => emit(SingleCourseLoaded(course: course)),
//     );
//   }
// }
