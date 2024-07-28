import 'package:vizmo_app/features/events/presentation/widgets/event_tile.dart';

mixin EventTypeUtility {
  EventStatus checkEventStatus({required String eventStatus}) {
    switch (eventStatus) {
      case "Confirmed":
        return EventStatus.confirmed;
      case "Cancelled":
        return EventStatus.cancelled;
      default:
        return EventStatus.pending;
    }
  }
}
