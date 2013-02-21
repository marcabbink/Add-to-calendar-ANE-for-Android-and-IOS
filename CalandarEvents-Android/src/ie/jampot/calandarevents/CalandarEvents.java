package ie.jampot.calandarevents;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import android.app.PendingIntent;
import android.content.Intent;
import android.sax.StartElementListener;
import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

public class CalandarEvents implements FREFunction {

	@Override
	public FREObject call(FREContext context, FREObject[] args) {

		FREObject returnDeviceStats = null;

		Log.e("ANECalandarEvents", " called addEventToCalandar()");
		try {

			// _calendar.addEventToCalandar(pTitle, pNotes, pDateStart,
			// pDateEnd, 'yyyy-MM-dd hh:mm:ss');

			String pTitle = "";
			String pNotes = null;
			String pDateStart = null;
			String pDateEnd = null; // 'yyyy-MM-dd hh:mm:ss'

			// Here we get the function parameters

			for (int i = 0; i < args.length; i++) {
				switch (i) {
				case 0:
					pTitle = args[i].getAsString();
					break;
				case 1:
					pNotes = args[i].getAsString();
					break;
				case 2:
					pDateStart = args[i].getAsString();
					break;
				case 3:
					pDateEnd = args[i].getAsString();
					break;
				default:
					break;
				}
			}

			// Parse the time form a string to a long

			long startDate = 0l;
			long endDate = 0l;

			SimpleDateFormat dateFormater = new SimpleDateFormat(
					"yyyy-MM-dd hh:mm:ss");

			startDate = dateFormater.parse(pDateStart).getTime();

			if (pDateEnd != null) {
				endDate = dateFormater.parse(pDateEnd).getTime();

			}

			// The intent is created to request the calendar app to add a new
			// event in the calendar
			Intent intent = new Intent(Intent.ACTION_EDIT);
			intent.setType("vnd.android.cursor.item/event");
			intent.putExtra("beginTime", startDate);
			if (pDateEnd == null) {
				intent.putExtra("allDay", true);
			} else {
				intent.putExtra("endTime", endDate);
			}
			// It is possible to personalize the frequency of the event, for
			// instance:
			// intent.putExtra("rrule", "FREQ=YEARLY");
			intent.putExtra("title", pTitle);
			if (pNotes != null) {
				intent.putExtra("description", pNotes);
			}

			// We need the activity instance to start the intent
			context.getActivity().startActivity(intent);
		}

		catch (Exception e) {
			Log.e("Error with ANECalandarEvents addEventToCalandar() method : ",
					e.getMessage());

		}

		return returnDeviceStats;

	}
}