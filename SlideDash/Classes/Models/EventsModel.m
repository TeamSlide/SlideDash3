//
//  EventsModel.m
//  SlideDash
//
//  Created by Fang Chen on 7/22/12.
//  Copyright (c) 2012 teamslide. All rights reserved.
//

#import "EventsModel.h"
#import "AppDelegate.h"
#import <EventKit/EventKit.h>
#import "ISO8601DateFormatter.h"


@interface EventsModel()
@property (strong, nonatomic) NSMutableArray *arrayOfSortedEvents;
@end

@implementation EventsModel
@synthesize arrayOfSortedEvents = _arrayOfSortedEvents;

- (id)init {
    NSLog(@"in init events model");
    self = [super init];
    if (self) {
        if (!_arrayOfSortedEvents) {
            _arrayOfSortedEvents = [[NSMutableArray alloc] init];
        }
    }
    return self;
}
- (NSDictionary *)getNextEvent {
    [self sortStack];
    NSDictionary *nextEvent = [self popEventFromStack];
    return nextEvent;
}
- (NSDictionary *)popEventFromStack {
    NSDictionary *poppedEvent = nil;
    if ([self.arrayOfSortedEvents count] >0) {
        poppedEvent = [self.arrayOfSortedEvents objectAtIndex:0];
        [self.arrayOfSortedEvents removeObjectAtIndex:0];
    }
    return poppedEvent;
}

/**
 get events from calendar
 pushes to stack
 */
- (void)getEventsFromCalendarAndPushToStack {
    
    __block NSMutableArray *stack = [self.arrayOfSortedEvents mutableCopy];
    
    // define today in the form of an object
    NSDate *rightNow = [NSDate date];
    
    // define the end point; how, into the near future do we want to monitor (24 hours = 60 * 60 * 24 seconds)
    NSDate *aWeekFromNow = [NSDate dateWithTimeIntervalSinceNow:(60*60*24*7)];
    
    // get our event store
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    
    NSPredicate *predicate = [eventStore predicateForEventsWithStartDate:rightNow endDate:aWeekFromNow calendars:nil];
    
    // enumerate over event store with our predicate
    [eventStore enumerateEventsMatchingPredicate:predicate
                                      usingBlock:^(EKEvent *event, BOOL *stop) {
                                          
                                          NSMutableDictionary *eventsDict = [[NSMutableDictionary alloc] init];
                                          
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
                                                  [eventsDict setObject:event.startDate forKey:@"eventTime"];
                                              }
                                              // set eventType
                                              [eventsDict setObject:@"ical" forKey:@"eventType"];                                              
                                          }
                                          
                                          // push to stack
                                          [stack addObject:eventsDict];
                                          
                                      }]; 
    NSLog(@"stack = %@",stack);
    [self performSelectorOnMainThread:@selector(pushEventsToStack:) withObject:stack waitUntilDone:YES];
}

/**
 add passed events from facebook to stack
 */
- (void)queryAndPushFacebookEventsToStack {
    
    FBRequest *eventRequest = [FBRequest requestForGraphPath:@"me/events"];
    FBRequestConnection *eventConnection = [[FBRequestConnection alloc] initWithTimeout:100];
    
    [eventConnection addRequest:eventRequest completionHandler:
     ^(FBRequestConnection *eventConnection, id result, NSError *error) {
         if (error) {
             NSLog(@"error = %@",error);
         } else {
             NSLog(@"result = %@",result);
//             NSLog(@"connection = %@", eventConnection);
             
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
             [self performSelectorOnMainThread:@selector(parseArrayOfFacebookEvents:) withObject:arrayOfFacebookEvents waitUntilDone:YES];
             [self sortStack];
         }
     }];
    
    [eventConnection start];

    
}
- (void)parseArrayOfFacebookEvents:(NSArray *)arrayOfFacebookEvents {

    NSLog(@"array of facebook events pre parse = %@",arrayOfFacebookEvents);
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
        
    for (NSMutableDictionary *actualEvent in arrayOfFacebookEvents) {

        NSMutableDictionary *parsedEvent = [[NSMutableDictionary alloc] init];
        
        NSLog(@"actual event = %@", actualEvent);
        // set eventName
        if ([actualEvent objectForKey:@"name"]) {
            [parsedEvent setObject:[actualEvent objectForKey:@"name"] forKey:@"eventName"];
        }
        // set eventLocation (title)
        if ([actualEvent objectForKey:@"location"]) {
            [parsedEvent setObject:[actualEvent objectForKey:@"location"] forKey:@"eventLocationTitle"];
        }    
        // set eventLocation
        if ([actualEvent objectForKey:@"venue"]) {
            [parsedEvent setObject:[actualEvent objectForKey:@"venue"] forKey:@"eventLocation"];
        }
        // set eventTime
        if ([actualEvent objectForKey:@"start_time"]) {
            NSLog(@"unformatted time = %@",[actualEvent objectForKey:@"start_time"]);
            
            ISO8601DateFormatter *formatter = [[ISO8601DateFormatter alloc] init];
            [NSTimeZone setDefaultTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:+0]];
            [formatter setFormat:ISO8601DateFormatCalendar];
            [formatter setIncludeTime:NO];
            //                     [formatter setParsesStrictly:YES];
            NSDate *properDate = [formatter dateFromString:[actualEvent objectForKey:@"start_time"]];
            [parsedEvent setObject:properDate forKey:@"eventTime"];
        }
        
        // set eventType
        [parsedEvent setObject:@"fb" forKey:@"eventType"];
        
        [array addObject:parsedEvent];
    }
    NSLog(@"parsed array = %@", array);

    
    
}
- (void)pushEventsToStack:(NSArray *)events {
    for (NSDictionary *event in events) {
        [self.arrayOfSortedEvents addObject:event];
    }
    NSLog(@"self.arrayOfSortedEvents = %@",self.arrayOfSortedEvents);
}
- (void)sortStack {
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"eventTime" ascending:YES];
    NSArray *sorter = [NSArray arrayWithObject:sortDescriptor];
    [self.arrayOfSortedEvents sortUsingDescriptors:sorter];
    NSLog(@"sortedStack = %@", self.arrayOfSortedEvents);
}

@end
