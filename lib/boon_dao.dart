import 'package:floor/floor.dart';
import 'boon_entity.dart';

@dao
abstract class BoonDao {
  @Query('SELECT * FROM boon')
  Future<List<BoonEntity?>> findAllBoons();

  @Query('SELECT * FROM boon WHERE bid = :bid')
  Future<BoonEntity?> findBoonByBId(int bid);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertBoon(BoonEntity boonEntity);

  @Query('DELETE FROM boon WHERE bid = :bid')
  Future<void> deleteBoonByBID(int bid);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateBoon(BoonEntity boonEntity);
}
