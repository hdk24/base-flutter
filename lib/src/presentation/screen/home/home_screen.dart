import 'package:base_flutter/src/core/di/injector.dart';
import 'package:base_flutter/src/domain/entities/result.dart';
import 'package:base_flutter/src/presentation/components/base/base_stateful_widget.dart';
import 'package:base_flutter/src/presentation/components/loadings/circle_progress_loading.dart';
import 'package:base_flutter/src/presentation/resources/dimens.dart';
import 'package:base_flutter/src/presentation/screen/home/cubit/home_cubit.dart';
import 'package:base_flutter/src/presentation/screen/home/cubit/home_state.dart';
import 'package:base_flutter/src/presentation/screen/home/widgets/home_current_date_text.dart';
import 'package:base_flutter/src/presentation/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = 'Homepage';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen, HomeCubit> {
  @override
  HomeCubit getStateManager() => injector<HomeCubit>();

  @override
  void initState() {
    super.initState();
    onRefresh();
  }

  void onRefresh() {
    stateManager.getCounterValue();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 64,
        title: Column(
          children: [
            Text(context.str.helloWorld),
            const HomeCurrentDateText(),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: _buildCounterValue()),
          Container(
            height: context.screenHeight / 4,
            width: context.screenWidth,
            padding: EdgeInsets.all(DimenRes.padding_lg),
            child: _buildActionButton(context),
          )
        ],
      ),
    );
  }

  Widget _buildCounterValue() {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (p, q) => p.counterResult != q.counterResult,
      builder: (ctx, state) {
        int value = 0;
        final result = state.counterResult;
        if (result is LoadingState) {
          return const Expanded(child: CircleProgressLoading());
        }
        if (result is SuccessState<int>) {
          value = result.data;
        }
        return Center(
          child: Text(
            value.toString(),
            style: context.textTheme.titleLarge?.copyWith(fontSize: 132),
          ),
        );
      },
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton.filledTonal(
          onPressed: () => stateManager.decrementValue(),
          padding: EdgeInsets.all(DimenRes.padding_lg),
          icon: const Icon(Icons.remove_rounded),
        ),
        IconButton.outlined(
          onPressed: () => stateManager.resetCounter(),
          padding: EdgeInsets.all(DimenRes.padding_lg),
          icon: const Icon(Icons.refresh),
        ),
        IconButton.filled(
          onPressed: () => stateManager.incrementValue(),
          padding: EdgeInsets.all(DimenRes.padding_lg),
          icon: const Icon(Icons.add_rounded),
        ),
      ],
    );
  }
}
