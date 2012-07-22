//
//  EventsModel.h
//  SlideDash
//
//  Created by Fang Chen on 7/22/12.
//  Copyright (c) 2012 teamslide. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FBSession;

@protocol EventsModelDelegate <NSObject>
- (void)didGetNextEvent:(NSDictionary *)event;
@end

@interface EventsModel : NSObject

@property (assign) id<EventsModelDelegate>delegate;
- (NSDictionary *)getNextEvent;
- (void)updateStack;
- (void)getEventsFromCalendarAndPushToStack;
- (void)queryAndPushFacebookEventsToStack;

@end
