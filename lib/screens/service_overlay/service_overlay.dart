import 'package:flutter/material.dart';
import 'package:geotrack24fsc/screens/service_overlay/service_overlay_controller.dart';
import 'package:get/get.dart';

import '../../helpers/colors.dart';
import '../../routes/app_routes.dart';

// class ServiceOverlay extends StatefulWidget {
//   const ServiceOverlay({super.key});
//
//   @override
//   State<ServiceOverlay> createState() => _ServiceOverlayState();
// }
//
// class _ServiceOverlayState extends State<ServiceOverlay> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }


class ServiceOverlay extends StatelessWidget/*GetView<ServiceOverlayController>*/ {
   const ServiceOverlay({super.key});

  /*@override
  final controller= Get.lazyPut(ServiceOverlayController());*/



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
         // debugPrint("ServiceOverlay");
        // Get.toNamed(Routes.home);

      },
      child: Container(

        height: 50,
        width: 50,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.amberAccent,
          shape: BoxShape.circle
        ),
        child: Center(
          child: Image.asset("assets/logo/24FSC.png",
          width: 50,
          height: 50,
          fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
