import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileManager {
  static const String folderName = 'images';
  Future<bool> checkFolderInAppDocDir() async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    //App Document Directory + folder name
    final Directory appDocDirFolder =
        Directory('${appDocDir.path}/$folderName/');
    if (await appDocDirFolder.exists()) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> createFolderInAppDocDir() async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    //App Document Directory + folder name
    final Directory appDocDirFolder =
        Directory('${appDocDir.path}/$folderName/');

    if (await appDocDirFolder.exists()) {
      //if folder already exists return path
      return appDocDirFolder.path;
    } else {
      //if folder not exists create folder and then return its path
      final Directory appDocDirNewFolder =
          await appDocDirFolder.create(recursive: true);
      return appDocDirNewFolder.path;
    }
  }

  Future<File> createFileInDirectory(String filePath, String type) async {
    final fileTemp = File(filePath);
    DateTime now = DateTime.now();
    final path = await createFolderInAppDocDir();
    var fileImages = File(
        '$path/${now.year}-${now.month}-${now.day}-${now.hour}-${now.minute}-${now.second}.$type');
    fileImages.writeAsBytesSync(fileTemp.readAsBytesSync());
    deleteFile(filePath);
    return fileImages;
  }

  void deleteFile(String filePath) {
    final file = File(filePath);
    return file.deleteSync();
  }

  Future<List<File>> getListFileInDictionary() async {
    final path = await createFolderInAppDocDir();
    var fileSystemEntries = Directory(path).listSync();
    var files = fileSystemEntries.map((file) => file as File).toList();
    return files;
  }
}
