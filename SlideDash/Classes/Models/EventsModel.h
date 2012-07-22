//
//  EventsModel.h
//  SlideDash
//
//  Created by Fang Chen on 7/22/12.
//  Copyright (c) 2012 teamslide. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FBSession;

@interface EventsModel : NSObject

- (NSDictionary *)getNextEvent;
- (void)updateStack;
- (void)getEventsFromCalendarAndPushToStack;
- (void)queryAndPushFacebookEventsToStack;

@end
