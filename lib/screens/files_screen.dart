import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:co_task_hub/constants/k_colors.dart';
import 'package:co_task_hub/constants/k_my_text.dart';
import 'package:co_task_hub/constants/k_values.dart';
import 'package:co_task_hub/controller/get_controller.dart';
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
      Get.snackbar('Success', 'Pdf uploaded successfully');
    }
  }

  @override
  void initState() {
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
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('files')
              .where('teamCode',
                  isEqualTo: myController.teamData.value.teamCode)
              .snapshots(),
          initialData: const KMyText('Upload any files'),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            var fileData = [];
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              fileData = snapshot.data.docs;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: fileData.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () => launchUrl(Uri.parse(fileData[index]['url'])),
                    child: Container(
                      height: 500,
                      margin: const EdgeInsets.all(15),
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      decoration: BoxDecoration(
                        border: Border.all(color: accentColor),
                        color: cardColor.withOpacity(.3),
                        borderRadius: BorderRadius.circular(radius),
                      ),
                      child: ListTile(
                        title: ClipRRect(
                          borderRadius: BorderRadius.circular(radius),
                          child: Image.network(
                            fileData[index]['url'],
                            height: 100,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.network(
                                'https://www.iconpacks.net/icons/2/free-pdf-icon-3385-thumb.png',
                                height: 100,
                              );
                            },
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(10),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Flexible(
                            child: KMyText(
                              fileData[index]['name'],
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(
              child: KMyText('No files uploaded yet'),
            );
          },
        ));
  }
}
