import 'package:floor/floor.dart';
import 'boon_entity.dart';

abstract class BoonDao {
  @Query('SELECT * FROM BoonEntity')
  Future<List<BoonEntity?>> findAllBoons();
  @Query('SELECT * FROM BoonEntity WHERE bid = :bid')
  Future<BoonEntity?> findBoonByBId(int bid);
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertBoon(BoonEntity boonEntity);
  @Query('DELETE FROM BoonEntity WHERE bid = :bid')
  Future<void> deleteBoonByBID(int bid);
  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateBoon(BoonEntity boonEntity);
}
