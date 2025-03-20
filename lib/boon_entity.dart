import 'package:floor/floor.dart';

@Entity(tableName: 'boon')
class BoonEntity {
  @PrimaryKey(autoGenerate: true)
  int? bid;
  late String title;
  late String? desc;
  late String eventDate;
  late String startHour;
  late String startMinute;
  late String location;

  BoonEntity({
    this.bid,
    required this.title,
    this.desc,
    required this.eventDate,
    required this.startHour,
    required this.startMinute,
    required this.location,
  });
}
