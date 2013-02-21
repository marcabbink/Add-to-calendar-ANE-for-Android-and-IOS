package ie.jampot.nativeExtensions
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.external.ExtensionContext;	
	
	public class CalandarEvents extends EventDispatcher
	{
		private static var extContext:ExtensionContext=null;
		
		public function CalandarEvents()
		{
			trace("+ CalandarEvents Constructor");
			if(!extContext)
			{
				trace("+ Extension Context Created Constructor");
				extContext=ExtensionContext.createExtensionContext("ie.jampot.CalandarEvents","CalandarEvents");
			}
		}

		public function addEventToCalandar( eventTitle:String, eventNotes:String, dateStart:String, dateEnd:String, dateFormat:String="yyyy-MM-dd" ) : void
		{
			if(extContext != null)
			{
				trace("+ CalandarEvents addEventToCalandar("+eventTitle+")");
				extContext.call( "addEventToCalandar", eventTitle, eventNotes, dateStart, dateEnd, dateFormat );
			}
		}
	}
}