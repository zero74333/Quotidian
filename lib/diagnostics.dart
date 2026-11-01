/// Keeps the last few errors in memory so Settings can show them.
class ErrorLog {
  static final List<String> _entries = <String>[];

  static void add(Object error, StackTrace? stack) {
    final line = '${DateTime.now().toIso8601String()}  $error'
        '${stack == null ? '' : '\n${stack.toString().split('\n').take(4).join('\n')}'}';
    _entries.add(line);
    if (_entries.length > 40) _entries.removeAt(0);
  }

  static bool get isEmpty => _entries.isEmpty;
  static int get count => _entries.length;
  static String dump() => _entries.isEmpty ? 'No errors recorded.' : _entries.join('\n\n');
}
