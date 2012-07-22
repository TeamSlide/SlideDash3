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
                                                  [eventsDict setObject:event.startDate forKey:@"eventStartDate"];
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
             NSMutableDictionary *parsedEvent = [[NSMutableDictionary alloc] init];
             NSMutableArray *array = [[NSMutableArray alloc] init];
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
                 
                 [array addObject:parsedEvent];
             }
             [self performSelectorOnMainThread:@selector(pushEventsToStack:) withObject:array waitUntilDone:YES];
         }
     }];
    
    [eventConnection start];

    
}
- (void)pushEventsToStack:(NSArray *)events {
    for (NSDictionary *event in events) {
        [self.arrayOfSortedEvents addObject:event];
    }
    NSLog(@"self.arrayOfSortedEvents = %@",self.arrayOfSortedEvents);
}

- (void)addEventsToStackFromFacebook:(NSArray *)arrayOfEventsFromFacebook {
    
    NSArray *array = [self.arrayOfSortedEvents arrayByAddingObjectsFromArray:arrayOfEventsFromFacebook];
    
    NSSortDescriptor *eventTimeDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"eventTime" ascending:YES];
    
    NSArray *sortDescriptors = [NSArray arrayWithObject:eventTimeDescriptor];
    NSArray *sortedArray = [array sortedArrayUsingDescriptors:sortDescriptors];

    NSLog(@"sortedArray = %@",sortedArray);
}

@end
