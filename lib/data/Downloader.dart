import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

class Downloader {
  String _path;
  Downloader() {
    //init();
  }

  // Init the Flutter downloader
  init() async {
    await FlutterDownloader.initialize(
        debug: true // optional: set false to disable printing logs to console
        );
  }

  // Get the application path.
  Future<void> getPath() async {
    Directory appDocDir = await getExternalStorageDirectory();
    _path = appDocDir.path + '/Download';
  }

  // Get downloaded task by URL
  Future<List<DownloadTask>> getByUrl(String url) async {
    return await FlutterDownloader.loadTasksWithRawQuery(
        query: 'SELECT * FROM task WHERE url="$url";');
  }

  // Get downloaded task by ID
  Future<List<DownloadTask>> getById(var id) async {
    return await FlutterDownloader.loadTasksWithRawQuery(
        query: 'SELECT * FROM task WHERE task_id="$id";');
  }

  // Get all downloaded tasks
  Future<List<DownloadTask>> getAll() async {
    return await FlutterDownloader.loadTasksWithRawQuery(
        query: 'SELECT * FROM task WHERE status=3;');
  }

  // Start downloading file
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

  // Get status of file by url
  Future<DownloadTaskStatus> getStatus(String url) async {
    var tasks = await getByUrl(url);
    return (tasks ?? []).isNotEmpty
        ? tasks[0].status
        : DownloadTaskStatus.undefined;
  }

  // Cancle the download by ID
  Future<void> cancel(String taskId) async {
    await FlutterDownloader.remove(taskId: taskId);
  }

  // Pause the download by ID
  Future<void> pause(String taskId) async {
    await FlutterDownloader.pause(taskId: taskId);
  }

  // Resume the download by ID
  Future<void> resume(String taskId) async {
    await FlutterDownloader.resume(taskId: taskId);
  }

  // Remove the download by ID
  Future<void> delete(String taskId) async {
    var task = await getById(taskId);
    await getPath();
    var file = task.first.filename;
    var toDeleted = File("${_path}/${file}");
    bool hasFile = await toDeleted.exists();
    // Before deleting check, does file exists.
    if (hasFile) toDeleted.delete();
    await FlutterDownloader.remove(taskId: taskId);
  }

  Future<void> open(String taskId) async {
    await FlutterDownloader.open(taskId: taskId);
  }
}
