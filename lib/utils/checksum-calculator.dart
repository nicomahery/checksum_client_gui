import 'dart:io';

import 'checksum.dart';
import 'file-system.dart';

const int TABBED_SPACE_LENGTH = 15;
const int MAXIMUM_ARGUMENTS_COUNT_ALLOWED = 2;
const String HELP_PRINT_STRING =
    'A command-line utility to calculate checksum on a file\n\n' +
        'Usages:\n' +
        '  -from source: dart run dart_checksum_client.dart [<option>] <path>\n' +
        '  -from exe: dart_checksum_client.exe [<option>] <path>\n' +
        '  -from aot(linux, macos): dartaotruntime dart_checksum_client.aot [<option>] <path>\n';

const String HELP_OPTION_COMMAND = '--help';
const String DIRECTORY_OPTION_COMMAND = '--directory';
const Map<String, String> OPTIONS_DESCRIPTIONS_MAP = {
  HELP_OPTION_COMMAND: 'Print the usage information.',
  DIRECTORY_OPTION_COMMAND: 'Calculate the checksum for every file in the given directory'
};

void checksum(List<String> arguments) async {
  String option;
  String path;
  if (arguments.isEmpty) {
    print('Specify at least the path, please refer to the help option: $HELP_OPTION_COMMAND');
    exit(128);
  }
  if (arguments.length>MAXIMUM_ARGUMENTS_COUNT_ALLOWED) {
    print('Too much arguments provided, please refer to the help option: $HELP_OPTION_COMMAND');
    exit(128);
  }
  if (arguments.first.startsWith('-')) {
    if (!OPTIONS_DESCRIPTIONS_MAP.containsKey(arguments.first)) {
      print('Please use a supported option');
      exit(128);
    }
    if (arguments.length < 2 && arguments.first != HELP_OPTION_COMMAND) {
      print('Specify the path, please refer to the help option: $HELP_OPTION_COMMAND');
      exit(128);
    }
    option = arguments.first;
    path = arguments.last;
  }
  else {
    path = arguments.first;
  }

  switch(option) {
    case HELP_OPTION_COMMAND:
      print(HELP_PRINT_STRING);
      print('Global options:');
      OPTIONS_DESCRIPTIONS_MAP.forEach((key, description) {
        int spaceToAddCount = TABBED_SPACE_LENGTH - key.length;
        String optionDisplayedString = '  $key';
        for(int i = 0; i < spaceToAddCount; i++) {
          optionDisplayedString+= ' ';
        }
        optionDisplayedString+= description;
        print(optionDisplayedString);
      });
      exit(0);
      break;
    case DIRECTORY_OPTION_COMMAND:
      _checkIsDirectoryConstraints(path);

      List<String> filepathList = await getListOfFilepathForDirectory(path);

      if (filepathList.isEmpty) {
        print('no file available in the directory: $path');
        exit(0);
      }

      for(String element in filepathList) {
        num checksum = await calculateCRC32XZChecksum(element);
        print('CRC32XZ Checksum for file $element: $checksum');
      };
      break;
    default:
      _checkIsFileConstraints(path);

      num checksum = await calculateCRC32XZChecksum(path);
      print('CRC32XZ Checksum for file $path: $checksum');
  }

  /*int i = 1;
  arguments.forEach((element) {
    print('arg[$i]: $element');
    i++;
  });
  print('');*/
}

void _checkIsFileConstraints(String filepath) {
  if (FileSystemEntity.typeSync(filepath) == FileSystemEntityType.notFound) {
    print('$filepath doesn\'t exist, please specify the path of an existing file');
    exit(128);
  }
  if(FileSystemEntity.isDirectorySync(filepath)) {
    print('$filepath is a directory, please specify the path of a file');
    exit(128);
  };
  if(!FileSystemEntity.isFileSync(filepath)) {
    print('$filepath is not a File, please specify the path of a file');
    exit(128);
  };
}

void _checkIsDirectoryConstraints(String filepath) {
  if (FileSystemEntity.typeSync(filepath) == FileSystemEntityType.notFound) {
    print('$filepath doesn\'t exist, please specify the path of an existing directory');
    exit(128);
  }
  if(FileSystemEntity.isFileSync(filepath)) {
    print('$filepath is a File, please specify the path of a directory');
    exit(128);
  };
  if(!FileSystemEntity.isDirectorySync(filepath)) {
    print('$filepath is not a directory, please specify the path of a directory');
    exit(128);
  };
}