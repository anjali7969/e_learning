// dashboard/data/models/dashboard_item_model.dart
import '../../domain/entities/dashboard_item_entity.dart';

class DashboardItemModel extends DashboardItemEntity {
  DashboardItemModel({required String id, required String title})
      : super(id: id, title: title);

  factory DashboardItemModel.fromJson(Map<String, dynamic> json) {
    return DashboardItemModel(
      id: json['id'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
    };
  }
}
