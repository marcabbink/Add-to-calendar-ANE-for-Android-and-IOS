INFO:

Allright, so first off all, I didn't write all of this code. I wanted to use this ane: 

http://code.google.com/p/flashbuilder-ane-save-date-as-calendar-events/

which is made by JamPot, but unfortunately it didn't work for Android and it worked half on IOS. So, I contacted the guys from Jampot several times, but they don't respond. And that's why I decided to fix this because I needed the ane for one of my projects.

I had some help building this ane tho, the IOS fix is made by Nico van Zijl from Blueprint and the Android fix is made by Joan Puig from Service 2 Media.

I than welded it all together and builded the ane.

I than decided to share this code with the rest of the world, so that you guys can benefit from it to. So, happy coding!


USAGE:

private var _calendar:CalandarEvents = new CalandarEvents();


public function addCalenderEvent(pTitle:String, pNotes:String, pDateStart:String, pDateEnd:String):void{
	_calendar.addEventToCalandar(pTitle, pNotes, pDateStart, pDateEnd, 'yyyy-MM-dd HH:mm:ss');
}


BUILD SCRIPT:

bin/adt -package -target ane Output.ane /Users/marcabbink/Tools/software/ANE_CalandarEvents\ v2/build/ane/extension.xml  -swc /Users/marcabbink/Tools/software/ANE_CalandarEvents\ v2/build/ane/CalandarEvents-device.swc  -platform iPhone-ARM -C /Users/marcabbink/Tools/software/ANE_CalandarEvents\ v2/build/ane/ios . -platformoptions /Users/marcabbink/Tools/software/ANE_CalandarEvents\ v2/build/ane/platformoptions-ios.xml -platform Android-ARM -C /Users/marcabbink/Tools/software/ANE_CalandarEvents\ v2/build/ane/android . -platform default -C /Users/marcabbink/Tools/software/ANE_CalandarEvents\ v2/build/ane/default  .