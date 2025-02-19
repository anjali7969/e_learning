import 'package:e_learning/features/courses/domain/use_case/get_courses_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'course_state.dart';

class CourseCubit extends Cubit<CourseState> {
  final GetCourses getCoursesUseCase;

  CourseCubit(this.getCoursesUseCase) : super(CourseInitial());

  void fetchCourses() async {
    emit(CourseLoading());

    final result = await getCoursesUseCase();

    result.fold(
      (failure) => emit(CourseError(failure.message)),
      (courses) => emit(CourseLoaded(courses)),
    );
  }
}
