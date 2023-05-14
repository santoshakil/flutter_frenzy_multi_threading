import 'package:flutter/material.dart';
import 'package:flutter_frenzy_multi_threading/utils/constant.dart';
import 'package:flutter_frenzy_multi_threading/utils/light.theme.dart';

import 'enum/task.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: DefaultTabController(
              length: Tasks.values.length,
              child: NestedScrollView(
                headerSliverBuilder: (_, __) => [
                  SliverToBoxAdapter(
                    child: TabBar(
                      splashBorderRadius: borderRadius30,
                      isScrollable: true,
                      physics: const BouncingScrollPhysics(),
                      labelStyle: Theme.of(context).textTheme.labelLarge,
                      tabs: List.generate(
                        Tasks.values.length,
                        (index) => Tab(
                          child: Text(Tasks.values[index].title),
                        ),
                      ),
                    ),
                  ),
                ],
                body: TabBarView(
                  children: List.generate(
                    Tasks.values.length,
                    (index) => Tasks.values[index].view,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
