import 'dart:io';
import 'package:co_task_hub/constants/k_colors.dart';
import 'package:co_task_hub/constants/k_my_text.dart';
import 'package:co_task_hub/services/firebase_services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class FilesScreen extends StatefulWidget {
  const FilesScreen({super.key});

  @override
  State<FilesScreen> createState() => _FilesScreenState();
}

class _FilesScreenState extends State<FilesScreen> {
  bool uploadingFile = false;
  var fileData = [];

  pickFile() async {
    setState(() => uploadingFile = true);
    final pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg'],
    );

    if (pickedFile != null) {
      String fileName = pickedFile.files[0].name;

      File file = File(pickedFile.files[0].path!);

      var fileUrl = await FirebaseServices()
          .addDocuments(fileName: fileName, file: file)
          .whenComplete(() => setState(() => uploadingFile = false));
      await FirebaseServices().createMessage(message: fileUrl, isUrl: true);
      getFiles();
      Get.snackbar('Success', 'Pdf uploaded successfully');
    }
  }

  getFiles() async {
    fileData = await FirebaseServices().getDocuments();
    setState(() {});
  }

  @override
  void initState() {
    getFiles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: pickFile,
        backgroundColor: accentColor,
        icon: Visibility(
            visible: !uploadingFile,
            replacement: const CircularProgressIndicator(color: Colors.white),
            child: const KMyText('Add Files', color: Colors.white)),
        label: const Icon(Icons.file_open_outlined),
      ),
      body: GridView.builder(
          itemCount: fileData.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => launchUrl(Uri.parse(fileData[index]['url'])),
              child: Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                    border: Border.all(), color: cardColor.withOpacity(.3)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(
                      Icons.file_open_outlined,
                      size: 70,
                      color: accentColor,
                    ),
                    KMyText(fileData[index]['name'])
                  ],
                ),
              ),
            );
          }),
    );
  }
}
