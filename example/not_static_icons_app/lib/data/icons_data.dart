import 'package:flutter/material.dart';
import 'package:not_static_icons_app/icons/align_center_horizontal_icon.dart';
import 'package:not_static_icons_app/icons/align_center_vertical_icon.dart';
import '../icons/a_arrow_down_icon.dart';
import '../icons/a_arrow_up_icon.dart';
import '../icons/a_large_small_icon.dart';
import '../icons/accessibility_icon.dart';
import '../icons/activity_icon.dart';
import '../icons/air_vent_icon.dart';
import '../icons/airplay_icon.dart';
import '../icons/alarm_clock_icon.dart';
import '../icons/alarm_clock_check_icon.dart';
import '../icons/alarm_clock_minus_icon.dart';
import '../icons/alarm_clock_plus_icon.dart';
import '../icons/alarm_clock_off_icon.dart';
import '../icons/alarm_smoke_icon.dart';
import '../icons/album_icon.dart';
import '../icons/ambulance_icon.dart';
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
import '../icons/align_horizontal_distribute_start_icon.dart';
import '../icons/align_horizontal_distribute_end_icon.dart';
import '../icons/align_vertical_distribute_start_icon.dart';
import '../icons/align_vertical_distribute_end_icon.dart';
import '../icons/align_horizontal_justify_end_icon.dart';
import '../icons/align_horizontal_justify_start_icon.dart';
import '../icons/align_vertical_justify_end_icon.dart';
import '../icons/align_vertical_justify_start_icon.dart';
import '../icons/align_vertical_space_around_icon.dart';
import '../icons/align_horizontal_space_around_icon.dart';
import '../icons/align_horizontal_space_between_icon.dart';
import '../icons/align_vertical_space_between_icon.dart';
import '../icons/align_horizontal_justify_center_icon.dart';
import '../icons/align_vertical_justify_center_icon.dart';
import '../icons/ampersand_icon.dart';
import '../icons/ampersands_icon.dart';
import '../icons/amphora_icon.dart';
import '../icons/anchor_icon.dart';
import '../icons/angry_icon.dart';
import '../icons/annoyed_icon.dart';
import '../icons/antenna_icon.dart';
import '../icons/anvil_icon.dart';
import '../icons/aperture_icon.dart';
import '../icons/app_window_mac_icon.dart';
import '../icons/app_window_icon.dart';
import '../icons/apple_icon.dart';
import '../icons/archive_icon.dart';
import '../icons/archive_restore_icon.dart';
import '../icons/archive_x_icon.dart';
import '../icons/armchair_icon.dart';
import '../icons/arrow_big_down_dash_icon.dart';
import '../icons/arrow_big_down_icon.dart';
import '../icons/arrow_big_left_dash_icon.dart';
import '../icons/arrow_big_left_icon.dart';
import '../icons/arrow_big_right_dash_icon.dart';
import '../icons/arrow_big_right_icon.dart';
import '../icons/arrow_big_up_dash_icon.dart';
import '../icons/arrow_big_up_icon.dart';

class IconData {
  final String name;
  final Widget widget;

  const IconData({required this.name, required this.widget});
}

// Icons data - automatically sorted alphabetically in UI
final List<IconData> icons = [
  IconData(name: 'a-arrow-down', widget: AArrowDownIcon(size: 40)),
  IconData(name: 'a-arrow-up', widget: AArrowUpIcon(size: 40)),
  IconData(name: 'a-large-small', widget: ALargeSmallIcon(size: 40)),
  IconData(name: 'accessibility', widget: AccessibilityIcon(size: 40)),
  IconData(name: 'activity', widget: ActivityIcon(size: 40)),
  IconData(name: 'air-vent', widget: AirVentIcon(size: 40)),
  IconData(name: 'airplay', widget: AirplayIcon(size: 40)),
  IconData(name: 'alarm-clock', widget: AlarmClockIcon(size: 40)),
  IconData(name: 'alarm-clock-check', widget: AlarmClockCheckIcon(size: 40)),
  IconData(name: 'alarm-clock-minus', widget: AlarmClockMinusIcon(size: 40)),
  IconData(name: 'alarm-clock-off', widget: AlarmClockOffIcon(size: 40)),
  IconData(name: 'alarm-clock-plus', widget: AlarmClockPlusIcon(size: 40)),
  IconData(name: 'alarm-smoke', widget: AlarmSmokeIcon(size: 40)),
  IconData(name: 'album', widget: AlbumIcon(size: 40)),
  IconData(name: 'ambulance', widget: AmbulanceIcon(size: 40)),
  IconData(name: 'ampersand', widget: AmpersandIcon(size: 40)),
  IconData(name: 'ampersands', widget: AmpersandsIcon(size: 40)),
  IconData(name: 'amphora', widget: AmphoraIcon(size: 40)),
  IconData(name: 'anchor', widget: AnchorIcon(size: 40)),
  IconData(name: 'angry', widget: AngryIcon(size: 40)),
  IconData(name: 'annoyed', widget: AnnoyedIcon(size: 40)),
  IconData(name: 'antenna', widget: AntennaIcon(size: 40)),
  IconData(name: 'anvil', widget: AnvilIcon(size: 40)),
  IconData(name: 'aperture', widget: ApertureIcon(size: 40)),
  IconData(name: 'apple', widget: AppleIcon(size: 40)),
  IconData(name: 'app-window-mac', widget: AppWindowMacIcon(size: 40)),
  IconData(name: 'archive', widget: ArchiveIcon(size: 40)),
  IconData(name: 'archive-restore', widget: ArchiveRestoreIcon(size: 40)),
  IconData(name: 'archive-x', widget: ArchiveXIcon(size: 40)),
  IconData(name: 'armchair', widget: ArmchairIcon(size: 40)),
  IconData(name: 'arrow-big-down', widget: ArrowBigDownIcon(size: 40)),
  IconData(name: 'arrow-big-down-dash', widget: ArrowBigDownDashIcon(size: 40)),
  IconData(name: 'arrow-big-left', widget: ArrowBigLeftIcon(size: 40)),
  IconData(name: 'arrow-big-left-dash', widget: ArrowBigLeftDashIcon(size: 40)),
  IconData(name: 'arrow-big-right', widget: ArrowBigRightIcon(size: 40)),
  IconData(
    name: 'arrow-big-right-dash',
    widget: ArrowBigRightDashIcon(size: 40),
  ),
  IconData(name: 'arrow-big-up', widget: ArrowBigUpIcon(size: 40)),
  IconData(name: 'arrow-big-up-dash', widget: ArrowBigUpDashIcon(size: 40)),
  IconData(name: 'app-window', widget: AppWindowIcon(size: 40)),
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
  IconData(
    name: 'align-horizontal-distribute-start',
    widget: AlignHorizontalDistributeStartIcon(size: 40),
  ),
  IconData(
    name: 'align-horizontal-distribute-end',
    widget: AlignHorizontalDistributeEndIcon(size: 40),
  ),
  IconData(
    name: 'align-vertical-distribute-start',
    widget: AlignVerticalDistributeStartIcon(size: 40),
  ),
  IconData(
    name: 'align-vertical-distribute-end',
    widget: AlignVerticalDistributeEndIcon(size: 40),
  ),
  IconData(
    name: 'align-horizontal-justify-end',
    widget: AlignHorizontalJustifyEndIcon(size: 40),
  ),
  IconData(
    name: 'align-horizontal-justify-start',
    widget: AlignHorizontalJustifyStartIcon(size: 40),
  ),
  IconData(
    name: 'align-vertical-justify-end',
    widget: AlignVerticalJustifyEndIcon(size: 40),
  ),
  IconData(
    name: 'align-vertical-justify-start',
    widget: AlignVerticalJustifyStartIcon(size: 40),
  ),
  IconData(
    name: 'align-vertical-space-around',
    widget: AlignVerticalSpaceAroundIcon(size: 40),
  ),
  IconData(
    name: 'align-vertical-space-between',
    widget: AlignVerticalSpaceBetweenIcon(size: 40),
  ),
  IconData(
    name: 'align-horizontal-space-around',
    widget: AlignHorizontalSpaceAroundIcon(size: 40),
  ),
  IconData(
    name: 'align-horizontal-space-between',
    widget: AlignHorizontalSpaceBetweenIcon(size: 40),
  ),
  IconData(
    name: 'align-horizontal-justify-center',
    widget: AlignHorizontalJustifyCenterIcon(size: 40),
  ),
  IconData(
    name: 'align-vertical-justify-center',
    widget: AlignVerticalJustifyCenterIcon(size: 40),
  ),
];
