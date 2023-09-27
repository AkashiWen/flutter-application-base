part of repo;

/// 菜品状态tag bean
class MenuStatusBean extends LocalModel {
  int id = 0;
  String name = "";

  MenuStatusBean.fromJson(dynamic json) {
    id = json['code'];
    name = json['info'];
  }

  @override
  Map<String, dynamic> toJson() => {
    'code': id,
    'info': name,
  };
}

/// api 数据转换和持有
class MenuStatusBeanHolder extends DataHolder<MenuStatusBean> {
  // api
  MenuStatusBeanHolder.fromMap(dynamic map) {
    convertList(map['menuStatusList'], (data) => MenuStatusBean.fromJson(data));
  }

  @override
  bool isEmpty() => dataList?.isEmpty ?? true;
}
