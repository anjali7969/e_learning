// import 'package:e_learning/features/onboarding/presentation/view_model/cubit/onboarding_cubit.dart';
// import 'package:e_learning/features/onboarding/presentation/view_model/onboarding_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class OnboardingView extends StatelessWidget {
//   const OnboardingView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => OnboardingCubit(),
//       child: BlocBuilder<OnboardingCubit, int>(
//         builder: (context, state) {
//           final onboardingCubit = context.read<OnboardingCubit>();

//           return Scaffold(
//             body: PageView.builder(
//               controller: PageController(initialPage: state),
//               onPageChanged: onboardingCubit.jumpToPage,
//               itemCount: onboardingCubit.pages.length,
//               itemBuilder: (context, index) => onboardingCubit.pages[index],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
