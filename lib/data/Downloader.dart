import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

class Downloader {
  String _path;
  Downloader() {
    init();
  }
  init() async {
    await FlutterDownloader.initialize(
        debug: true // optional: set false to disable printing logs to console
        );
  }

  Future<void> getPath() async {
    Directory appDocDir = await getExternalStorageDirectory();
    _path = appDocDir.path + '/Download';
  }

  Future<List<DownloadTask>> getByUrl(String url) async {
    return await FlutterDownloader.loadTasksWithRawQuery(
        query: 'SELECT * FROM task WHERE url="$url";');
  }

  Future<List<DownloadTask>> getAll() async {
    return await FlutterDownloader.loadTasksWithRawQuery(
        query: 'SELECT * FROM task WHERE status=3;');
  }

  Future<String> start(String url) async {
    var tasks = await getByUrl(url);
    await getPath();
    if (tasks.isNotEmpty) return tasks[0].taskId;
    var savedDir = Directory(_path);
    bool hasDir = await savedDir.exists();
    if (!hasDir) savedDir.create();
    return await FlutterDownloader.enqueue(
      url: url,
      savedDir: _path,
      showNotification: true,
      openFileFromNotification: true,
      //fileName: fileName ?? null,
    );
  }

  Future<DownloadTaskStatus> getStatus(String url) async {
    var tasks = await getByUrl(url);
    return (tasks ?? []).isNotEmpty
        ? tasks[0].status
        : DownloadTaskStatus.undefined;
  }

  Future<void> cancel(String taskId) async {
    await FlutterDownloader.remove(taskId: taskId);
  }

  Future<void> pause(String taskId) async {
    await FlutterDownloader.pause(taskId: taskId);
  }

  Future<void> resume(String taskId) async {
    await FlutterDownloader.resume(taskId: taskId);
  }

  Future<void> delete(String taskId) async {
    await FlutterDownloader.remove(taskId: taskId);
  }
}
