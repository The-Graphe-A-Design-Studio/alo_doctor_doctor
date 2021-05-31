class SlotModel {
  bool isSelected;
  final String time;
  SlotModel(this.isSelected, this.time);

  static List<SlotModel> get morningSlots => [
        SlotModel(false, '05:30 am'),
        SlotModel(false, '06:30 am'),
        SlotModel(false, '07:30 am'),
        SlotModel(false, '08:30 am'),
        SlotModel(false, '09:30 am'),
        SlotModel(false, '10:30 am'),
        SlotModel(false, '11:30 am'),
        SlotModel(false, '04:30 am'),
      ];
  static List<SlotModel> get eveningSlots => [
        SlotModel(false, '12:30 pm'),
        SlotModel(false, '01:30 pm'),
        SlotModel(false, '02:30 pm'),
        SlotModel(false, '03:30 pm'),
        SlotModel(false, '04:30 pm'),
        SlotModel(false, '05:30 pm'),
        SlotModel(false, '06:30 pm'),
        SlotModel(false, '07:30 pm'),
        SlotModel(false, '08:30 pm'),
      ];
}
