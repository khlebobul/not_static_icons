import '../core/folder_base_icon.dart';

class FolderSymlinkIcon extends FolderIconBase {
  const FolderSymlinkIcon({
    super.key,
    super.size,
    super.color,
    super.hoverColor,
    super.animationDuration,
    super.strokeWidth,
    super.reverseOnExit,
    super.enableTouchInteraction,
    super.infiniteLoop,
    super.onTap,
    super.interactive,
    super.controller,
  });

  @override
  FolderVariant get variant => FolderVariant.symlink;
}
