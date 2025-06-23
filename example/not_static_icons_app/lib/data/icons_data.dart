import 'package:flutter/material.dart';
import '../icons/a_arrow_down_icon.dart';
import '../icons/a_arrow_up_icon.dart';
import '../icons/a_large_small_icon.dart';
import '../icons/activity_icon.dart';

class IconData {
  final String name;
  final Widget widget;

  const IconData({required this.name, required this.widget});
}

// Icons data
final List<IconData> icons = [
  IconData(name: 'a-arrow-down', widget: AArrowDownIcon(size: 40)),
  IconData(name: 'a-arrow-up', widget: AArrowUpIcon(size: 40)),
  IconData(name: 'a-large-small', widget: ALargeSmallIcon(size: 40)),
  IconData(name: 'activity', widget: ActivityIcon(size: 40)),
];
