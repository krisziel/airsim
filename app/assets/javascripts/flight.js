function calculateDuration(distance, speed) {
  var duration = 40;
  duration += ((distance/speed)*60);
  return Math.round(duration);
}
function maxFrequencies(duration,turn_time) {
  return Math.floor(10080/(turn_time+duration)/2);
}
function minutesToHours(minutes) {
  var hours = Math.floor(minutes/60);
  var minutes = (minutes%60);
  return hours + ":" + minutes;
}
