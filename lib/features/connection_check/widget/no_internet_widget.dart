import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xylophoneflutter/features/connection_check/cubit/is_connected_check_cubit.dart';

import '../cubit/connection_check_cubit.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<IsConnectedCheckCubit, bool>(
            buildWhen: (previous, current) {
          // return true/false to determine whether or not
          // to rebuild the widget with state
          print('\n\n ppppppppppp: $previous \n ccccccccccccc: $current \n');
          return true;
        }, builder: (context, state) {
          print('state changed $state \n ');
          if (state == true) {
            return Container(
              height: 20.0,
              color: Colors.green,
              child: const Text("Opss..22222222222222"),
            );
          } else if (state == false) {
            return Container(
              height: 20.0,
              color: Colors.red,
              child: const Text("Opss..111111111111"),
            );
          }
          return const SizedBox();
        }),
        BlocBuilder<ConnectionCheckCubit, bool>(buildWhen: (previous, current) {
          // return true/false to determine whether or not
          // to rebuild the widget with state
          print('\n\n ppppppppppp: $previous \n ccccccccccccc: $current \n');
          return true;
        }, builder: (context, state) {
          print('state changed $state \n ');
          if (state == true) {
            return const SizedBox();
          } else if (state == false) {
            return Container(
              height: 20.0,
              color: Colors.red,
              child: const Center(
                  child: Text(
                "Opss..  Check Inertnet connection !",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              )),
            );
          }
          return const SizedBox();
        }),
      ],
    );
  }
}
