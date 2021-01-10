import 'dart:io';

/// Returns true if the [location] exists and is a directory
Future<bool> isDirectory(String location) async {
  return await Directory(location).exists();
}

/// Returns true if the [filepath] exists and is a file
Future<bool> isFile(String filepath) async {
  return await File(filepath).exists();
}

/// Returns the list containing the filepath of every files in the given directory at [location]
Future<List<String>> getListOfFilepathForDirectory(String location) {
  Directory directory = Directory(location);
  return directory.list().where((event) => event is File).map((file) => file.path).toList();
}