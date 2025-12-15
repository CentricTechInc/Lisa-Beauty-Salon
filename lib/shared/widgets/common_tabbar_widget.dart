import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';

/// Use this widget, if the tab content is of finite height
class CommonTabBarWidgetOne extends StatefulWidget {
  const CommonTabBarWidgetOne({
    super.key,
    required this.tabs,
    required this.tabViews,
    this.onTap,
    this.isScrollable = false,
    this.heightFactor = 0.058,
    this.onTabChange,
  }) : assert(tabs.length == tabViews.length,
  'Tabs and TabViews must match in length');

  final List<String> tabs;

  final List<Widget> tabViews;

  final Function(int)? onTap;
  final Function(int)? onTabChange;

  final bool isScrollable;

  final double heightFactor;

  @override
  State<CommonTabBarWidgetOne> createState() => _CommonTabBarWidgetOneState();
}

class _CommonTabBarWidgetOneState extends State<CommonTabBarWidgetOne>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.tabs.length, vsync: this);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging == false &&
          _tabController.index == _tabController.previousIndex) {
        return;
      }

      if (!_tabController.indexIsChanging) {
        widget.onTabChange?.call(_tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.transparent,
        borderRadius: BorderRadius.circular(
          20
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 15
            ),
            child: Container(
              height: height * widget.heightFactor,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10
                ),
                border: Border.all(
                  color: AppColors.greyOne
                ),
                color: AppColors.transparent,
              ),
              child: TabBar(
                controller: _tabController,
                onTap: widget.onTap,
                isScrollable: widget.isScrollable,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorAnimation: TabIndicatorAnimation.elastic,
                dividerColor: AppColors.transparent,
                labelColor: AppColors.whiteTwo,
                unselectedLabelColor: AppColors.blackTwo,
                labelStyle: TextStyle(
                  color: AppColors.whiteTwo,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  fontFamily: Strings.fontFamily,
                  fontStyle: FontStyle.normal
                ),
                unselectedLabelStyle: TextStyle(
                  color: AppColors.blackTwo,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  fontFamily: Strings.fontFamily,
                  fontStyle: FontStyle.normal
                ),
                indicator: BoxDecoration(
                  color: AppColors.blackThree,
                  borderRadius: BorderRadius.circular(8),
                ),
                tabs: widget.tabs.map((title) => Text(
                  title,
                )).toList(),
              ),
            ),
          ),
          const VerticalSpacing(10),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: widget.tabViews,
            ),
          ),
        ],
      ),
    );
  }
}

/// Use this widget, if the tab content is of infinite height
class CommonTabBarWidgetTwo extends StatefulWidget {
  const CommonTabBarWidgetTwo({
    super.key,
    required this.tabs,
    required this.tabViews,
    this.onTap,
    this.onTabChange,
    this.isScrollable = false,
    this.heightFactor = 0.058,
  }) : assert(tabs.length == tabViews.length,
  'Tabs and TabViews must match in length');

  final List<String> tabs;
  final List<Widget> tabViews;
  final Function(int)? onTap;
  final Function(int)? onTabChange;
  final bool isScrollable;
  final double heightFactor;

  @override
  State<CommonTabBarWidgetTwo> createState() => _CommonTabBarWidgetTwoState();
}

class _CommonTabBarWidgetTwoState extends State<CommonTabBarWidgetTwo>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.tabs.length, vsync: this);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging == false &&
          _tabController.index == _tabController.previousIndex) {
        return;
      }

      if (!_tabController.indexIsChanging) {
        widget.onTabChange?.call(_tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = context.height;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.transparent,
        borderRadius: BorderRadius.circular(
          20
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12, 
              vertical: 8
            ),
            child: Container(
              height: height * widget.heightFactor,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10
                ),
                border: Border.all(
                  color: AppColors.greyOne
                ),
                color: AppColors.transparent,
              ),
              child: TabBar(
                controller: _tabController,
                onTap: widget.onTap,
                isScrollable: widget.isScrollable,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorAnimation: TabIndicatorAnimation.elastic,
                dividerColor: AppColors.transparent,
                labelColor: AppColors.whiteOne,
                unselectedLabelColor: AppColors.blackTwo,
                labelStyle: TextStyle(
                  color: AppColors.whiteOne,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  fontFamily: Strings.fontFamily,
                  fontStyle: FontStyle.normal
                ),
                unselectedLabelStyle: TextStyle(
                  color: AppColors.blackTwo,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  fontFamily: Strings.fontFamily,
                  fontStyle: FontStyle.normal
                ),
                indicator: BoxDecoration(
                  color: AppColors.blackThree,
                  borderRadius: BorderRadius.circular(8),
                ),
                tabs: widget.tabs.map((title) => Text(
                  title,
                )).toList(),
              ),
            ),
          ),
          const VerticalSpacing(10),
          AnimatedBuilder(
            animation: _tabController,
            builder: (BuildContext context, Widget? child) {
              return widget.tabViews[_tabController.index];
            }
          ),
        ],
      ),
    );
  }
}
