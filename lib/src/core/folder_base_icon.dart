import 'package:flutter/material.dart';

import 'animated_svg_icon_base.dart';

enum FolderVariant {
  archive,
  bookmark,
  check,
  clock,
  closed,
  code,
  cog,
  dot,
  down,
  git,
  git2,
  heart,
  input,
  kanban,
  key,
  lock,
  minus,
  open,
  openDot,
  output,
  pen,
  plus,
  root,
  search,
  search2,
  symlink,
  sync,
  tree,
  up,
  x,
  folder,
  folders,
}

abstract class FolderIconBase extends AnimatedSVGIcon {
  const FolderIconBase({
    super.key,
    super.size = 40,
    super.color,
    super.hoverColor,
    super.animationDuration = const Duration(milliseconds: 700),
    super.strokeWidth = 2,
    super.reverseOnExit = false,
    super.enableTouchInteraction = true,
    super.infiniteLoop = false,
    super.onTap,
    super.interactive,
    super.controller,
  });

  FolderVariant get variant;

  @override
  String get animationDescription => 'Folder ${variant.name} parts animate';

  @override
  CustomPainter createPainter({
    required Color color,
    required double animationValue,
    required double strokeWidth,
  }) =>
      _FolderPainter(variant, color, animationValue, strokeWidth);
}

class _FolderPainter extends CustomPainter {
  const _FolderPainter(
    this.variant,
    this.color,
    this.animationValue,
    this.strokeWidth,
  );

  final FolderVariant variant;
  final Color color;
  final double animationValue;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 24;
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth / scale
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;
    final t = 4 * animationValue * (1 - animationValue);

    canvas.save();
    canvas.scale(scale);
    _frame(canvas, paint, t);
    _overlay(canvas, paint, t);
    canvas.restore();
  }

  void _frame(Canvas c, Paint p, double t) {
    const standard = {
      FolderVariant.bookmark,
      FolderVariant.check,
      FolderVariant.closed,
      FolderVariant.code,
      FolderVariant.down,
      FolderVariant.git,
      FolderVariant.minus,
      FolderVariant.plus,
      FolderVariant.search2,
      FolderVariant.up,
      FolderVariant.x,
      FolderVariant.folder,
    };
    const compact = {
      FolderVariant.dot,
      FolderVariant.kanban,
      FolderVariant.root,
    };
    if (standard.contains(variant)) {
      c.drawPath(_closed(t), p);
    } else if (compact.contains(variant)) {
      c.drawPath(_closed(t, compact: true), p);
    } else if (variant == FolderVariant.archive) {
      c.drawPath(_archive(), p);
    } else if (variant == FolderVariant.clock) {
      c.drawPath(_partial(7, 8), p);
    } else if (variant == FolderVariant.cog) {
      c.drawPath(
        _partial(10.3, 11.3, tab: 7.98, slopeX: 9.67, slope: .66, join: 12),
        p,
      );
    } else if (variant == FolderVariant.git2) {
      c.drawPath(_partial(9, 13), p);
    } else if (variant == FolderVariant.heart) {
      c.drawPath(_partial(10.638, 11.417), p);
    } else if (variant == FolderVariant.key) {
      c.drawPath(_partial(13, 9.36), p);
    } else if (variant == FolderVariant.lock) {
      c.drawPath(_partial(10, 10.5), p);
    } else if (variant == FolderVariant.search) {
      c.drawPath(_partial(10.7, 12.1), p);
    } else if (variant == FolderVariant.sync) {
      c.drawPath(_partial(9, 8.5), p);
    } else if (variant == FolderVariant.input) {
      c.drawPath(_input(), p);
    } else if (variant == FolderVariant.open) {
      c.drawPath(_open(t), p);
    } else if (variant == FolderVariant.openDot) {
      c.drawPath(_open(t, dot: true), p);
    } else if (variant == FolderVariant.output) {
      c.drawPath(_output(), p);
    } else if (variant == FolderVariant.pen) {
      c.drawPath(_penFrame(), p);
    } else if (variant == FolderVariant.symlink) {
      c.drawPath(_symlink(), p);
    } else if (variant == FolderVariant.tree) {
      _tree(c, p, t);
    } else if (variant == FolderVariant.folders) {
      _folders(c, p, t);
    }
  }

  void _overlay(Canvas c, Paint p, double t) {
    switch (variant) {
      case FolderVariant.archive:
        c.save();
        _around(c, const Offset(15, 19), scale: 1 + t * .16);
        c.drawCircle(const Offset(15, 19), 2, p);
        c.drawLine(Offset(15, 11 + t), const Offset(15, 10), p);
        c.drawLine(Offset(15, 17 - t), const Offset(15, 15), p);
        c.restore();
        break;
      case FolderVariant.bookmark:
        c.save();
        c.translate(15, 6);
        c.scale(1, 1 - t * .18);
        c.translate(-15, -6);
        c.drawPath(
          Path()
            ..moveTo(12, 6)
            ..lineTo(12, 14)
            ..lineTo(15, 11)
            ..lineTo(18, 14)
            ..lineTo(18, 6),
          p,
        );
        c.restore();
        break;
      case FolderVariant.check:
        _transform(
          c,
          const Offset(11, 13),
          Path()
            ..moveTo(9, 13)
            ..lineTo(11, 15)
            ..lineTo(15, 11),
          p,
          rotation: -t * .12,
          scale: 1 + t * .18,
        );
        break;
      case FolderVariant.clock:
        c.save();
        _around(c, const Offset(16, 16), scale: 1 + t * .05);
        c.drawCircle(const Offset(16, 16), 6, p);
        c.save();
        _around(c, const Offset(16, 16), rotation: t * .65);
        c.drawPath(
          Path()
            ..moveTo(16, 14)
            ..lineTo(16, 16.2)
            ..lineTo(17.6, 17.2),
          p,
        );
        c.restore();
        c.restore();
        break;
      case FolderVariant.closed:
        c.drawLine(Offset(2, 10 - t * .7), Offset(22, 10 - t * .7), p);
        break;
      case FolderVariant.code:
        c.save();
        c.translate(-t * .6, 0);
        c.drawPath(
          Path()
            ..moveTo(10, 10.5)
            ..lineTo(8, 13)
            ..lineTo(10, 15.5),
          p,
        );
        c.restore();
        c.save();
        c.translate(t * .6, 0);
        c.drawPath(
          Path()
            ..moveTo(14, 10.5)
            ..lineTo(16, 13)
            ..lineTo(14, 15.5),
          p,
        );
        c.restore();
        break;
      case FolderVariant.cog:
        c.save();
        _around(c, const Offset(18, 18), rotation: t * .55);
        final gear = Path()
          ..moveTo(14.305, 19.53)
          ..lineTo(15.228, 19.148)
          ..moveTo(15.228, 16.852)
          ..lineTo(14.305, 16.469)
          ..moveTo(16.852, 15.228)
          ..lineTo(16.469, 14.305)
          ..moveTo(16.852, 20.772)
          ..lineTo(16.469, 21.696)
          ..moveTo(19.148, 15.228)
          ..lineTo(19.531, 14.305)
          ..moveTo(19.53, 21.696)
          ..lineTo(19.148, 20.772)
          ..moveTo(20.772, 16.852)
          ..lineTo(21.696, 16.469)
          ..moveTo(20.772, 19.148)
          ..lineTo(21.696, 19.531);
        c.drawPath(gear, p);
        c.drawCircle(const Offset(18, 18), 3, p);
        c.restore();
        break;
      case FolderVariant.dot:
        c.drawCircle(const Offset(12, 13), 1 + t * .35, p);
        break;
      case FolderVariant.down:
        c.save();
        c.translate(0, t);
        c.drawPath(
          Path()
            ..moveTo(12, 10)
            ..lineTo(12, 16)
            ..moveTo(15, 13)
            ..lineTo(12, 16)
            ..lineTo(9, 13),
          p,
        );
        c.restore();
        break;
      case FolderVariant.git:
        c.drawCircle(const Offset(12, 13), 2 + t * .2, p);
        c.drawLine(Offset(14, 13), Offset(17 + t, 13), p);
        c.drawLine(Offset(7 - t, 13), const Offset(10, 13), p);
        break;
      case FolderVariant.git2:
        c.save();
        c.translate(0, -t * .4);
        c.drawCircle(const Offset(13, 12), 2 + t * .15, p);
        c.drawPath(
          Path()
            ..moveTo(18, 19)
            ..arcToPoint(const Offset(13, 14), radius: const Radius.circular(5))
            ..lineTo(13, 22),
          p,
        );
        c.drawCircle(const Offset(20, 19), 2 + t * .15, p);
        c.restore();
        break;
      case FolderVariant.heart:
        _transform(c, const Offset(18, 18), _heart(), p, scale: 1 + t * .12);
        break;
      case FolderVariant.input:
        c.save();
        c.translate(t * 1.2, 0);
        c.drawPath(
          Path()
            ..moveTo(2, 13)
            ..lineTo(12, 13)
            ..moveTo(9, 16)
            ..lineTo(12, 13)
            ..lineTo(9, 10),
          p,
        );
        c.restore();
        break;
      case FolderVariant.kanban:
        c.drawLine(const Offset(8, 10), Offset(8, 14 + t), p);
        c.drawLine(const Offset(12, 10), Offset(12, 12 + t * .6), p);
        c.drawLine(const Offset(16, 10), Offset(16, 16 - t), p);
        break;
      case FolderVariant.key:
        c.save();
        _around(c, const Offset(19, 20), rotation: t * .25);
        c.drawLine(const Offset(19, 12), const Offset(19, 18), p);
        c.drawLine(const Offset(19, 14), const Offset(21, 14), p);
        c.drawCircle(const Offset(19, 20), 2, p);
        c.restore();
        break;
      case FolderVariant.lock:
        c.save();
        _around(c, const Offset(18, 19.5), scale: 1 + t * .08);
        c.drawRRect(
          RRect.fromRectAndRadius(
            const Rect.fromLTWH(14, 17, 8, 5),
            const Radius.circular(1),
          ),
          p,
        );
        c.drawPath(
          Path()
            ..moveTo(20, 17)
            ..lineTo(20, 15 - t * .5)
            ..arcToPoint(
              Offset(16, 15 - t * .5),
              radius: const Radius.circular(2),
              largeArc: true,
              clockwise: false,
            )
            ..lineTo(16, 17),
          p,
        );
        c.restore();
        break;
      case FolderVariant.minus:
        c.drawLine(Offset(9 + t, 13), Offset(15 - t, 13), p);
        break;
      case FolderVariant.openDot:
        c.drawCircle(const Offset(14, 15), 1 + t * .3, p);
        break;
      case FolderVariant.output:
        c.save();
        c.translate(-t * 1.2, 0);
        c.drawPath(
          Path()
            ..moveTo(2, 13)
            ..lineTo(12, 13)
            ..moveTo(5, 10)
            ..lineTo(2, 13)
            ..lineTo(5, 16),
          p,
        );
        c.restore();
        break;
      case FolderVariant.pen:
        c.save();
        c.translate(t * .6, -t * .6);
        c.drawPath(_pencil(), p);
        c.restore();
        break;
      case FolderVariant.plus:
        c.save();
        _around(
          c,
          const Offset(12, 13),
          rotation: t * 1.5708,
          scale: 1 + t * .12,
        );
        c.drawLine(const Offset(12, 10), const Offset(12, 16), p);
        c.drawLine(const Offset(9, 13), const Offset(15, 13), p);
        c.restore();
        break;
      case FolderVariant.root:
        c.drawCircle(const Offset(12, 13), 2 + t * .18, p);
        c.drawLine(const Offset(12, 15), Offset(12, 20 + t), p);
        break;
      case FolderVariant.search:
        c.save();
        c.translate(t * .6, -t * .4);
        c.drawCircle(const Offset(17, 17), 3, p);
        c.drawLine(const Offset(19.1, 19.1), const Offset(21, 21), p);
        c.restore();
        break;
      case FolderVariant.search2:
        c.save();
        _around(c, const Offset(11.5, 12.5), scale: 1 + t * .15);
        c.drawCircle(const Offset(11.5, 12.5), 2.5, p);
        c.drawLine(const Offset(13.3, 14.3), const Offset(15, 16), p);
        c.restore();
        break;
      case FolderVariant.symlink:
        c.save();
        c.translate(t, 0);
        c.drawPath(
          Path()
            ..moveTo(8, 16)
            ..lineTo(11, 13)
            ..lineTo(8, 10),
          p,
        );
        c.restore();
        break;
      case FolderVariant.sync:
        c.save();
        _around(c, const Offset(17, 16), rotation: t * .28);
        c.drawPath(_sync(), p);
        c.restore();
        break;
      case FolderVariant.up:
        c.save();
        c.translate(0, -t);
        c.drawPath(
          Path()
            ..moveTo(12, 16)
            ..lineTo(12, 10)
            ..moveTo(9, 13)
            ..lineTo(12, 10)
            ..lineTo(15, 13),
          p,
        );
        c.restore();
        break;
      case FolderVariant.x:
        _transform(
          c,
          const Offset(12, 13),
          Path()
            ..moveTo(9.5, 10.5)
            ..lineTo(14.5, 15.5)
            ..moveTo(14.5, 10.5)
            ..lineTo(9.5, 15.5),
          p,
          rotation: t * .45,
          scale: 1 + t * .1,
        );
        break;
      case FolderVariant.open:
      case FolderVariant.folder:
      case FolderVariant.tree:
      case FolderVariant.folders:
        break;
    }
  }

  Path _closed(double t, {bool compact = false}) {
    final slopeX = compact ? 9.59 : 9.6;
    final join = compact ? 12.07 : 12.1;
    final lift = t * .45;
    return Path()
      ..moveTo(20, 20)
      ..arcToPoint(
        const Offset(22, 18),
        radius: const Radius.circular(2),
        clockwise: false,
      )
      ..lineTo(22, 8)
      ..arcToPoint(
        Offset(20, 6 - lift),
        radius: const Radius.circular(2),
        clockwise: false,
      )
      ..lineTo(join, 6 - lift)
      ..arcToPoint(
        Offset(10.41, 5.1 - lift * .45),
        radius: const Radius.circular(2),
      )
      ..lineTo(slopeX, 3.9)
      ..arcToPoint(
        const Offset(7.93, 3),
        radius: const Radius.circular(2),
        clockwise: false,
      )
      ..lineTo(4, 3)
      ..arcToPoint(
        const Offset(2, 5),
        radius: const Radius.circular(2),
        clockwise: false,
      )
      ..lineTo(2, 18)
      ..arcToPoint(
        const Offset(4, 20),
        radius: const Radius.circular(2),
        clockwise: false,
      )
      ..close();
  }

  Path _partial(
    double bottom,
    double right, {
    double tab = 7.9,
    double slopeX = 9.59,
    double slope = .81,
    double join = 12.07,
  }) =>
      Path()
        ..moveTo(bottom, 20)
        ..lineTo(4, 20)
        ..arcToPoint(const Offset(2, 18), radius: const Radius.circular(2))
        ..lineTo(2, 5)
        ..arcToPoint(const Offset(4, 3), radius: const Radius.circular(2))
        ..lineTo(tab, 3)
        ..arcToPoint(Offset(slopeX, 3.9), radius: const Radius.circular(2))
        ..lineTo(slopeX + slope, 5.1)
        ..arcToPoint(Offset(join, 6), radius: const Radius.circular(2))
        ..lineTo(20, 6)
        ..arcToPoint(const Offset(22, 8), radius: const Radius.circular(2))
        ..lineTo(22, right);

  Path _archive() => Path()
    ..moveTo(20.9, 19.8)
    ..arcToPoint(
      const Offset(22, 18),
      radius: const Radius.circular(2),
      clockwise: false,
    )
    ..lineTo(22, 8)
    ..arcToPoint(
      const Offset(20, 6),
      radius: const Radius.circular(2),
      clockwise: false,
    )
    ..lineTo(12.1, 6)
    ..arcToPoint(const Offset(10.41, 5.1), radius: const Radius.circular(2))
    ..lineTo(9.6, 3.9)
    ..arcToPoint(
      const Offset(7.93, 3),
      radius: const Radius.circular(2),
      clockwise: false,
    )
    ..lineTo(4, 3)
    ..arcToPoint(
      const Offset(2, 5),
      radius: const Radius.circular(2),
      clockwise: false,
    )
    ..lineTo(2, 18)
    ..arcToPoint(
      const Offset(4, 20),
      radius: const Radius.circular(2),
      clockwise: false,
    )
    ..lineTo(9.1, 20);

  Path _input() => _gapped(9, 17, true);
  Path _output() => _gapped(7.5, 18.5, false);

  Path _gapped(double startY, double endY, bool tail) {
    final path = Path()
      ..moveTo(2, startY)
      ..lineTo(2, 5)
      ..arcToPoint(const Offset(4, 3), radius: const Radius.circular(2))
      ..lineTo(7.9, 3)
      ..arcToPoint(const Offset(9.59, 3.9), radius: const Radius.circular(2))
      ..lineTo(10.4, 5.1)
      ..arcToPoint(const Offset(12.07, 6), radius: const Radius.circular(2))
      ..lineTo(20, 6)
      ..arcToPoint(const Offset(22, 8), radius: const Radius.circular(2))
      ..lineTo(22, 18)
      ..arcToPoint(const Offset(20, 20), radius: const Radius.circular(2))
      ..lineTo(4, 20)
      ..arcToPoint(Offset(2, endY), radius: const Radius.circular(2));
    if (tail) path.lineTo(2, 17);
    return path;
  }

  Path _open(double t, {bool dot = false}) => Path()
    ..moveTo(6, 14 - t * .45)
    ..lineTo(7.5 - (dot ? .05 : 0), 11.1)
    ..arcToPoint(const Offset(9.24, 10), radius: const Radius.circular(2))
    ..lineTo(20, 10)
    ..arcToPoint(const Offset(21.94, 12.5), radius: const Radius.circular(2))
    ..lineTo(dot ? 20.39 : 20.4, 18.5)
    ..arcToPoint(const Offset(18.45, 20), radius: const Radius.circular(2))
    ..lineTo(4, 20)
    ..arcToPoint(const Offset(2, 18), radius: const Radius.circular(2))
    ..lineTo(2, 5)
    ..arcToPoint(const Offset(4, 3), radius: const Radius.circular(2))
    ..lineTo(dot ? 7.93 : 7.9, 3)
    ..arcToPoint(const Offset(9.59, 3.9), radius: const Radius.circular(2))
    ..lineTo(dot ? 10.41 : 10.4, 5.1)
    ..arcToPoint(const Offset(12.07, 6), radius: const Radius.circular(2))
    ..lineTo(18, 6)
    ..arcToPoint(const Offset(20, 8), radius: const Radius.circular(2))
    ..lineTo(20, 10);

  Path _penFrame() => Path()
    ..moveTo(2, 11.5)
    ..lineTo(2, 5)
    ..arcToPoint(const Offset(4, 3), radius: const Radius.circular(2))
    ..lineTo(7.9, 3)
    ..cubicTo(8.6, 3, 9.2, 3.3, 9.6, 3.9)
    ..lineTo(10.4, 5.1)
    ..cubicTo(10.8, 5.7, 11.4, 6, 12.1, 6)
    ..lineTo(20, 6)
    ..arcToPoint(const Offset(22, 8), radius: const Radius.circular(2))
    ..lineTo(22, 18)
    ..arcToPoint(const Offset(20, 20), radius: const Radius.circular(2))
    ..lineTo(10.5, 20);

  Path _symlink() => Path()
    ..moveTo(2, 9.35)
    ..lineTo(2, 5)
    ..arcToPoint(const Offset(4, 3), radius: const Radius.circular(2))
    ..lineTo(7.9, 3)
    ..arcToPoint(const Offset(9.59, 3.9), radius: const Radius.circular(2))
    ..lineTo(10.4, 5.1)
    ..arcToPoint(const Offset(12.07, 6), radius: const Radius.circular(2))
    ..lineTo(20, 6)
    ..arcToPoint(const Offset(22, 8), radius: const Radius.circular(2))
    ..lineTo(22, 18)
    ..arcToPoint(const Offset(20, 20), radius: const Radius.circular(2))
    ..lineTo(4, 20)
    ..arcToPoint(const Offset(2, 18), radius: const Radius.circular(2))
    ..lineTo(2, 15)
    ..arcToPoint(const Offset(4, 13), radius: const Radius.circular(2))
    ..lineTo(11, 13);

  Path _heart() => Path()
    ..moveTo(14.62, 18.8)
    ..arcToPoint(
      const Offset(18, 15.836),
      radius: const Radius.circular(2.25),
      largeArc: true,
    )
    ..arcToPoint(
      const Offset(21.38, 18.802),
      radius: const Radius.circular(2.25),
      largeArc: true,
    )
    ..lineTo(18.754, 21.658)
    ..arcToPoint(
      const Offset(17.247, 21.658),
      radius: const Radius.circular(.998),
    )
    ..close();

  Path _pencil() => Path()
    ..moveTo(11.378, 13.626)
    ..arcToPoint(
      const Offset(8.374, 10.622),
      radius: const Radius.circular(1),
      largeArc: true,
      clockwise: false,
    )
    ..lineTo(3.364, 15.634)
    ..arcToPoint(
      const Offset(2.858, 16.488),
      radius: const Radius.circular(2),
      clockwise: false,
    )
    ..lineTo(2.021, 19.358)
    ..arcToPoint(
      const Offset(2.641, 19.978),
      radius: const Radius.circular(.5),
      clockwise: false,
    )
    ..lineTo(5.511, 19.141)
    ..arcToPoint(
      const Offset(6.365, 18.635),
      radius: const Radius.circular(2),
      clockwise: false,
    )
    ..close();

  Path _sync() => Path()
    ..moveTo(12, 10)
    ..lineTo(12, 14)
    ..lineTo(16, 14)
    ..moveTo(12, 14)
    ..lineTo(13.535, 12.395)
    ..arcToPoint(const Offset(21.535, 13.895), radius: const Radius.circular(5))
    ..moveTo(22, 22)
    ..lineTo(22, 18)
    ..lineTo(18, 18)
    ..moveTo(22, 18)
    ..lineTo(20.465, 19.605)
    ..arcToPoint(
      const Offset(12.465, 18.105),
      radius: const Radius.circular(5),
    );

  void _tree(Canvas c, Paint p, double t) {
    c.save();
    c.translate(0, -t * .35);
    c.drawPath(
      Path()
        ..moveTo(20, 10)
        ..arcToPoint(
          const Offset(21, 9),
          radius: const Radius.circular(1),
          clockwise: false,
        )
        ..lineTo(21, 6)
        ..arcToPoint(
          const Offset(20, 5),
          radius: const Radius.circular(1),
          clockwise: false,
        )
        ..lineTo(17.5, 5)
        ..arcToPoint(const Offset(16.7, 4.6), radius: const Radius.circular(1))
        ..lineTo(15.8, 3.4)
        ..arcToPoint(
          const Offset(15, 3),
          radius: const Radius.circular(1),
          clockwise: false,
        )
        ..lineTo(13, 3)
        ..arcToPoint(
          const Offset(12, 4),
          radius: const Radius.circular(1),
          clockwise: false,
        )
        ..lineTo(12, 9)
        ..arcToPoint(
          const Offset(13, 10),
          radius: const Radius.circular(1),
          clockwise: false,
        )
        ..close(),
      p,
    );
    c.restore();
    c.save();
    c.translate(0, t * .35);
    c.drawPath(
      Path()
        ..moveTo(20, 21)
        ..arcToPoint(
          const Offset(21, 20),
          radius: const Radius.circular(1),
          clockwise: false,
        )
        ..lineTo(21, 17)
        ..arcToPoint(
          const Offset(20, 16),
          radius: const Radius.circular(1),
          clockwise: false,
        )
        ..lineTo(17.1, 16)
        ..arcToPoint(
          const Offset(16.22, 15.45),
          radius: const Radius.circular(1),
        )
        ..lineTo(15.8, 14.6)
        ..arcToPoint(
          const Offset(14.88, 14),
          radius: const Radius.circular(1),
          clockwise: false,
        )
        ..lineTo(13, 14)
        ..arcToPoint(
          const Offset(12, 15),
          radius: const Radius.circular(1),
          clockwise: false,
        )
        ..lineTo(12, 20)
        ..arcToPoint(
          const Offset(13, 21),
          radius: const Radius.circular(1),
          clockwise: false,
        )
        ..close(),
      p,
    );
    c.restore();
    c.drawPath(
      Path()
        ..moveTo(3, 5)
        ..arcToPoint(
          const Offset(5, 7),
          radius: const Radius.circular(2),
          clockwise: false,
        )
        ..lineTo(8, 7)
        ..moveTo(3, 3)
        ..lineTo(3, 16)
        ..arcToPoint(
          const Offset(5, 18),
          radius: const Radius.circular(2),
          clockwise: false,
        )
        ..lineTo(8, 18),
      p,
    );
  }

  void _folders(Canvas c, Paint p, double t) {
    c.save();
    c.translate(t * .6, -t * .4);
    c.drawPath(
      Path()
        ..moveTo(20, 5)
        ..arcToPoint(const Offset(22, 7), radius: const Radius.circular(2))
        ..lineTo(22, 14)
        ..arcToPoint(const Offset(20, 16), radius: const Radius.circular(2))
        ..lineTo(9, 16)
        ..arcToPoint(const Offset(7, 14), radius: const Radius.circular(2))
        ..lineTo(7, 5)
        ..arcToPoint(const Offset(9, 3), radius: const Radius.circular(2))
        ..lineTo(11.5, 3)
        ..arcToPoint(
          const Offset(12.7, 3.6),
          radius: const Radius.circular(1.5),
        )
        ..lineTo(13.3, 4.4)
        ..arcToPoint(const Offset(14.5, 5), radius: const Radius.circular(1.5))
        ..close(),
      p,
    );
    c.restore();
    c.save();
    c.translate(-t * .6, t * .4);
    c.drawPath(
      Path()
        ..moveTo(3, 8.268)
        ..arcToPoint(
          const Offset(2, 10.006),
          radius: const Radius.circular(2),
          clockwise: false,
        )
        ..lineTo(2, 19)
        ..arcToPoint(
          const Offset(4, 21),
          radius: const Radius.circular(2),
          clockwise: false,
        )
        ..lineTo(15, 21)
        ..arcToPoint(
          const Offset(16.732, 20),
          radius: const Radius.circular(2),
          clockwise: false,
        ),
      p,
    );
    c.restore();
  }

  void _around(
    Canvas c,
    Offset center, {
    double rotation = 0,
    double scale = 1,
  }) {
    c.translate(center.dx, center.dy);
    c.rotate(rotation);
    c.scale(scale);
    c.translate(-center.dx, -center.dy);
  }

  void _transform(
    Canvas c,
    Offset center,
    Path path,
    Paint p, {
    double rotation = 0,
    double scale = 1,
  }) {
    c.save();
    _around(c, center, rotation: rotation, scale: scale);
    c.drawPath(path, p);
    c.restore();
  }

  @override
  bool shouldRepaint(_FolderPainter old) =>
      old.variant != variant ||
      old.color != color ||
      old.animationValue != animationValue ||
      old.strokeWidth != strokeWidth;
}
