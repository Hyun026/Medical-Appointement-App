


class UserModel{

  final String? id;
  final String name;

  const UserModel({
    this.id,
    required this.name,
  });

  toJson(){
    return{
      "name" : name,

    };
  }
}