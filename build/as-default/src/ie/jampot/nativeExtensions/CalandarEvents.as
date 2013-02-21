package ie.jampot.nativeExtensions
{
	public class CalandarEvents
	{
		
		public function CalandarEvents()
		{
			trace("- CameraRoll Stub - not supported in Simulator");
		}

		public function addEventToCalandar( eventTitle:String, eventNotes:String, dateStart:String, dateEnd:String, dateFormat:String="yyyy-MM-dd"  ) : void
		{
			trace("- CalandarEvents addEventToCalandar("+eventTitle+") not supported in Simulator");
		}
	}
}