// Function to determine the part of the day based on the given time.
String determineDayPart(DateTime currentTime) {
  int hour = currentTime.hour;
  // Assuming the time is in a 24-hour format
  if (hour >= 6 && hour < 12) {
    return "Breakfast";
  } else if (hour >= 12 && hour < 16) {
    return "Lunch";
  } else if (hour >= 16 && hour < 23) {
    return "Evening";
  } else {
    return "Outside Operating Hours";
  }
}
