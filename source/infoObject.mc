using Toybox.System;
using Toybox.Time;
using Toybox.Time.Gregorian as Calendar;

class infoObject {
    var drawableName;

    function initialize(argument){
        drawableName = argument;
    }

    // this function selects the information type based on the information read from the settings file
    function getText(){
        var infoName = getApp().getProperty("Content" + drawableName);

        switch (infoName) {
            case "time":
                // return the current local time
                return getTimeString(null);
                break;

            case "time_alternative_zone":
                // return the time for an alternative timezone
                // -> read the alternative timezone from the settings
                return getTimeString(getApp().getProperty("AlternateTimezone"));
                break;

            case "date":
                // return the current local date
                return getDateString();
                break;

            default:
                return "nA";
                break;
        }
    }

    /////////////////////////////////////////////////////////////////////////
    // the following functions read and process a certain information type
    /////////////////////////////////////////////////////////////////////////

    function getTimeString(displayTimezone) as String {
        //if "displayTimezone" contains something else than null, the indicated timezone in UTC offset will be returned

        // Get the current time and format it correctly
        var timeFormat = "$1$:$2$";
        var clockTime = System.getClockTime();
        var hours = clockTime.hour;

        // check if 24h format or AM / PM format
        if (!System.getDeviceSettings().is24Hour) {
            if (hours > 12) {
                hours = hours - 12;
            }
        }

        // check if different timzeone required
        if (displayTimezone != null) {
            var localOffsetHour = (System.getClockTime().dst + System.getClockTime().timeZoneOffset) / 3600;

            //var utcHour = calculateHour (hours, currentOffset, targetOffset;

            hours = calculateHour(hours, localOffsetHour, displayTimezone);
        }

        // check if military format (without ":")
        if (getApp().getProperty("UseMilitaryFormat")) {
            timeFormat = "$1$$2$";
            hours = hours.format("%02d");
        }

        return Lang.format(timeFormat, [hours, clockTime.min.format("%02d")]);
    }

    function getDateString(){
        // Get the current date and format it correctly
        var today = Calendar.info(Time.now(), Time.FORMAT_MEDIUM);
        var dateString = Lang.format(
            "$1$ $2$ $3$",
            [
                today.day_of_week,
                today.day,
                today.month
            ]
        );

        return dateString;
    }


    /////////////////////////////////////////////////////////////////////////
    // the following functions help in the preparation of data
    /////////////////////////////////////////////////////////////////////////

    function calculateHour(hour, currentOffset, targetOffset){
        // ensure we have all values in Number format
        hour = hour.toNumber();
        currentOffset = currentOffset.toNumber();
        targetOffset = targetOffset.toNumber();

        var newHour = hour - currentOffset + targetOffset;

        if (newHour >= 24) {
            newHour = newHour - 24;
        }

        return newHour;
    }

}