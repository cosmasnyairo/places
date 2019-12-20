import 'package:http/http.dart' as http;
import 'dart:convert';

const Api_Key = 'API_KEY';

class LocationHelper {
  static String generatepreviewImage({double latitude, double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=17&size=600x380&maptype=roadmap&markers=color:orange%7Clabel:A%7C$latitude,$longitude&key=$Api_Key';
  }

  static Future<String> getPlaceAddress(double latitude, double longitude) async {
   final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$Api_Key';
   final response =await http.get(url);
   return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
 