package ie.jampot.calandarevents;

import java.util.HashMap;
import java.util.Map;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;

public class ANECalandarEventsExtensionContext extends FREContext {

	@Override
	public void dispose()
	{
		Log.e("ANECalandarEvents", "CalandarEventsExtensionContextDispose");
	}

	@Override
	public Map<String, FREFunction> getFunctions() {
		
		Log.e("ANECalandarEvents", "Map function called");
		
		Map<String, FREFunction> functionMap=new HashMap<String, FREFunction>();
		
		functionMap.put("addEventToCalandar", new CalandarEvents());
		
		return functionMap;
	}

}
