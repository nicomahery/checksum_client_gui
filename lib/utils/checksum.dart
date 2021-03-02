import 'dart:io';

import 'package:crclib/catalog.dart';
import 'package:crclib/crclib.dart';

const num CHECKSUM_END_TO_START_BYTE_OFFSET = 50;

/// Returns the calculated CRC32 checksum for the file passed in [file]
Future<num> calculateChecksumForFile(File file) async {
  int fileLength = file.readAsBytesSync().length;
  int startOffset = fileLength - CHECKSUM_END_TO_START_BYTE_OFFSET;
  CrcValue checksumValue = await file.openRead(startOffset).transform(Crc32Xz()).single;
  print('Calculate Checksum for file: ${file.path} checksum:${checksumValue.toString()} length: $fileLength, startOffset: $startOffset');
  return num.parse(checksumValue.toString());
}

/// Returns the calculated CRC32 checksum for each file passed in [list]
Future<Map<File, num>> calculateChecksumForFileList(List<File> list) async {
  Map<File, num> map = Map();
  for(File file in list) {
    int fileLength = file.readAsBytesSync().length;
    int startOffset = fileLength - CHECKSUM_END_TO_START_BYTE_OFFSET;
    CrcValue checksumValue = await file.openRead(startOffset).transform(Crc32Xz()).single;
    map.putIfAbsent(file, () => num.parse(checksumValue.toString()));
    print('Calculate Checksum for file: ${file.path} checksum:${checksumValue.toString()} length: $fileLength, startOffset: $startOffset');
  }
  return map;
}

/// Returns the calculated CRC32 checksum for the file located in [filepath]
Future<num> calculateCRC32XZChecksum(String filepath) async {
  File file = File(filepath);
  int fileLength = file.readAsBytesSync().length;
  int startOffset = fileLength - CHECKSUM_END_TO_START_BYTE_OFFSET;
  CrcValue checksumValue = await file.openRead(startOffset).transform(Crc32Xz()).single;
  print('Calculate Checksum for file: ${file.path} checksum:${checksumValue.toString()} length: $fileLength, startOffset: $startOffset');
  return num.parse(checksumValue.toString());
}