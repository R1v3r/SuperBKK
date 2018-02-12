SuperBKK


This is the homework for the iOS developer position at Supercharge! You have 3 hours to fulfill this task. Please write us when you start and send it back within 3 hours. When you finished please upload your code to GitHub and share your link with us!


You can use Objective-C or Swift code. Choose the language you feel more comfortable with.


@required


1)

The user is currently dwell at Deak Ferenc ter (lat: 47.497509 long: 19.054193)


The app must parse the following JSON file and list only the public transportation station in a 1 km radius: http://bkk-api.supercharge.io/stops

A more basic JSON response can be found here: https://gist.github.com/reden87/b6521406ea6954c1bfa227f8fd20fe43


2)

List all transportation lines (routes) for each stops.


You can use the following API for this task, it collects arrivals and departures for a specific stop: http://futar.bkk.hu/bkk-utvonaltervezo-api/ws/otp/api/where/arrivals-and-departures-for-stop.json?stopId=BKK_008021


The stopId parameter’s format should be BKK_<stop_id_from_the_previous_JSON>


You can find a little help in the next page which contains a few highlighted key you need to use from this JSON to accomplish the task.


@optional

Show the departure times for the lines.
