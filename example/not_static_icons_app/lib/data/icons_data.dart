import 'package:flutter/material.dart';
import 'all_icons.dart';

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
  IconData(name: 'arrow-down', widget: ArrowDownIcon(size: 40)),
  IconData(
    name: 'arrow-down-from-line',
    widget: ArrowDownFromLineIcon(size: 40),
  ),
  IconData(name: 'arrow-down-left', widget: ArrowDownLeftIcon(size: 40)),
  IconData(name: 'arrow-down-right', widget: ArrowDownRightIcon(size: 40)),
  IconData(name: 'arrow-down-to-dot', widget: ArrowDownToDotIcon(size: 40)),
  IconData(name: 'arrow-down-to-line', widget: ArrowDownToLineIcon(size: 40)),
  IconData(name: 'arrow-left', widget: ArrowLeftIcon(size: 40)),
  IconData(
    name: 'arrow-left-from-line',
    widget: ArrowLeftFromLineIcon(size: 40),
  ),
  IconData(name: 'arrow-left-to-line', widget: ArrowLeftToLineIcon(size: 40)),
  IconData(name: 'arrow-right', widget: ArrowRightIcon(size: 40)),
  IconData(
    name: 'arrow-right-from-line',
    widget: ArrowRightFromLineIcon(size: 40),
  ),
  IconData(name: 'arrow-right-to-line', widget: ArrowRightToLineIcon(size: 40)),
  IconData(name: 'arrow-up', widget: ArrowUpIcon(size: 40)),
  IconData(name: 'arrow-up-from-dot', widget: ArrowUpFromDotIcon(size: 40)),
  IconData(name: 'arrow-up-from-line', widget: ArrowUpFromLineIcon(size: 40)),
  IconData(name: 'arrow-up-left', widget: ArrowUpLeftIcon(size: 40)),
  IconData(name: 'arrow-up-right', widget: ArrowUpRightIcon(size: 40)),
  IconData(name: 'arrow-up-to-line', widget: ArrowUpToLineIcon(size: 40)),
  IconData(name: 'arrows-up-from-line', widget: ArrowsUpFromLineIcon(size: 40)),
  IconData(
    name: 'arrow-down-narrow-wide',
    widget: ArrowDownNarrowWideIcon(size: 40),
  ),
  IconData(name: 'arrow-down-up', widget: ArrowDownUpIcon(size: 40)),
  IconData(
    name: 'arrow-down-wide-narrow',
    widget: ArrowDownWideNarrowIcon(size: 40),
  ),
  IconData(name: 'arrow-left-right', widget: ArrowLeftRightIcon(size: 40)),
  IconData(name: 'arrow-right-left', widget: ArrowRightLeftIcon(size: 40)),
  IconData(name: 'arrow-up-down', widget: ArrowUpDownIcon(size: 40)),
  IconData(
    name: 'arrow-up-narrow-wide',
    widget: ArrowUpNarrowWideIcon(size: 40),
  ),
  IconData(
    name: 'arrow-up-wide-narrow',
    widget: ArrowUpWideNarrowIcon(size: 40),
  ),
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
  IconData(name: 'arrow-down-a-z', widget: ArrowDownAZIcon(size: 40)),
  IconData(name: 'arrow-down-z-a', widget: ArrowDownZAIcon(size: 40)),
  IconData(name: 'arrow-up-a-z', widget: ArrowUpAZIcon(size: 40)),
  IconData(name: 'arrow-up-z-a', widget: ArrowUpZAIcon(size: 40)),
];
