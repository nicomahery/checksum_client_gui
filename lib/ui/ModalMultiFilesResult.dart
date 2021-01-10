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
                  Align(
                    //alignment: Alignment.center,
                    child: Text(
                      "Results",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
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
                child: ListView.separated(
                  padding: const EdgeInsets.all(25),
                  itemCount: this.widget.fileChecksumMap.length,
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    String filename = this.widget.fileChecksumMap.keys.elementAt(index);
                    num checksum = this.widget.fileChecksumMap[filename];
                    String formattedString = '\'$filename\': $checksum,';
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Spacer(flex: 5),
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
                                      fontSize: 20,
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
                                      fontSize: 20,
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
                                      fontSize: 20,
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
                        Spacer(flex: 5),
                      ],
                    );
                  }
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