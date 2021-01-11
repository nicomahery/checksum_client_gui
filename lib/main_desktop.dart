import 'dart:io';

import 'package:checksum_calculator/ui/ModalMultiFilesResult.dart';
import 'package:checksum_calculator/ui/ModalSingleFileResult.dart';
import 'package:checksum_calculator/utils/checksum.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Checksum Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        backgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(title: 'Checksum Calculator'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(flex: 10),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Browse for single file',
                  style: TextStyle(
                    color: Theme.of(context).backgroundColor,
                    fontSize: 30
                  ),
                ),
              ),
              onPressed: () async {
                FilePickerResult result = await FilePicker.platform.pickFiles();
                if(result != null) {
                  num checksum = await calculateChecksumForFile(File(result.files.single.path));
                  _showModalSingleFileResult(context, result.files.single.name, checksum);
                }
              },
            ),
            Spacer(flex: 1),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Browse for multiple files',
                  style: TextStyle(
                      color: Theme.of(context).backgroundColor,
                      fontSize: 30
                  ),
                ),
              ),
              onPressed: () async {
                FilePickerResult result = await FilePicker.platform.pickFiles(allowMultiple: true);
                if(result != null) {
                  List<File> files = result.paths.map((path) => File(path)).toList();
                  Map<File, num> checksumMap = await calculateChecksumForFileList(files);
                  Map<String, num> filenameChecksumMap = Map();
                  checksumMap.forEach((key, value) {
                    filenameChecksumMap.putIfAbsent(basename(key.path), () => value);
                  });
                  _showModalMultiFilesResult(context, filenameChecksumMap);
                }
              },
            ),
            Spacer(flex: 10)
          ],
        ),
      ),
    );
  }

  _showModalSingleFileResult(BuildContext context, String filename, num checksum) {
    showDialog(
        context: context,
        builder: (builder) {
          return ModalSingleFileResult(context, filename, checksum);
        });
  }

  _showModalMultiFilesResult(BuildContext context, Map<String, num> map) {
    showDialog(
        context: context,
        builder: (builder) {
          return ModalMultiFilesResult(context, map);
        });
  }
}
