class DropDownDataModel {
  String id;
  String title;

  DropDownDataModel({this.id, this.title});

  factory DropDownDataModel.fromJson(Map<String, dynamic> json) {
    return DropDownDataModel(
      id: json['id'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}
