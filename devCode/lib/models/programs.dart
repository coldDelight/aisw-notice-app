class Programs {
  late String title;
  late String startdate;
  late String enddate;
  late String mileage;
  late String program_state;
  late String program_id;


  Programs({required this.title,required this.startdate,required this.enddate,
    required this.mileage,required this.program_id,required this.program_state});

  Programs.fromJson(Map<String, dynamic> json) {//명명 생정자
    title = json['title'];
    startdate = json['startdate'];
    enddate = json['enddate'];
    mileage = json['mileage'].toString();
    program_state = json['program_state'];
    program_id = json['program_id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['startDate'] = startdate;
    data['endDate'] = enddate;
    data['mileage'] = mileage;
    data['program_state'] = program_state;
    data['program_id'] = program_id;
    return data;
  }
}
