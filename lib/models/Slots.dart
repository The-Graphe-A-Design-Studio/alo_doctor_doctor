import 'dart:convert';

Slots slotsFromJson(String str) => Slots.fromJson(json.decode(str));

String slotsToJson(Slots data) => json.encode(data.toJson());

class Slots {
  Slots({
    this.slots,
  });

  List<Slot> slots;

  factory Slots.fromJson(Map<String, dynamic> json) => Slots(
    slots: List<Slot>.from(json["slots"].map((x) => Slot.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "slots": List<dynamic>.from(slots.map((x) => x.toJson())),
  };
}

class Slot {
  Slot({
    this.date,
    this.time,
  });

  String date;
  String time;

  factory Slot.fromJson(Map<String, dynamic> json) => Slot(
    date: json["date"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "time": time,
  };
}