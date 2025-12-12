
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'package:lisa_beauty_salon/core/themes/theme.dart';
import 'package:lisa_beauty_salon/core/utils/assets.dart';
import 'package:lisa_beauty_salon/core/utils/strings.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_button.dart';
import 'package:lisa_beauty_salon/shared/widgets/common_spacing.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';

class FileUploadComponent extends StatefulWidget {
  final ValueNotifier<List<XFile>> imageFilesNotifier;
  final ValueNotifier<List<File>> documentFilesNotifier;

  const FileUploadComponent({
    required this.imageFilesNotifier,
    required this.documentFilesNotifier,
    super.key,
  });

  @override
  State<FileUploadComponent> createState() => _FileUploadComponentState();
}

class _FileUploadComponentState extends State<FileUploadComponent> {
  final ImagePicker _picker = ImagePicker();

  // Function to pick images
  Future<void> _pickImages() async {
    final pickedFiles = await _picker.pickMultiImage();
    widget.imageFilesNotifier.value = [...widget.imageFilesNotifier.value, ...pickedFiles];
    }

  // Function to pick documents/files
  Future<void> _pickDocuments() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      final newFiles = result.files.map((e) => File(e.path!)).toList();
      widget.documentFilesNotifier.value = [...widget.documentFilesNotifier.value, ...newFiles];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: DashedBorder.fromBorderSide(
          dashLength: 15,
          side: BorderSide(
            color: AppColors.greyOne,
            width: 2
          )
        )
      ),
      child: ValueListenableBuilder<List<XFile>>(
        valueListenable: widget.imageFilesNotifier,
        builder: (context, imageFiles, child) {
          return ValueListenableBuilder<List<File>>(
            valueListenable: widget.documentFilesNotifier,
            builder: (context, documentFiles, child) {
              if (imageFiles.isEmpty && documentFiles.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        Assets.uploadLicenseSvgIcon,
                        width: 42,
                        height: 42,
                        fit: BoxFit.cover,
                      ),
                      VerticalSpacing(30),
                      CommonButton(
                        width: 100,
                        height: 40,
                        text: Strings.browserFilesText,
                        textColor: AppColors.pinkTwo,
                        textFontSize: 11,
                        padding: EdgeInsets.zero,
                        backgroundColor: AppColors.transparent,
                        borderColor: AppColors.pinkTwo,
                        radius: 10,
                        onPressed: _showPickerOptions,
                      )
                    ],
                  ),
                );
              }

              return Column(
                children: [
                  if (imageFiles.isNotEmpty)
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        itemCount: imageFiles.length,
                        itemBuilder: (context, index) {
                          return Image.file(
                            File(imageFiles[index].path),
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  if (documentFiles.isNotEmpty)
                    Expanded(
                      child: ListView.builder(
                        itemCount: documentFiles.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(documentFiles[index].path.split('/').last),
                            leading: Icon(Icons.description),
                          );
                        },
                      ),
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  // Show options for picking either image or document
  void _showPickerOptions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Choose an option"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text("Pick Image(s)"),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImages();
                },
              ),
              ListTile(
                title: Text("Pick Document(s)"),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickDocuments();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
