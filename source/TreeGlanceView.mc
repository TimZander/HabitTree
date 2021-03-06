using Toybox.WatchUi;
using Toybox.Time;
using Toybox.Time;
using Toybox.Time.Gregorian;

(:glance)
class TreeGlanceView extends WatchUi.GlanceView {

    const age_x_offset = 40;

    var restartTimestamp;

    function initialize() {
        GlanceView.initialize();
        restartTimestamp = objectStoreGet(RESTART_TIMESTAMP_KEY);
        if(restartTimestamp == null) {
            plant();
        }
    }

    function onUpdate(dc) {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_TRANSPARENT);


        var now = Time.now().value();

        var elapsed = now - restartTimestamp;

        var days = elapsed / Gregorian.SECONDS_PER_DAY;
        var hours = (elapsed - Gregorian.SECONDS_PER_DAY * days) / Gregorian.SECONDS_PER_HOUR;

        var age = days + "d " + hours + "h";

        dc.drawText(
            age_x_offset,
            dc.getHeight() / 2,
            Graphics.FONT_SMALL,
            age,
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
        );
    }

    function plant() {
        restartTimestamp = Time.now().value();
        objectStorePut(RESISTED_TIMES_KEY, 0);
        objectStorePut(RESTART_TIMESTAMP_KEY, restartTimestamp);
    }
}
