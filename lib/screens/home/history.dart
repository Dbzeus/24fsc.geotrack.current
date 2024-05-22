import 'package:flutter/material.dart';
import 'package:geotrack24fsc/helpers/colors.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../models/GeoHistoryResponse.dart';

import '../../utils/hexcolor.dart';

class HistoryView extends StatelessWidget {
 final int index, length;
  final GeoHistoryResponseTableData data;

  const HistoryView(
    this.index,
    this.length,
    this.data, {

    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color c = HexColor.fromHex(data.colorCode);

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
        children: [
          Text(
            data.statusTime,
            style: const TextStyle(
                fontSize: 9,
                color: Colors.black54,
                fontWeight: FontWeight.w700),
          ),
          Padding(
            padding: const EdgeInsets.all(6),
            child: Text(
              data.geoStatus,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 10,
                  color: secondaryColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            data.distance,
            style: const TextStyle(
                fontSize: 9,
                color: Colors.black54,
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
      endChild: Card(
        color: lightBgGreenColor,
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              data.firstName.isEmpty
                  ? const SizedBox.shrink():
                   Column(
                      children: [
                        Text(
                          data.firstName,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                      ],
                    ),
              Text(
                data.statusAddress,

                style: const TextStyle(fontSize: 11, color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
