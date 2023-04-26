import 'dart:io';

import 'package:event_app/models/create_event_model.dart';
import 'package:event_app/services/image_picker_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import '../constants/constants.dart';
import '../constants/theme.dart';
import '../widgets/back_button_widget.dart';
import '../widgets/solid_button_widget.dart';
import '../widgets/underlined_input_widget.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  static GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var imageModel = Get.put(ImagePickerService());
    var createEventModel = Get.put(CreateEventModel());
    var deviceSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        imageModel.resetImagePath();
        Get.back();
        return false;
      },
      child: Container(
        decoration: kscaffoldGradient,
        child: Scaffold(
          // resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          extendBody: true,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: BackButtonWidget(onBack: () {
                imageModel.resetImagePath();
                Get.back();
              }),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    createEventModel.toggleVisibility();
                  },
                  child: SizedBox(
                    height: deviceSize.height * 0.5,
                    // width: double.infinity,
                    child: Stack(
                      children: [
                        Obx(() {
                          return Container(
                            child: imageModel.imagePath == ""
                                ? SizedBox(
                                    height: deviceSize.height * 0.5,
                                    width: double.infinity,
                                    child: Image.asset(
                                      "assets/images/uploadPhotoCrop.jpg",
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : SizedBox(
                                    height: deviceSize.height * 0.5,
                                    width: double.infinity,
                                    child: Image.file(
                                      File(imageModel.imagePath),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          );
                        }),
                        Obx(() {
                          return AnimatedOpacity(
                            opacity: createEventModel.visibility ? 1 : 0,
                            duration: const Duration(milliseconds: 200),
                            // curve: Curves.easeInCubic,
                            child: Container(
                              color: Colors.black54,
                            ),
                          );
                        }),
                        Obx(() {
                          return Visibility(
                            visible: createEventModel.visibility,
                            child: Align(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    iconSize: 45,
                                    onPressed: () {
                                      imageModel.pickImageFromGallery();
                                    },
                                    icon: const Icon(
                                      Bootstrap.camera2,
                                      // color: kprimaryColor,
                                    ),
                                    color: kwhite,
                                  ),
                                  Text(
                                    'Choose Event Image',
                                    style: Get.textTheme.bodyLarge!.copyWith(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            UnderlinedInputWidget(
                              controller: createEventModel.titleController,
                              hintText: 'Title',
                              validator: createEventModel.validateTitle,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            UnderlinedInputWidget(
                              controller: createEventModel.organizerController,
                              hintText: 'Organizer',
                              validator: createEventModel.validateOrganizer,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            UnderlinedInputWidget(
                              controller:
                                  createEventModel.descriptionController,
                              hintText: 'Description',
                              validator: createEventModel.validateDescription,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(() {
                        return SolidButtonWidget(
                          borderRadius: 20,
                          buttonText:
                              "Choose Date - ${weekdays[createEventModel.selectedDate.weekday - 1]}, ${createEventModel.selectedDate.day} ${months[createEventModel.selectedDate.month - 1]} ${createEventModel.selectedDate.year} ",
                          color: Colors.white24,
                          onPressed: () {
                            createEventModel.pickDate(context);
                          },
                        );
                      }),
                      const SizedBox(
                        height: 15,
                      ),
                      Obx(
                        () {
                          return SolidButtonWidget(
                            borderRadius: 20,
                            buttonText:
                                "Choose Time - ${createEventModel.selectedTime.hourOfPeriod}:${createEventModel.selectedTime.minute} ${createEventModel.selectedTime.period.toString().split('.')[1]}",
                            color: Colors.white24,
                            onPressed: () {
                              createEventModel.pickTime(context);
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SolidButtonWidget(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              // formKey.currentState!.save();
                              if (imageModel.imagePath == '') {
                                Get.snackbar(
                                    'Error', 'Event Image not selected');
                              }
                              await createEventModel.createEvent();
                            }
                          },
                          borderRadius: 20,
                          buttonText: 'Post Event',
                          color: kprimaryColor),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
