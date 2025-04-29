import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseState<T extends StatefulWidget, S extends Cubit>
    extends State<T> {
  late S stateManager;

  S getStateManager();

  Widget buildView(BuildContext context);

  @override
  void initState() {
    super.initState();
    stateManager = getStateManager();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => stateManager,
      child: buildView(context),
    );
  }

  @override
  void dispose() {
    stateManager.close();
    super.dispose();
  }
}
