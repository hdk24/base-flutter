import 'package:base_flutter/src/core/utils/date_time_util.dart';
import 'package:base_flutter/src/presentation/utils/build_context_extension.dart';
import 'package:flutter/material.dart';

class HomeCurrentDateText extends StatelessWidget {
  const HomeCurrentDateText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      DateTimeUtil.convertToString(
        DateTime.now(),
        DateTimeUtil.EEE_MMMM_DD_YYYY,
      ),
      style: context.textTheme.bodySmall,
    );
  }
}
