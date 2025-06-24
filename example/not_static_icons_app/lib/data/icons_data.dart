import 'package:flutter/material.dart';
import '../icons/a_arrow_down_icon.dart';
import '../icons/a_arrow_up_icon.dart';
import '../icons/a_large_small_icon.dart';
import '../icons/activity_icon.dart';
import '../icons/air_vent_icon.dart';
import '../icons/airplay_icon.dart';
import '../icons/alarm_clock_icon.dart';
import '../icons/alarm_clock_check_icon.dart';
import '../icons/alarm_clock_minus_icon.dart';
import '../icons/alarm_clock_plus_icon.dart';

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
  IconData(name: 'air-vent', widget: AirVentIcon(size: 40)),
  IconData(name: 'airplay', widget: AirplayIcon(size: 40)),
  IconData(name: 'alarm-clock', widget: AlarmClockIcon(size: 40)),
  IconData(name: 'alarm-clock-check', widget: AlarmClockCheckIcon(size: 40)),
  IconData(name: 'alarm-clock-minus', widget: AlarmClockMinusIcon(size: 40)),
  IconData(name: 'alarm-clock-plus', widget: AlarmClockPlusIcon(size: 40)),
];
