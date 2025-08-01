// ignore_for_file: avoid_print

import 'dart:io';
import 'package:path/path.dart' as p;

void main(List<String> args) {
  if (args.isEmpty) {
    print('Usage: dart run tool/check_lucide_icons.dart <path_to_lucide_repo>');
    exit(1);
  }

  final lucideRepoPath = args[0];
  final lucideIconsDir = Directory(p.join(lucideRepoPath, 'icons'));
  if (!lucideIconsDir.existsSync()) {
    print('Error: Lucide icons directory not found at ${lucideIconsDir.path}');
    print('Please make sure you point to the root of the lucide repository.');
    exit(1);
  }

  final projectIconsDir = Directory('lib/src/icons');
  if (!projectIconsDir.existsSync()) {
    print(
        'Error: Project icons directory not found at ${projectIconsDir.path}');
    exit(1);
  }

  print('Scanning for Lucide icons...');
  final lucideIcons = _getLucideIcons(lucideIconsDir);
  print('Found ${lucideIcons.length} Lucide icons.');

  print('Scanning for project icons...');
  final projectIcons = _getProjectIcons(projectIconsDir);
  print('Found ${projectIcons.length} project icons.');

  final existingIcons = projectIcons.intersection(lucideIcons);
  final newIcons = lucideIcons.difference(projectIcons);
  final removedIcons = projectIcons.difference(lucideIcons);

  print('Generating checklist...');
  _generateChecklist(existingIcons, newIcons, removedIcons);

  print('\nICON_CHECKLIST.md generated successfully.');
  print(' - ${existingIcons.length} existing icons.');
  print(' - ${newIcons.length} new icons to add.');
  print(' - ${removedIcons.length} potentially removed icons.');
}

Set<String> _getLucideIcons(Directory dir) {
  return dir
      .listSync()
      .where((entity) => entity is File && p.extension(entity.path) == '.svg')
      .map((entity) => p.basenameWithoutExtension(entity.path))
      .toSet();
}

Set<String> _getProjectIcons(Directory dir) {
  return dir
      .listSync()
      .where((entity) => entity is File && entity.path.endsWith('_icon.dart'))
      .map((entity) {
    final basename = p.basenameWithoutExtension(entity.path);
    // a_arrow_down_icon -> a-arrow-down
    if (basename.endsWith('_icon')) {
      return basename.substring(0, basename.length - 5).replaceAll('_', '-');
    }
    return basename.replaceAll('_', '-');
  }).toSet();
}

void _generateChecklist(
    Set<String> existing, Set<String> newIcons, Set<String> removed) {
  final buffer = StringBuffer();
  buffer.writeln('# Lucide Icons Checklist');
  buffer
      .writeln('Generated on ${DateTime.now().toUtc().toIso8601String()} UTC.');
  buffer.writeln();

  buffer.writeln('## ✅ Existing Icons (${existing.length})');
  final sortedExisting = existing.toList()..sort();
  for (final icon in sortedExisting) {
    buffer.writeln('- [x] `$icon`');
  }
  buffer.writeln();

  buffer.writeln('## ➕ New Icons to Add (${newIcons.length})');
  final sortedNew = newIcons.toList()..sort();
  for (final icon in sortedNew) {
    buffer.writeln('- [ ] `$icon`');
  }
  buffer.writeln();

  buffer.writeln('## ➖ Potentially Removed Icons (${removed.length})');
  final sortedRemoved = removed.toList()..sort();
  for (final icon in sortedRemoved) {
    buffer.writeln('- [ ] `$icon`');
  }
  buffer.writeln();

  final checklistFile = File('ICON_CHECKLIST.md');
  checklistFile.writeAsStringSync(buffer.toString());
}
