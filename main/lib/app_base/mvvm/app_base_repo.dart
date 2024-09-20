library repo;

import 'package:foundation/base/mvvm/repo/base_repository.dart';
import 'package:foundation/base/mvvm/repo/dio_proxy.dart';
import 'package:foundation/common/network/dio_client.dart';
import '../http/sample_dio_proxy.dart';

import '../config/api.dart';

// repos
part '../repository/menu_repo.dart';

// models
part '../model/menu_status_response.dart';

/// 业务层的base请求仓库
class AppBaseRepo extends BaseRepository {
  @override
  DioProxy proxy = SampleDioProxy.get();

  Future<AResponse<T>> mockData<T>(Function doMock) {
    return Future.value(AResponse(doMock.call(), code: 200));
  }
}
