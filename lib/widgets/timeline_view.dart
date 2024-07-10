import 'package:flutter/material.dart';
import 'package:geotrack24fsc/helpers/colors.dart';
import 'package:geotrack24fsc/models/DashboardResponse.dart';
import 'package:timeline_tile/timeline_tile.dart';



class TimelineView extends StatelessWidget {
 final int index, length;
  final TimeLine data;

  const TimelineView(
    this.index,
    this.length,  this.data,
     {

    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color c =  primaryColor;//HexColor.fromHex(data.colorCode);

    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.23,
      isFirst: index == 0,
      isLast: index == (length - 1),
      indicatorStyle: IndicatorStyle(
        drawGap: true,
        width: 24,
        indicator: GestureDetector(
            onTap: () {
              //openMap('${data.lat}', '${data.lng}', data.customerName);
            },
            child: Container(
              height: 20,
              width: 20,
              
              decoration:  BoxDecoration(
                shape: BoxShape.circle,
                color: secondaryColor,
                border: Border.all(
                  color: secondaryColor.withAlpha(30),
                  width: 8
                )
              ),
            )
            ),
      ),
      afterLineStyle: LineStyle(thickness: 2, color: secondaryColor),
      beforeLineStyle: LineStyle(thickness: 2, color: secondaryColor),
      startChild: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            data.statusTime,
            style: const TextStyle(
                fontSize: 10,
                color: Colors.black54,
                fontWeight: FontWeight.w700),
          ),
         const SizedBox(
           height: 4,
         ),
          Text(
            data.distance,
            style: const TextStyle(
                fontSize: 10,
                color: secondaryColor,
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
      endChild: Container(
        decoration: BoxDecoration(
          color: lightBgGreenColor,
          border: Border.all(color: primaryColor),
          borderRadius: BorderRadius.circular(12)
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        padding: EdgeInsets.all(6),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.geoStatus,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 12,
                  color: secondaryColor,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              data.statusAddress,
              textAlign: TextAlign.start,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 8,
                  color: blackColor,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
