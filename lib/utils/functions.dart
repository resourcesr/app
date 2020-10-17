String capitalize(String str) {
  return "${str[0].toUpperCase()}${str.substring(1)}";
}

// ignore: missing_return
String timeAgo(timestamp) {
  var diff = DateTime.now().toUtc().millisecondsSinceEpoch - (timestamp);
  diff = diff / 1000;
  if (diff <= 60)
    return (diff == 1) ? 'Just now' : '${diff.toStringAsFixed(2)} secs ago';
  else if (diff >= 60 && diff <= 3600)
    return (diff / 60 == 1)
        ? "mint ago"
        : '${(diff / 60).toStringAsFixed(2)} mins ago';
  else if (diff >= 3600 && diff <= 86400)
    return (diff / 3600 == 1)
        ? "An hr ago"
        : '${(diff / 3600).toStringAsFixed(2)} hrs ago';
  else if (diff >= 86400 && diff <= 604800)
    return (diff / 86400 == 1)
        ? "Day ago"
        : '${(diff / 86400).toStringAsFixed(2)} days ago';
  else if (diff >= 604800 && diff <= 2600640)
    return (diff / 604800 == 1)
        ? "Week ago"
        : '${(diff / 604800).toStringAsFixed(2)} weeks ago';
  else if (diff >= 2600640 && diff <= 31207680)
    return (diff / 2600640 == 1)
        ? "Month ago"
        : '${(diff / 2600640).toStringAsFixed(2)} Months ago';
  else if (diff >= 31207680)
    return (diff / 31207680 == 1)
        ? "Yr ago"
        : '${(diff / 31207680).toStringAsFixed(2)} yrs ago';
}

humanize(String time) {
  var t = time.split(":");
  var hr = int.parse(t[0]);
  var mint = int.parse(t[1]);
  return "${hr != 12 ? hr % 12 : hr}:${mint <= 9 ? (mint.toString() + "0") : mint} ${hr >= 12 ? "PM" : "AM"}";
}

calcluateDuration(String start, String end) {
  var s = start.split(":");
  var e = end.split(":");
  return "${int.parse(e[0]) - int.parse(s[0])}:${int.parse(e[1]) - int.parse(s[1])} hr(s)";
}
