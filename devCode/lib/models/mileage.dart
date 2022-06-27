class Mileage {
  late String title;
  late String program_mileage;
  late String mileage_date;
  late String date_time;

  Mileage(this.title, this.program_mileage, this.mileage_date, this.date_time);

  Mileage.fromJson(Map<String, dynamic> json) {//명명 생정자
    title = json['title'];
    mileage_date = json['mileage_date'];
    program_mileage = json['program_mileage'].toString();

    date_time = json['date_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['mileage_date'] = mileage_date;
    data['program_mileage'] = program_mileage;
    data['date_time'] = date_time;
    return data;
  }
}

class CurrentMileage {
  late String semester;

  CurrentMileage({ required this.semester});

  CurrentMileage.fromJson(Map<String, dynamic> json) {//명명 생정자
    semester = json['semester'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data ['semester'] = semester;
    return data;
  }
}

