import 'package:http/http.dart';

class DataModel {
  int? id;
  String? Name;
  String? UserEmail;
  String? Phone;
  String? BloodType;
  String? State;
  String? District;
  String? City;
  String? RequiredUnit;
  String? RequiredDate;
  String? HospitalName;
  String? DetailAboutCase;
  String? UserID;
  String? Post;
  String? Gender;


  DataModel({
    this.id,
    this.Phone,
    this.BloodType,
    this.UserEmail,
    this.State,
    this.District,
    this.City,
    this.DetailAboutCase,
    this.HospitalName,
    this.RequiredDate,
    this.UserID,
    this.RequiredUnit,
    this.Name,
    this.Post,
    this.Gender,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id']=id;
    data['Name'] = Name;
    data['UserEmail'] = UserEmail;
    data['Phone'] = Phone;
    data['BloodType'] = BloodType;
    data['State'] = State;
    data['District'] = District;
    data['City'] = City;
    data['Gender'] = Gender;
    data['DetailAboutCase'] = DetailAboutCase;
    data['HospitalName'] = HospitalName;
    data['RequiredUnit'] = RequiredUnit;
    data['RequiredDate'] = RequiredDate;
    data['UserID']= UserID;
    data['Post']= Post;
    return data;
  }
}



