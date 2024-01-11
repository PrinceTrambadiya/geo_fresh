class QcCerificateModel {
  String admixture;
  String ana_end_date;
  String ana_start_date;
  String bag_type;
  String color;
  String dates;
  int id;
  int item_id;
  String moisture;
  String odour;
  String other_color_sids;
  String product_name;
  String purity;
  String sample_bags;
  String sample_by;
  String sample_qty;
  String sample_refrence_no;
  String sealed_cargo_pictures;
  String storage_condition;
  String total_bags;
  String total_qty;
  int user_id;

  QcCerificateModel(
      {this.admixture,
      this.ana_end_date,
      this.ana_start_date,
      this.bag_type,
      this.color,
      this.dates,
      this.id,
      this.item_id,
      this.moisture,
      this.odour,
      this.other_color_sids,
      this.product_name,
      this.purity,
      this.sample_bags,
      this.sample_by,
      this.sample_qty,
      this.sample_refrence_no,
      this.sealed_cargo_pictures,
      this.storage_condition,
      this.total_bags,
      this.total_qty,
      this.user_id});

  factory QcCerificateModel.fromJson(Map<String, dynamic> json) {
    return QcCerificateModel(
      admixture: json['admixture'],
      ana_end_date: json['ana_end_date'],
      ana_start_date: json['ana_start_date'],
      bag_type: json['bag_type'],
      color: json['color'],
      dates: json['dates'],
      id: json['id'],
      item_id: json['item_id'],
      moisture: json['moisture'],
      odour: json['odour'],
      other_color_sids: json['other_color_sids'],
      product_name: json['product_name'],
      purity: json['purity'],
      sample_bags: json['sample_bags'],
      sample_by: json['sample_by'],
      sample_qty: json['sample_qty'],
      sample_refrence_no: json['sample_refrence_no'],
      sealed_cargo_pictures: json['sealed_cargo_pictures'],
      storage_condition: json['storage_condition'],
      total_bags: json['total_bags'],
      total_qty: json['total_qty'],
      user_id: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['admixture'] = this.admixture;
    data['ana_end_date'] = this.ana_end_date;
    data['ana_start_date'] = this.ana_start_date;
    data['bag_type'] = this.bag_type;
    data['color'] = this.color;
    data['dates'] = this.dates;
    data['id'] = this.id;
    data['item_id'] = this.item_id;
    data['moisture'] = this.moisture;
    data['odour'] = this.odour;
    data['other_color_sids'] = this.other_color_sids;
    data['product_name'] = this.product_name;
    data['purity'] = this.purity;
    data['sample_bags'] = this.sample_bags;
    data['sample_by'] = this.sample_by;
    data['sample_qty'] = this.sample_qty;
    data['sample_refrence_no'] = this.sample_refrence_no;
    data['sealed_cargo_pictures'] = this.sealed_cargo_pictures;
    data['storage_condition'] = this.storage_condition;
    data['total_bags'] = this.total_bags;
    data['total_qty'] = this.total_qty;
    data['user_id'] = this.user_id;
    return data;
  }
}
