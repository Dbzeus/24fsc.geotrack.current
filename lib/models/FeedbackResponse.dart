class FeedbackResponse {
  FeedbackResponse(
      this.rtnStatus,
      this.rtnData,);

  FeedbackResponse.fromJson(dynamic json) {
    rtnStatus = json['RtnStatus'];
    if (json['RtnData'] != null) {
      rtnData = [];
      json['RtnData'].forEach((v) {
        rtnData.add(FeedbackData.fromJson(v));
      });
    }
  }
  late bool rtnStatus;
  late List<FeedbackData> rtnData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RtnStatus'] = rtnStatus;
    if (rtnData != null) {
      map['RtnData'] = rtnData.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class FeedbackData {
  FeedbackData(
      this.feedbackID, 
      this.feedback,);

  FeedbackData.fromJson(dynamic json) {
    feedbackID = json['FeedbackID'];
    feedback = json['Feedback'];
  }
  late int feedbackID;
  late String feedback;
  double rating=1;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['FeedbackID'] = feedbackID;
    map['Feedback'] = feedback;
    return map;
  }

}