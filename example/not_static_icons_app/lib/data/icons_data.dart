import 'package:flutter/material.dart';
import 'package:not_static_icons_app/icons/align_center_horizontal_icon.dart';
import 'package:not_static_icons_app/icons/align_center_vertical_icon.dart';
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
import '../icons/alarm_smoke_icon.dart';
import '../icons/album_icon.dart';
import '../icons/align_center_icon.dart';
import '../icons/align_left_icon.dart';
import '../icons/align_right_icon.dart';
import '../icons/align_justify_icon.dart';
import '../icons/align_end_horizontal_icon.dart';
import '../icons/align_end_vertical_icon.dart';
import '../icons/align_start_horizontal_icon.dart';
import '../icons/align_start_vertical_icon.dart';
import '../icons/align_horizontal_distribute_center_icon.dart';
import '../icons/align_vertical_distribute_center_icon.dart';

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
  IconData(name: 'alarm-smoke', widget: AlarmSmokeIcon(size: 40)),
  IconData(name: 'album', widget: AlbumIcon(size: 40)),
  IconData(name: 'align-center', widget: AlignCenterIcon(size: 40)),
  IconData(name: 'align-left', widget: AlignLeftIcon(size: 40)),
  IconData(name: 'align-right', widget: AlignRightIcon(size: 40)),
  IconData(name: 'align-justify', widget: AlignJustifyIcon(size: 40)),
  IconData(
    name: 'align-center-horizontal',
    widget: AlignCenterHorizontalIcon(size: 40),
  ),
  IconData(
    name: 'align-center-vertical',
    widget: AlignCenterVerticalIcon(size: 40),
  ),
  IconData(
    name: 'align-end-horizontal',
    widget: AlignEndHorizontalIcon(size: 40),
  ),
  IconData(name: 'align-end-vertical', widget: AlignEndVerticalIcon(size: 40)),
  IconData(
    name: 'align-start-horizontal',
    widget: AlignStartHorizontalIcon(size: 40),
  ),
  IconData(
    name: 'align-start-vertical',
    widget: AlignStartVerticalIcon(size: 40),
  ),
  IconData(
    name: 'align-horizontal-distribute-center',
    widget: AlignHorizontalDistributeCenterIcon(size: 40),
  ),
  IconData(
    name: 'align-vertical-distribute-center',
    widget: AlignVerticalDistributeCenterIcon(size: 40),
  ),
];
