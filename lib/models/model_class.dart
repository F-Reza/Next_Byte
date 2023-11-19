const String tableDonor = 'tbl_needer';
const String tableDonorColId = 'id';
const String tableDonorColName = 'name';

class DonorModel {
  int? id;
  String name;

  DonorModel({
    this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      tableDonorColName: name,
    };
    if (id != null) {
      map[tableDonorColId] = id;
    }
    return map;
  }

  factory DonorModel.fromMap(Map<String, dynamic> map) =>
      DonorModel(
        id: map[tableDonorColId],
        name: map[tableDonorColName],
      );

  @override
  String toString() {
    return 'DonorModel{id: $id, name: $name}';
  }

}


  final bgList = <String>['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];


  final genderList = <String>['Male', 'Female', 'Others'];

  final areaList = <String>[
    'Dhaka',
    'Rangpur',
    'Khulna',
    'Chattogram',
    'Barishal',
    'Rajshahi',
    'Sylhet',
    'Mymensingh'
  ];


