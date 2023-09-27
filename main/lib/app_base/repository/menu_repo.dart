part of repo;

/// 与菜单管理相关的api仓库
class MenuRepo extends BaseRepo {
  /// 获取菜单状态Status
  Future<AResponse<MenuStatusBeanHolder>> fetchProfile() {
    return requestOnFuture(
      Api.sampleUrl,
      method: Method.post,
      params: {
        'username': 'username',
      },
      format: (data) => MenuStatusBeanHolder.fromMap(data),
    );
  }
}
