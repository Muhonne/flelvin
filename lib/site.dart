
class Device {
  String id;
  int bri;
  bool on;
  String name;
  String roomId;

  Device({this.id, this.bri, this.on, this.name, this.roomId});

  factory Device.fromJson(dynamic json) {
    return Device(
      id: json['id'],
      name: json['name'],
      bri: json['state']['bri'],
      on: json['state']['on'],
      roomId: json['roomId'],
    );
  }
}

class Room {
  String id;
  String name;

  Room({this.id, this.name});

  factory Room.fromJson(dynamic json){
    return Room(
        id: json['id'],
        name: json['name']
    );
  }
}

class Site {
  String name = "";
  List<Device> devices = new List<Device>();
  List<Room> rooms = new List<Room>();

  Site({this.name, this.devices, this.rooms});

  factory Site.fromData(String name, List<Device> devices, List<Room> rooms){
    return Site(name: name, devices: devices, rooms: rooms);
  }

  getRoomBrightness(String roomId){
   List<Device> roomDevices = this.devices.where((device ) => device.roomId == roomId).toList();
   var sum = 0;
   roomDevices.forEach((device) {
     sum = sum + (device.on ? device.bri : 0);
   });
   // TODO: FIXME
    // return sum / roomDevices.length;
    return 0.0;
  }

}