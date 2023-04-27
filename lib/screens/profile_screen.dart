import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/models/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/constants.dart';
import '../constants/theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    var profileModel = Get.put(ProfileModel());
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: RefreshIndicator(
        color: kwhite,
        backgroundColor: Colors.black26,
        onRefresh: () async {
          await profileModel.getUserDetails();
        },
        child: Scaffold(
          appBar: AppBar(),
          extendBodyBehindAppBar: true,
          body: FutureBuilder<QuerySnapshot>(
              future: profileModel.getUserDetails(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text("Something went wrong");
                }

                if (!snapshot.hasData) {
                  return Container(
                    decoration: kscaffoldGradient,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(
                          color: kprimaryColor,
                        ),
                        Text("Document does not exist"),
                      ],
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(
                    color: kprimaryColor,
                  );
                }

                return Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    SizedBox(
                      height: deviceSize.height * 0.4,
                      width: double.infinity,
                      child: Obx(() {
                        return CachedNetworkImage(
                          fadeInDuration: const Duration(milliseconds: 50),
                          imageUrl: profileModel.profilePictureUrl,
                          fit: BoxFit.cover,
                        );
                      }),
                    ),
                    Container(
                      // height: deviceSize.height * 0.6,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.15, 0.39, 1],
                          colors: [
                            Colors.transparent,
                            Color(0xff511911),
                            Color(0xff140A08),
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: deviceSize.height * 0.28,
                          ),
                          // CircleAvatar(
                          //   backgroundColor: Colors.transparent,
                          //   radius: 50,
                          //   backgroundImage: NetworkImage(
                          //     imagesList[2],
                          //   ),
                          // ),
                          Column(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: SizedBox(
                                    height: 120,
                                    width: 120,
                                    child: CachedNetworkImage(
                                      imageUrl: imagesList[5],
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                            ],
                          ),
                          Obx(() {
                            return Text(
                              profileModel.username,
                              textAlign: TextAlign.center,
                              style: Get.textTheme.headlineSmall!.copyWith(
                                  color: kwhite, fontWeight: FontWeight.bold),
                            );
                          }),
                          Obx(() {
                            return Text(
                              profileModel.name,
                              textAlign: TextAlign.center,
                              style: Get.textTheme.bodyMedium!.copyWith(
                                color: Colors.white38,
                              ),
                            );
                          }),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 30.0, left: 10, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'Bio:',
                                  style: Get.textTheme.bodyLarge!.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                                Obx(() {
                                  return Text(
                                    profileModel.bio,
                                    style: Get.textTheme.bodyMedium!.copyWith(
                                      color: Colors.white38,
                                    ),
                                  );
                                }),
                                const SizedBox(height: 15),
                                Text(
                                  'Department:',
                                  style: Get.textTheme.bodyLarge!.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                                Obx(() {
                                  return Text(
                                    profileModel.department,
                                    style: Get.textTheme.bodyMedium!.copyWith(
                                      color: Colors.white38,
                                    ),
                                  );
                                }),
                                const SizedBox(height: 15),
                                Text(
                                  'Roll Number:',
                                  style: Get.textTheme.bodyLarge!.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '20014104',
                                  style: Get.textTheme.bodyMedium!.copyWith(
                                    color: Colors.white38,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  'Semester:',
                                  style: Get.textTheme.bodyLarge!.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.',
                                  style: Get.textTheme.bodyMedium!.copyWith(
                                    color: Colors.white38,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                // TabBarView(
                                //     controller: _tabController,
                                //     children: [Text('Posts'), Text('Posts')])
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
