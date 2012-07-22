//
//  FacebookViewController.m
//  SlideDash
//
//  Created by Fang Chen on 7/21/12.
//  Copyright (c) 2012 teamslide. All rights reserved.
//

/**
 events hash
 
 what are the properties of our events datasource
 
 event title
 event start date
 event location
 event type
  
 assign event type (facebook, google calendar, ical, meetup)
 */

#import "FacebookViewController.h"
#import "AppDelegate.h"

@interface FacebookViewController ()
@property (strong, nonatomic) FBSession *fbMasterSession;
@end

@implementation FacebookViewController
@synthesize facebook;
@synthesize fbMasterSession = _fbMasterSession;
@synthesize arrayOfEventsFromCalendars = _arrayOfEventsFromCalendars;
@synthesize arrayOfEvents = _arrayOfEvents;

- (id)init {
    self = [super init];
    if (self) {
        if (!_arrayOfEvents) {
            _arrayOfEvents = [[NSMutableArray alloc] init];
        }
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    if (!_arrayOfEventsFromCalendars) {
        _arrayOfEventsFromCalendars = [self getEventsFromCalendar];
        for (NSDictionary *event in _arrayOfEventsFromCalendars) {
            [self.arrayOfEvents addObject:event];
        }
    }
}
- (void)viewDidUnload {
    [self setFacebook:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

/**
 facebook
 */
- (IBAction)facebookPressed:(id)sender {
    
    NSArray *arrayOfPermissions = [NSArray arrayWithObject:@"user_events"];
    
    if (!_fbMasterSession || _fbMasterSession.isOpen == NO) {
        _fbMasterSession = [FBSession sessionOpenWithPermissions:arrayOfPermissions
                                               completionHandler:^(FBSession *session, 
                                                                   FBSessionState status, 
                                                                   NSError *error) {
                                                   // session might now be open.  
                                                   
                                                   if (session.isOpen) {
                                                       FBRequest *me = [FBRequest requestForMe];
                                                       [me startWithCompletionHandler: ^(FBRequestConnection *connection, 
                                                                                         NSDictionary<FBGraphUser> *my,
                                                                                         NSError *error) {
                                                       }];
                                                       [self performSelector:@selector(getEventsFromFacebook)];
                                                   }
                                                   
                                               }];
    }    
    
}
- (void)getEventsFromFacebookAndAddtoMainDataSource {
    
    NSLog(@"get events");
    FBRequest *eventRequest = [FBRequest requestForGraphPath:@"me/events"];
    FBRequestConnection *eventConnection = [[FBRequestConnection alloc] initWithTimeout:100];
    
    [eventConnection addRequest:eventRequest completionHandler:
     ^(FBRequestConnection *eventConnection, id result, NSError *error) {
        if (error) {
            NSLog(@"error = %@",error);
        } else {
            
            NSLog(@"result = %@",result);
            NSLog(@"connection = %@", eventConnection);
            
            /**
             figure out how to deal with a GraphObject
             OH just figured it out
             cast a pointer, because it is being returned (and we are logging it as a GraphObject)
             */
 
            /**
             casting and parsing the FBGraphObject
             */
            
            FBGraphObject *eventObject = (FBGraphObject *)result;
            NSArray *arrayOfFacebookEvents = [eventObject objectForKey:@"data"];
            NSMutableDictionary *parsedEvent = [[NSMutableDictionary alloc] init];
            for (NSDictionary *actualEvent in arrayOfFacebookEvents) {
                // set eventName
                if ([actualEvent objectForKey:@"name"]) {
                    [parsedEvent setObject:[actualEvent objectForKey:@"name"] forKey:@"eventName"];
                }
                // set eventLocation
                if ([actualEvent objectForKey:@"location"]) {
                    [parsedEvent setObject:[actualEvent objectForKey:@"location"] forKey:@"eventLocation"];
                } else if ([actualEvent objectForKey:@"venue"]) {
                    [parsedEvent setObject:[actualEvent objectForKey:@"venue"] forKey:@"eventVenue"];
                }
                // set eventTime
                if ([actualEvent objectForKey:@"start_time"]) {
                    [parsedEvent setObject:[actualEvent objectForKey:@"start_time"] forKey:@"eventTime"];
                }
                // set eventType
                [parsedEvent setObject:@"fb" forKey:@"eventType"];
         
            }
            
            NSDictionary *theActualUpcomingEvent = [arrayOfFacebookEvents objectAtIndex:0];
            NSLog(@"theActualUpcomingEvent = %@",theActualUpcomingEvent);
        }
    }];
    
    [eventConnection start];

}

/**
 event kit
 */
- (NSArray *)getEventsFromCalendar {
    
    // define today in the form of an object
    NSDate *rightNow = [NSDate date];
    
    // define the end point; how, into the near future do we want to monitor (24 hours = 60 * 60 * 24 seconds)
    NSDate *aWeekFromNow = [NSDate dateWithTimeIntervalSinceNow:(60*60*24*7)];
    
    // dictionary to remove duplicates
    NSMutableDictionary *eventsDict = [NSMutableDictionary dictionaryWithCapacity:1024];
    
    // get our event store
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    
    NSPredicate *predicate = [eventStore predicateForEventsWithStartDate:rightNow endDate:aWeekFromNow calendars:nil];
    
    // enumerate over event store with our predicate
    [eventStore enumerateEventsMatchingPredicate:predicate
                                      usingBlock:^(EKEvent *event, BOOL *stop) {
                                          
                                          if (event) {
                                              // set eventTitle
                                              if (event.title) {
                                                  [eventsDict setObject:event.title forKey:@"eventTitle"];
                                              }
                                              // set eventLocation
                                              if (event.location) {
                                                  [eventsDict setObject:event.location forKey:@"eventLocation"];
                                              }
                                              // set eventTime
                                              if (event.startDate) {
                                                  [eventsDict setObject:event.startDate forKey:@"eventStartDate"];
                                              }
                                              // set eventType
                                              [eventsDict setObject:@"ical" forKey:@"eventType"];
                                        
                                          }
                                          
                                      }];   
        
    NSArray *anArrayOfEventsFromEventStore = [eventsDict allKeys];
        
    return anArrayOfEventsFromEventStore;
}

/**
 get events
 */






@end