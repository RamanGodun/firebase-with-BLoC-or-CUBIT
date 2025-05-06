// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ViewWrapper<T extends BlocBase<S>, S> extends StatelessWidget {
//   final Widget child;
//   const ViewWrapper({required this.child, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<T, S>(
//       listenWhen: (prev, curr) => curr is FailureStateMixin,
//       listener: (context, state) {
//         if (state is FailureStateMixin) {
//           state.failure?.handleSnackBar(context);
//         }
//       },
//       child: child,
//     );
//   }
// }
