import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class infocircleView extends WatchUi.WatchFace {
    var fontTime;

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
        //fontTime = WatchUi.loadResource( Rez.Fonts.future_earth );

    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {

        // Update the view
        var timeLabel = View.findDrawableById("TimeLabel") as TextArea;
        var timeLabelInfo = new infoObject("TimeLabel");
        timeLabel.setText(timeLabelInfo.getText());

        var centerUpper = View.findDrawableById("CenterUpper") as Text;
        var centerUpperInfo = new infoObject("CenterUpper");
        centerUpper.setText(centerUpperInfo.getText());

        var centerLower = View.findDrawableById("CenterLower") as Text;
        var centerLowerInfo = new infoObject("CenterLower");
        centerLower.setText(centerLowerInfo.getText());


        /*
        var info1 = View.findDrawableById("Info1") as Text;
        info1.setText("info 1");

        var info2 = View.findDrawableById("Info2") as Text;
        info2.setText("info 2");

        var info3 = View.findDrawableById("Info3") as Text;
        info3.setText("info 3");

        var info4 = View.findDrawableById("Info4") as Text;
        info4.setText("info 4"); */

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

}
