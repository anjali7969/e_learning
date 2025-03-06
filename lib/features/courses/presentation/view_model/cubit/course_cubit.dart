import 'dart:async';

import 'package:e_learning/features/courses/data/model/course_api_model.dart';
import 'package:e_learning/features/courses/domain/entity/course_entity.dart';
import 'package:e_learning/features/courses/domain/use_case/get_courses_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'course_state.dart';

class CoursesCubit extends Cubit<CoursesState> {
  final GetCoursesUsecase getCoursesUsecase;
  CoursesCubit(this.getCoursesUsecase) : super(const CoursesLoading());

  int page = 1;
  Timer? _debounce;
  final String _currentSearchQuery = '';

  Future<void> loadCourses([CourseApiModel? request]) async {
    emit(const CoursesLoading());
    page = 1;

    CourseApiModel courseRequest = request ??
        CourseApiModel(
          title: _currentSearchQuery,
          description: '',
          price: 0.0,
          videoUrl: '', // ✅ Added videoUrl (default empty if null)
        );

    final result = await getCoursesUsecase(courseRequest);
    result.fold(
      (l) => emit(CoursesError(l.message)),
      (r) => emit(CoursesLoaded(courses: r)),
    );
  }

  /// **📌 Load More Courses**
  Future<void> loadMoreCourses([CourseApiModel? request]) async {
    if (state is! CoursesLoaded) return;
    page++;

    CourseApiModel courseRequest = request ??
        CourseApiModel(
          title: _currentSearchQuery,
          description: '',
          price: 0.0,
          videoUrl: '', // ✅ Ensure videoUrl is handled
        );

    final result = await getCoursesUsecase(courseRequest);
    result.fold(
      (l) => emit(CoursesError(l.message)),
      (r) {
        final currentState = state as CoursesLoaded;
        emit(CoursesLoaded(courses: [...currentState.courses, ...r]));
      },
    );
  }

  /// **🔹 Open Course Details**
  void openCourseDetails(CourseEntity course) {
    emit(NavigateToCourseDetails(course));
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
