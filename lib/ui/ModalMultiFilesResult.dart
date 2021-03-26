import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ModalMultiFilesResult extends StatefulWidget {
  Map<String, num> fileChecksumMap;
  BuildContext scaffoldContext;

  ModalMultiFilesResult(this.scaffoldContext, this.fileChecksumMap);

  @override
  _ModalMultiFilesResultState createState() => _ModalMultiFilesResultState();
}

class _ModalMultiFilesResultState extends State<ModalMultiFilesResult> {

  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * 0.75;
    var width = MediaQuery.of(context).size.width * 0.80;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        height: height,
        width: width,
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: height * 0.08,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Spacer(),
                  Text(
                    "Results",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(
                      Icons.copy,
                      color: Colors.white,
                      size: 15,
                    ),
                    onPressed: () {
                      String dataToCopy = '';
                      this.widget.fileChecksumMap.forEach((key, value) {
                        dataToCopy +=  '\'$key\': $value,\n';
                      });
                      Clipboard.setData(ClipboardData(text: dataToCopy));
                    },
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: double.infinity,
                height: height * 0.8,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: () {
                      List<Widget> rows = [];
                      this.widget.fileChecksumMap.forEach((key, value) {
                        String filename = key;
                        num checksum = value;
                        String formattedString = '\'$filename\': $checksum,';
                        print('formattedString: $formattedString');
                        rows.add(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Spacer(flex: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        filename,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.content_copy),
                                        onPressed: () {
                                          setState(() {
                                            Clipboard.setData(ClipboardData(text: filename));
                                          });
                                        },
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Spacer(flex: 1),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        checksum.toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.content_copy),
                                        onPressed: () {
                                          setState(() {
                                            Clipboard.setData(ClipboardData(text: checksum.toString()));
                                          });
                                        },
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Spacer(flex: 1),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        formattedString,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.content_copy),
                                        onPressed: () {
                                          setState(() {
                                            Clipboard.setData(ClipboardData(text: formattedString));
                                          });
                                        },
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Spacer(flex: 20),
                            ],
                          )
                        );
                      });
                      return rows;
                    }()
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: () async {
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  height: height * 0.08,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "OK",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}