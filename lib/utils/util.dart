import 'package:open_file/open_file.dart';

void openFile(file) async {
  try {
    await OpenFile.open(file);
  } catch (_) {}
}
