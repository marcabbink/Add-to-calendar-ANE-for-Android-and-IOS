//
//  capiextension.m
//  iosextension
//
//  CalandarEvents
//  David Douglas david.douglas@jampot.ie
//  http://www.jampot.ie/ane
//  Copyright 2011 JamPot Technologies Ltd. All rights reserved.
//

#import "FlashRuntimeExtensions.h"
#import <EventKit/EventKit.h> 

//Native
void saveEventToCalandar(NSString *eventTitle, NSString *eventNotes, NSString *eventStart, NSString *eventEnd, NSString *dateFormat)
{
	NSLog(@"Save Event \
		  Title: %@ \
		  Notes: %@ \
		  Date Start: %@ \
		  Date End: %@ \
		  Date Format: %@ \
		  ", eventTitle, eventNotes, eventStart, eventEnd, dateFormat );
	
	//Date from String
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setDateFormat:dateFormat]; //@"yyyy-MM-dd hh:mm:ss"
	
	NSDate *dateStart = [df dateFromString: eventStart];
	NSDate *dateEnd = [df dateFromString: eventEnd];
	[df release];
	
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
    
    event.title     = eventTitle;
    event.notes     = eventNotes;
	event.startDate = dateStart;
	event.endDate = dateEnd;
	
    //event.allDay = YES;
	
	[event setCalendar:[eventStore defaultCalendarForNewEvents]];
    
    NSError *err = NULL;
    [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
	
	//clean up
	[eventStore release];
}

// Functions to be invoked from AS code
FREObject addEventToCalandar(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
	NSLog(@"*******************ANE function********************");
    
    NSString *eventTitle = @"";
	NSString *eventNotes = @"";
	NSString *dateStart = @"";
	NSString *dateEnd = @"";
	NSString *dateFormat = @"yyyy-MM-dd";
	BOOL isValid = YES;
    //BOOL success = NO;
    
    // parse arguments
    uint32_t len = 0;
    const uint8_t* str = nil;
    
	//manadatory params
    if(FREGetObjectAsUTF8(argv[0], &len, &str) == FRE_OK){
		eventTitle = [NSString stringWithUTF8String:(const char*)str];
        NSLog(@"Event Title: %@", eventTitle );
	}
	else {
		isValid = NO;
	}
	if(FREGetObjectAsUTF8(argv[1], &len, &str) == FRE_OK){
		eventNotes = [NSString stringWithUTF8String:(const char*)str];
        NSLog(@"Event Notes: %@", eventNotes );
	}
	else {
		isValid = NO;
	}
	if(FREGetObjectAsUTF8(argv[2], &len, &str) == FRE_OK){
		dateStart = [NSString stringWithUTF8String:(const char*)str];
        NSLog(@"Event Date Start: %@", dateStart );
	}
	else {
		isValid = NO;
	}
	//optional params
	if(FREGetObjectAsUTF8(argv[3], &len, &str) == FRE_OK){
		dateEnd = [NSString stringWithUTF8String:(const char*)str];
        NSLog(@"Event Date End: %@", dateEnd );
	}
	else {
		dateEnd = dateStart;
		//isValid = NO;
	}
	if(FREGetObjectAsUTF8(argv[4], &len, &str) == FRE_OK){
		dateFormat = [NSString stringWithUTF8String:(const char*)str];
	}
	else {
		//isValid = NO;
	}

	
	// script here
	if (isValid) 
	{
		saveEventToCalandar(eventTitle, eventNotes, dateStart, dateEnd, dateFormat);
	}
	else 
	{
		NSLog(@"Event Error. Invalid arguements");
	}
	
	//NSLog(@"saveImageToCameraRoll: %@ success: %@\n", imageName, (success ? @"YES" : @"NO") );
    
    // return success
    //FREObject retVal;
    //FRENewObjectFromBool(success, &retVal);
    
	return NULL;
}

// A native context instance is created
void ContextInitializerCalandarEvents(void* extData, const uint8_t* ctxType, FREContext ctx, 
						uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet)
{
	NSLog(@"*******************In context Initializer********************");
	*numFunctionsToTest = 1;
	FRENamedFunction* func = (FRENamedFunction*)malloc(sizeof(FRENamedFunction)*1);
    
	func[0].name = (const uint8_t*)"addEventToCalandar";
	func[0].functionData = NULL;
	func[0].function = &addEventToCalandar;

	*functionsToSet = func;
}

// A native context instance is disposed
void ContextFinalizerCalandarEvents(FREContext ctx)
{
	NSLog(@"*******************In context finalizer********************");
	return;
}

// Initialization function of each extension
void ExtInitializerCalandarEvents(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, 
					FREContextFinalizer* ctxFinalizerToSet)
{
	NSLog(@"*******************In extension initializer********************");
	*extDataToSet = NULL;
	*ctxInitializerToSet = &ContextInitializerCalandarEvents;
	*ctxFinalizerToSet = &ContextFinalizerCalandarEvents;
}

// Called when extension is unloaded
void ExtFinalizerCalandarEvents(void* extData)
{
	NSLog(@"*******************In extension finalizer********************");
	return;
}

