import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:not_static_icons/not_static_icons.dart';

void main() {
  test('icons animate and return exactly to idle', () async {
    const icons = [
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
    ];

    for (final icon in icons) {
      final idle = await _render(icon, 0);
      expect(
        await _render(icon, .5),
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
