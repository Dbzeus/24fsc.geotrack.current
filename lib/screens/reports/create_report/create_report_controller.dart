import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geotrack24fsc/utils/constants.dart';
import 'package:geotrack24fsc/utils/session.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:record/record.dart';
import 'package:file/local.dart';
import 'package:path_provider/path_provider.dart';

import '../../../apis/api_call.dart';
import '../../../routes/app_routes.dart';

class CreateReportController extends GetxController {
  TextEditingController clientNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController contactPersonController = TextEditingController();
  TextEditingController contactPersonNumberController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  DateTime now = DateTime.now();

  RxBool isLoading = false.obs;

  final box = GetStorage();

  DateFormat formatter = DateFormat("dd-MM-yyyy");
  DateFormat mdyFormatter = DateFormat("MM-dd-yyyy");
  RxString selectedDateFormat = ''.obs;

  RxBool isRecordPause = false.obs,
      isRecordFinish = false.obs,
      isPlayRecord = false.obs,
      isRecordStarted = false.obs;
  RxList selfies = RxList();

  //audio record
  RxString recordString = ''.obs, recordFilePath = ''.obs;
  LocalFileSystem localFileSystem = LocalFileSystem();

/*  late FlutterAudioRecorder _recorder;

  late Recording current;
  Rx<RecordingStatus> currentStatus = Rx(RecordingStatus.Unset);*/

  final record = AudioRecorder();

  TimeOfDay ftime = TimeOfDay.now(), ttime = TimeOfDay.now();

  RxInt isAudioUploaded = 0.obs;

  void selectDate() async {
    try {
      DateTime dt = now;
      final DateTime? pickedDate = await showDatePicker(
          context: Get.context!,
          initialDate: dt,
          firstDate: DateTime.now().subtract(const Duration(days: 60)),
          lastDate: DateTime.now());

      if (pickedDate != null) {
        now = pickedDate;
        selectedDateFormat(formatter.format(now));
        dateController.text = selectedDateFormat.value;
      }
    } catch (e) {}
  }

  void selectToTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: Get.context!,
      initialTime: ttime,
    );

    if (picked != null) {
      ttime = picked;
      timeController.text = ttime.format(Get.context!);
    }
  }

  void startRecord() async {
    try {
      if (await record.hasPermission()) {
        String customPath = '/meet_service_';
        Directory? appDocDirectory;
        if (Platform.isIOS) {
          appDocDirectory = await getApplicationDocumentsDirectory();
        } else {
          appDocDirectory = await getExternalStorageDirectory();
        }

        if (appDocDirectory == null) return;

        // can add extension like ".mp4" ".wav" ".m4a" ".aac"
        customPath = appDocDirectory.path +
            customPath +
            DateTime.now().millisecondsSinceEpoch.toString();

        //await box.write(Session.audioPath, customPath);

        // Start recording
        await record.start(
          const RecordConfig(),
          path: '$customPath.mp3',
        );

        showToastMsg("Record Started");

        isRecordStarted(true);
      }

      /*if (await FlutterAudioRecorder.hasPermissions) {
        String customPath = '/meet_service_';
        Directory appDocDirectory;
        if (Platform.isIOS) {
          appDocDirectory = await getApplicationDocumentsDirectory();
        } else {
          appDocDirectory = await getExternalStorageDirectory();
        }

        // can add extension like ".mp4" ".wav" ".m4a" ".aac"
        customPath = appDocDirectory.path +
            customPath +
            DateTime.now().millisecondsSinceEpoch.toString();

        // .wav <---> AudioFormat.WAV
        // .mp4 .m4a .aac <---> AudioFormat.AAC
        // AudioFormat is optional, if given value, will overwrite path extension when there is conflicts.
        _recorder =
            FlutterAudioRecorder(customPath, audioFormat: AudioFormat.WAV);

        await _recorder.initialized;
        // after initialization
        current = await _recorder.current(channel: 0);
        print(current);
        // should be "Initialized", if all working fine
        currentStatus(current.status);
        print(currentStatus);
      } else {
        showToastMsg('You must accept permissions');
      }*/
    } catch (e) {
      showToastMsg(e.toString());
      debugPrint("ERROR:" + e.toString());
    }

    /*try {
      await _recorder.start();
      var recording = await _recorder.current(channel: 0);

      current = recording;

      const tick = const Duration(milliseconds: 50);
      new Timer.periodic(tick, (Timer t) async {
        if (currentStatus == RecordingStatus.Stopped) {
          t.cancel();
        }

        current = await _recorder.current(channel: 0);

        recordString(
            'Recording ${current.duration.toString().split('.').first.padLeft(8, "0")}');
        currentStatus(current.status);
      });
      showToastMsg("Record Started");

      isRecordStarted(true);
    } catch (e) {
      print(e);
    }*/
  }

  void stopRecord() async {
    try {
      var result = await record.stop();
      if (result == null) return;
      print("Stop recording: ${result.toString()}");
      // print("Stop recording: ${result.duration}");
      File recorderFile = localFileSystem.file(result);
      print("File length: ${await recorderFile.length()}");
      recordFilePath(result);
      // current = result;
      // currentStatus(current.status);
      showToastMsg("Record Stopped");
      // recordString('Record Duration ${current.duration.toString().split('.').first.padLeft(8, "0")}');
      recordString('Recorded');
      isRecordStarted(false);
      //box.write(Session.audioPath, recordFilePath.value);
    } catch (e) {
      debugPrint("STOP:${e.toString()}");
    }
  }

  submitVisitingReport() async {
    if (await isNetConnected()) {
      isLoading(true);
      try {
        if (dateController.text.isEmpty) {
          showToastMsg('Choose date');
        } else if (timeController.text.isEmpty) {
          showToastMsg('Choose time');
        } else if (clientNameController.text.isEmpty) {
          showToastMsg('Enter Client name');
        } else if (contactPersonController.text.isEmpty) {
          showToastMsg('Enter Contact Person');
        } else if (contactPersonNumberController.text.isEmpty) {
          showToastMsg('Enter Contact Person number');
        } else if (remarkController.text.isEmpty) {
          showToastMsg('Enter Remarks');
        } else {

          var params = {
            "VisitingID": 0,
            "VisitingDate":mdyFormatter.format(formatter.parse(dateController.text)),
            "VisitingTime": timeController.text,
            "ClientName": clientNameController.text.trim(),
            "ContactPersonName": contactPersonController.text.trim(),
            "ContactPersonNo": contactPersonNumberController.text.trim(),
            "Remarks": remarkController.text.trim(),
            "CUID": box.read(Session.userid) ?? -1,
          };

          var response = await ApiCall().submitVisitingReport(params, [""]);
          if (response != null) {
            if (response["RtnStatus"]) {
              //Get.offAndToNamed(Routes.visitingReport);
            } else {
              showToastMsg(response["RtnMessage"]);
            }
          }
        }
      } catch (e) {
        debugPrint("catch error: ${e.toString()}");
      }
    } else {
      showToastMsg("Check your internet connection");
    }
    isLoading(false);
  }
}
