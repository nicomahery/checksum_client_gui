import 'dart:io';

import 'package:crclib/catalog.dart';
import 'package:crclib/crclib.dart';

/// Returns the calculated CRC32 checksum for the file passed in [file]
Future<num> calculateChecksumForFile(File file) async {
  CrcValue checksumValue = await file.openRead().transform(Crc32Xz()).single;
  print('Calculate Checksum for file: ${file.path} checksum:${checksumValue.toString()}');
  return num.parse(checksumValue.toString());
}

/// Returns the calculated CRC32 checksum for each file passed in [list]
Future<Map<File, num>> calculateChecksumForFileList(List<File> list) async {
  Map<File, num> map = Map();
  for(File file in list) {
    CrcValue checksumValue = await file.openRead().transform(Crc32Xz()).single;
    map.putIfAbsent(file, () => num.parse(checksumValue.toString()));
    print('Calculate Checksum for file: ${file.path} checksum:${checksumValue.toString()}');
  }
  return map;
}

/// Returns the calculated CRC32 checksum for the file located in [filepath]
Future<num> calculateCRC32XZChecksum(String filepath) async {
  File file = File(filepath);
  CrcValue checksumValue = await file.openRead().transform(Crc32Xz()).single;
  //print('Calculate Checksum for file: ${file.path} checksum:${checksumValue.toString()} Api Checksum: $refChecksum');
  return num.parse(checksumValue.toString());
}