// import 'package:e_learning/features/courses/domain/use_case/get_courses_usecase.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'course_state.dart';

// class CourseCubit extends Cubit<CourseState> {
//   final GetCourses getCoursesUseCase;

//   CourseCubit(this.getCoursesUseCase) : super(CourseInitial());

//   void fetchCourses() async {
//     emit(CourseLoading());

//     final result = await getCoursesUseCase();

//     result.fold(
//       (failure) => emit(CourseError(failure.message)),
//       (courses) => emit(CourseLoaded(courses)),
//     );
//   }
// }

import 'package:e_learning/features/cart/domain/entity/cart_entity.dart';
import 'package:e_learning/features/cart/domain/use_case/get_cart_usecase.dart';
import 'package:e_learning/features/courses/domain/use_case/get_courses_usecase.dart';
import 'package:e_learning/features/courses/presentation/view_model/cubit/course_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseCubit extends Cubit<CourseState> {
  final GetCourses getCoursesUseCase;
  final GetCartUsecase getCartUseCase; // ✅ Added GetCartUsecase

  CourseCubit({required this.getCoursesUseCase, required this.getCartUseCase})
      : super(CourseInitial());

  /// ✅ Fetch Courses
  void fetchCourses() async {
    emit(CourseLoading());

    final result = await getCoursesUseCase();

    result.fold(
      (failure) => emit(CourseError(failure.message)),
      (courses) => emit(CourseLoaded(courses)),
    );
  }

  /// ✅ Fetch Cart for User
  Future<Cart?> fetchCart(String userId) async {
    final result = await getCartUseCase(userId);

    return result.fold(
      (failure) {
        emit(CourseError(failure.message)); // ✅ Handle cart error if needed
        return null;
      },
      (cart) => cart,
    );
  }
}
