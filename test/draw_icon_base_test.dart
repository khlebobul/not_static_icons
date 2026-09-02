import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:not_static_icons/not_static_icons.dart';

void main() {
  test('water stays inside glass', () async {
    final water = await _render(const GlassWaterIcon(), .25);
    expect(_alphaAt(water, 38, 25), 0);
  });

  test('grip dots are filled', () async {
    expect(_alphaAt(await _render(const GripIcon(), 0), 24, 24), 255);
    expect(
      _alphaAt(await _render(const GripHorizontalIcon(), 0), 24, 18),
      255,
    );
    expect(
      _alphaAt(await _render(const GripVerticalIcon(), 0), 18, 24),
      255,
    );
  });

  test('rounded corners follow source path direction', () {
    final angleTangent = const AngleIcon()
        .paths
        .first
        .computeMetrics()
        .first
        .getTangentForOffset(16.01)!
        .vector;
    expect(angleTangent.dy, greaterThan(.9));
    expect(angleTangent.dx.abs(), lessThan(.2));

    final ejectTangent = const EjectIcon()
        .paths
        .first
        .computeMetrics()
        .first
        .getTangentForOffset(.01)!
        .vector;
    expect(ejectTangent.dx, lessThan(-.8));
    expect(ejectTangent.dy.abs(), lessThan(.4));
  });

  test('icons animate and return exactly to idle', () async {
    const icons = [
      AngleIcon(),
      AudioLinesXIcon(),
      BroomIcon(),
      BroomSparklesIcon(),
      CarBatteryIcon(),
      EjectIcon(),
      FaceAngryIcon(),
      FaceExpressionlessIcon(),
      FaceGrinningIcon(),
      FaceNeutralIcon(),
      FaceSlightlyFrowningIcon(),
      FaceSlightlySmilingIcon(),
      FaceSlightlySmilingPlusIcon(),
      FootprintsIcon(),
      ForkliftIcon(),
      FormIcon(),
      ForwardIcon(),
      FrameIcon(),
      FuelIcon(),
      FullscreenIcon(),
      FunnelIcon(),
      FunnelPlusIcon(),
      FunnelXIcon(),
      GalaxyIcon(),
      GalleryHorizontalEndIcon(),
      GalleryHorizontalIcon(),
      GalleryThumbnailsIcon(),
      GalleryVerticalEndIcon(),
      GalleryVerticalIcon(),
      Gamepad2Icon(),
      GamepadDirectionalIcon(),
      GamepadIcon(),
      GaugeIcon(),
      GavelIcon(),
      GemIcon(),
      GeorgianLariIcon(),
      GhostIcon(),
      GiftIcon(),
      GitBranchIcon(),
      GitBranchMinusIcon(),
      GitBranchPlusIcon(),
      GitCommitHorizontalIcon(),
      GitCommitVerticalIcon(),
      GitCompareArrowsIcon(),
      GitCompareIcon(),
      GitForkIcon(),
      GitGraphIcon(),
      GitMergeConflictIcon(),
      GitMergeIcon(),
      GitPullRequestArrowIcon(),
      GitPullRequestClosedIcon(),
      GitPullRequestCreateArrowIcon(),
      GitPullRequestCreateIcon(),
      GitPullRequestDraftIcon(),
      GitPullRequestIcon(),
      GlassWaterIcon(),
      GlassesIcon(),
      GlobeCheckIcon(),
      GlobeIcon(),
      GlobeLockIcon(),
      GlobeOffIcon(),
      GlobeXIcon(),
      GoalIcon(),
      GpuIcon(),
      GraduationCapIcon(),
      GrapeIcon(),
      Grid2x2CheckIcon(),
      Grid2x2PlusIcon(),
      Grid2x2XIcon(),
      Grid3x2Icon(),
      Grid3x3Icon(),
      GripHorizontalIcon(),
      GripIcon(),
      GripVerticalIcon(),
      GroupIcon(),
      GuitarIcon(),
    ];

    for (final icon in icons) {
      final idle = await _render(icon, 0);
      expect(
        await _render(icon, .25),
        isNot(equals(idle)),
        reason: '${icon.runtimeType} must animate',
      );
      expect(
        await _render(icon, 1),
        equals(idle),
        reason: '${icon.runtimeType} must return to idle',
      );
    }
  });
}

int _alphaAt(Uint8List pixels, int x, int y) => pixels[(y * 48 + x) * 4 + 3];

Future<Uint8List> _render(AnimatedSVGIcon icon, double value) async {
  final recorder = ui.PictureRecorder();
  icon
      .createPainter(
        color: Colors.black,
        animationValue: value,
        strokeWidth: 2,
      )
      .paint(ui.Canvas(recorder), const ui.Size.square(48));
  final image = await recorder.endRecording().toImage(48, 48);
  final data = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
  image.dispose();
  return data!.buffer.asUint8List();
}
