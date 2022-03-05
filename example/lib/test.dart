import 'dart:async';

import 'package:example/widget/sample_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final scrollDirection = Axis.vertical;

  int _count = 5;

  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration(seconds: 1), () {
    //   PrimaryScrollController.of(context)!.position.jumpTo(-70);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EasyRefresh'),
      ),
      body: EasyRefresh(
        onRefresh: () async {
          print('Refreshing');
          await Future.delayed(const Duration(seconds: 2));
          setState(() {
            _count = 5;
          });
          print('Refreshed');
          return IndicatorResult.noMore;
        },
        onLoad: () async {
          print('Loading');
          await Future.delayed(const Duration(seconds: 2));
          setState(() {
            _count += 5;
          });
          print('Loaded');
          return IndicatorResult.noMore;
        },
        // child: ListView.builder(
        //   padding: EdgeInsets.zero,
        //   scrollDirection: scrollDirection,
        //   itemCount: _count,
        //   itemBuilder: (context, index) {
        //     return SampleListItem(
        //       direction: scrollDirection,
        //       width: scrollDirection == Axis.vertical ? double.infinity : 200,
        //     );
        //   },
        // ),
        // child: ListView(
        //   scrollDirection: scrollDirection,
        //   reverse: true,
        //   children: [
        //     const HeaderLocator(),
        //     for (int i = 0; i < _count; i++)
        //       SampleListItem(
        //         direction: scrollDirection,
        //         width: scrollDirection == Axis.vertical ? double.infinity : 200,
        //       ),
        //     const FooterLocator(),
        //   ],
        // ),
        child: CustomScrollView(
          scrollDirection: scrollDirection,
          reverse: false,
          slivers: [
            const HeaderLocator.sliver(),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return SampleListItem(
                    direction: scrollDirection,
                    width: scrollDirection == Axis.vertical
                        ? double.infinity
                        : 200,
                  );
                },
                childCount: _count,
              ),
            ),
            const FooterLocator.sliver(),
          ],
        ),
      ),
    );
  }
}
