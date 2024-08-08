part of repo;

/// 与菜单管理相关的api仓库
class MenuRepo extends AppBaseRepo {
  /// 获取菜单状态Status
  Future<AResponse<MenuStatusBeanResponse>> fetchProfile() {
    return requestOnFuture(
      Api.sampleUrl,
      method: Method.post,
      params: {
        'username': 'username',
      },
      format: (data) => MenuStatusBeanResponse.fromMap(data),
    );
  }
}
