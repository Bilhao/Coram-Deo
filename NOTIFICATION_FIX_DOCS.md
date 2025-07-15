# Notification Bug Fix Documentation

## Problem Summary
The life plan feature had a critical bug where notifications were not properly managed when users deleted or changed notification times. This caused:
1. Notifications to continue firing after being "deleted"
2. Duplicate notifications when changing times (firing at both old and new times)

## Root Cause Analysis
The issue was in the notification ID generation system in `PlanoDeVida.getTitleAndNotificationId()`:

**Before (Buggy):**
```dart
// All notification times for a title shared the same ID
int notiId = int.parse("${map["id"] + 1}$notiLength");
```

This meant:
- Item with ID 5 and 3 notification times → ALL get notification ID 63
- When deleting one time, it would try to cancel ID 63
- But all 3 notifications had ID 63, so behavior was unpredictable
- The notification system couldn't distinguish between different times

## Solution Implemented

**New System:**
- Each notification time gets its own unique ID
- ID format: `${itemId + 1}${timeIndex.padLeft(3, '0')}`
- Example: Item 5 with times ["08:00", "12:00", "18:00"]
  - 08:00 → ID 6000
  - 12:00 → ID 6001  
  - 18:00 → ID 6002

## Code Changes

### 1. data.dart - New Methods Added
```dart
// Generate unique notification ID for specific time within title
int generateNotificationId(int itemId, int timeIndex)

// Get notification ID for specific title and time
Future<int> getNotificationIdForTime(String title, String time)

// Get all notification IDs for a title (for bulk operations)
Future<List<int>> getAllNotificationIdsForTitle(String title)
```

### 2. provider.dart - Enhanced Cleanup
```dart
// Cancel all notifications when deleting an item
Future<void> removeItem(String title) async {
  List<int> notificationIds = await getAllNotificationIdsForTitle(title);
  for (int id in notificationIds) {
    await Notifier.stopNotification(id);
  }
  // ... rest of deletion
}
```

### 3. page.dart - Precise Notification Management
```dart
// When adding: Get unique ID for the new time
int notificationId = await provider.getNotificationIdForTime(title, time);
await Notifier.scheduledNotification(CustomNotification(id: notificationId, ...), time);

// When deleting: Cancel only the specific notification
int notificationId = await provider.getNotificationIdForTime(title, time);
if (notificationId != -1) {
  await Notifier.stopNotification(notificationId);
}
```

## Validation
- [x] Each notification time gets unique ID
- [x] Deleting specific time cancels only that notification  
- [x] Deleting item cancels all its notifications
- [x] No more duplicate notifications when changing times
- [x] Backward compatible with existing notification system

## Testing Scenarios
1. **Add multiple notifications** → Each gets unique ID
2. **Delete one notification** → Only that one is canceled
3. **Delete entire item** → All notifications canceled
4. **Change notification time** → Old canceled, new scheduled with new ID

This fix ensures the notification system behaves predictably and matches user expectations.