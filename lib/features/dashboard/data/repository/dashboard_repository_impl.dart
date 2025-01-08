// dashboard/data/repositories/dashboard_repository_impl.dart
import '../../domain/repositories/dashboard_repository.dart';
import '../datasources/dashboard_local_data_source.dart';
import '../models/dashboard_item_model.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardLocalDataSource localDataSource;

  DashboardRepositoryImpl(this.localDataSource);

  @override
  Future<List<DashboardItemModel>> getDashboardItems() async {
    return await localDataSource.getDashboardItems();
  }

  @override
  Future<void> saveDashboardItem(DashboardItemModel item) async {
    await localDataSource.saveDashboardItem(item.toJson());
  }
}
