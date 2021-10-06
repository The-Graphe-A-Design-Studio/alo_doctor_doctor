// To parse this JSON data, do
//
//     final serverSlots = serverSlotsFromJson(jsonString);

import 'dart:convert';

ServerSlots serverSlotsFromJson(String str) => ServerSlots.fromJson(json.decode(str));

String serverSlotsToJson(ServerSlots data) => json.encode(data.toJson());

class ServerSlots {
  ServerSlots({
    this.success,
    this.slots,
  });

  int success;
  List<Slot> slots;

  factory ServerSlots.fromJson(Map<String, dynamic> json) => ServerSlots(
    success: json["success"],
    slots: List<Slot>.from(json["slots"].map((x) => Slot.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "slots": List<dynamic>.from(slots.map((x) => x.toJson())),
  };
}

class Slot {
  Slot({
    this.slotDate,
    this.slotTime,
  });

  String slotDate;
  List<SlotTime> slotTime;

  factory Slot.fromJson(Map<String, dynamic> json) => Slot(
    slotDate: json["slot_date"],
    slotTime: List<SlotTime>.from(json["slot_time"].map((x) => SlotTime.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "slot_date": slotDate,
    "slot_time": List<dynamic>.from(slotTime.map((x) => x.toJson())),
  };
}

class SlotTime {
  SlotTime({
    this.id,
    this.time,
    this.status,
    this.selected = false,
  });

  int id;
  String time;
  int status;
  bool selected;

  factory SlotTime.fromJson(Map<String, dynamic> json) => SlotTime(
    id: json["id"],
    time: json["time"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "time": time,
    "status": status,
  };
}
