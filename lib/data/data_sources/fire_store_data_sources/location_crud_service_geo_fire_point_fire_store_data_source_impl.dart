import 'package:firestore_db_impl/firestore_db_impl.dart';
import 'package:flutter/foundation.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';
import 'package:location/data/data_sources/i_location_services/i_location_service_geo_fire_point_provider.dart';
import '../i_location_services/i_location_crud_service.dart';

class LocationCrudServiceGeoFirePointFireStoreDataSourceImpl implements ILocationCrudService {
  final ILocationServiceGeoFirePointProvider iGeoFireLocationService;
  final IFireStoreDbService fireStoreDbService;

  LocationCrudServiceGeoFirePointFireStoreDataSourceImpl(
      {required this.fireStoreDbService,
        required this.iGeoFireLocationService});

  @override
  Future<bool> updateLocation(
      {required String id,
        required String path,
        String field = "position"}) async {
    try {
      final GeoFirePoint? point =
      await iGeoFireLocationService.getCurrentLocation();
      final Map<String, dynamic> position = <String, dynamic>{
        field: point?.data
      };

      return await fireStoreDbService.updateDocument(
        data: position,
        path: path,
        id: id,
        successTxt: "Location Updated Successfully!",
      );
    } catch (e) {
      debugPrint('GeoFirePointServiceImpl | updateLocation| error: $e');
      return false;
    }
  }
}