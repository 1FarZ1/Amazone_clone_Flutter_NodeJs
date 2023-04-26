import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/loader.dart';
import '../../../models/sales.dart';
import '../view/widgets/category_product_chart.dart';
import 'controller/analytics_controller.dart';

class AnalyticsScreen extends ConsumerStatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends ConsumerState<AnalyticsScreen> {
  int? totalSales;
  List<Sales>? earnings;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getEarnings();
    });
  }

  getEarnings() async {
    ref.read(analyticsControllerProvider.notifier).getAnalytics();
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(analyticsControllerProvider).when(
      data: (earningData) {
        totalSales = earningData['totalEarnings'];
        earnings = earningData['sales'];
        return Column(
          children: [
            Text(
              '\$$totalSales',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 250,
              child: CategoryProductsChart(seriesList: [
                charts.Series(
                  id: 'Sales',
                  data: earnings!,
                  domainFn: (Sales sales, _) => sales.label,
                  measureFn: (Sales sales, _) => sales.earning,
                ),
              ]),
            )
          ],
        );
      },
      error: (error, stackTrace) {
        return Center(
          child: Text(error.toString()),
        );
      },
      loading: () {
        return const Center(
          child: Loader(),
        );
      },
    );
  }
}
