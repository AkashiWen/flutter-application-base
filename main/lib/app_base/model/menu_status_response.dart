part of repo;

/// api 数据转换和持有
class MenuStatusBeanResponse extends DataHolder<MenuStatusBean> {
  // api
  MenuStatusBeanResponse.fromMap(dynamic map) {
    convertList(map['menuStatusList'], (data) => MenuStatusBean.fromJson(data));
  }

  @override
  bool isEmpty() => dataList?.isEmpty ?? true;
}


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

