import 'package:flelvin/site.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Api {
  String apiUrl;
  Map<String, String> postHeaders = {"Content-Type": "application/json"};

  Api(String siteKey) {
    this.apiUrl = "https://houmkolmonen.herokuapp.com/api/site/" + siteKey;
  }

  Future<Site> fetchSite() async {
    final response = await http.get(apiUrl);
    if (response.statusCode == 200) {
      List<dynamic> devices = json.decode(response.body)['devices'];
      List<Device> parsedDevices =
          List<Device>.from(devices.map((d) => Device.fromJson(d)));

      List<dynamic> rooms = json.decode(response.body)['locations']['rooms'];
      List<Room> parsedRooms =
          List<Room>.from(rooms.map((r) => Room.fromJson(r)));

      String name = json.decode(response.body)['name'];
      return Site.fromData(name, parsedDevices, parsedRooms);
    } else {
      throw Exception('Failed to load.');
    }
  }

  allOff() {
     String jsonBody = json.encode({
      "id": "allOff",
    });
    http.post(apiUrl + "/applyScene", headers: postHeaders, body: jsonBody);
  }

  applyDevice(String id, bool on, int bri) {
    String jsonBody = json.encode({
      "id": id,
      "state": {"on": on, "bri": bri}
    });
    http.post(apiUrl + "/applyDevice", headers: postHeaders, body: jsonBody);
  }

  lightOff(String id) {
    String jsonBody = json.encode({
      "id": id,
      "state": {"on": false}
    });
    http.post(apiUrl + "/applyDevice", headers: postHeaders, body: jsonBody);
  }

  lightOn(String id) {
    String jsonBody = json.encode({
      "id": id,
      "state": {"on": true, "bri": 150}
    });
    http.post(apiUrl + "/applyDevice", headers: postHeaders, body: jsonBody);
  }

  applyRoom(String id, bool on, int bri) {
    String jsonBody = json.encode({
      "id": id,
      "state": {"on": true, "bri": bri}
    });
    http.post(apiUrl + "/applyRoom", headers: postHeaders, body: jsonBody);
  }
}
