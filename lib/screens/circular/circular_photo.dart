import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geotrack24fsc/widgets/custom_edittext.dart';
import 'package:get/get.dart';

import '../../helpers/colors.dart';
import '../../routes/app_routes.dart';


class CircularPhotoScreen extends StatelessWidget {
  CircularPhotoScreen({super.key});

  TextEditingController remarkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(

            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: blackColor,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/back.svg",
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  const Text(
                    "Wishes",
                    style: TextStyle(
                      fontSize: 16,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SvgPicture.asset(
                      "assets/circular/cardbg.svg",
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    right: 20,
                    bottom: 10,
                    child: SvgPicture.asset(
                      "assets/circular/bdayillus.svg",
                      height: 110,
                    ),
                  ),
                  const Positioned(
                    bottom: -20,
                    left: -20,
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage:
                      AssetImage("assets/circular/image.jpg"),
                    ),
                  ),

                  const Positioned(
                    top: 25,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        Text('Today is Dinesh\n BirthDay',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold
                            )),



                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                height: 80,
                width: double.infinity,
                padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          offset: const Offset(1, 3),
                          spreadRadius: 1.5,
                          blurRadius: 4)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Happy Birthday",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.blue.shade900,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    const Text(
                      "Today freefood for all the employee",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.calendar_month,
                          size: 14,
                          color: Colors.blue.shade900,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        const Text(
                          '29-03-2024',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () async {
                  await showAlert();
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  decoration: BoxDecoration(
                      color: Colors.blue.shade900,
                      borderRadius: BorderRadius.circular(12)),
                  child: const Center(
                    child: Text("Send wishes",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showAlert({
    bool isDismiss = true,
  }) {
    Get.focusScope?.unfocus();
    return showDialog(
      context: Get.context!,
      barrierDismissible: isDismiss,
      builder: (BuildContext con) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "wishes",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomEditText(
                  hintText: 'Write Something...',
                  maxLines: 3,
                  controller: remarkController,
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(

                  children: [
                    Center(
                      child: Container(
                        height:20,

                    width: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.blue.shade900,),
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                          child: Text("Happy Birthday",
                              textAlign: TextAlign.center,
                              style:  TextStyle(
                                  color: Colors.blue.shade900,
                                  fontSize: 8,
                                  )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Center(
                      child: Container(
                        height:20,

                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.blue.shade900,),
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                          child: Text("God Bless You",
                              textAlign: TextAlign.center,
                              style:  TextStyle(
                                color: Colors.blue.shade900,
                                fontSize: 8,
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  height:20,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.blue.shade900,),
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: Text("Once again happy birthday",
                        textAlign: TextAlign.center,
                        style:  TextStyle(
                          color: Colors.blue.shade900,
                          fontSize: 8,
                        )),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Center(
                  child: Container(
                    height: 50,
                    width: 200,
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    decoration: BoxDecoration(
                        color: Colors.blue.shade900,
                        borderRadius: BorderRadius.circular(12)),
                    child: const Center(
                      child: Text("Send",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),

              ],
            ),
          ),
        );
      },
    );
  }
}
