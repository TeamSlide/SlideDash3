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
#import "EventsModel.h"

@interface FacebookViewController ()
@property (strong, nonatomic) FBSession *fbMasterSession;
@property (strong, nonatomic) EventsModel *eventsManager;
@end

@implementation FacebookViewController
@synthesize facebook;
@synthesize fbMasterSession = _fbMasterSession;
@synthesize eventsManager = _eventsManager;

- (id)init {
    self = [super init];
    if (self) {
        if (!_eventsManager) {
            _eventsManager = [[EventsModel alloc] init];
        }
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        if (!_eventsManager) {
            _eventsManager = [[EventsModel alloc] init];
            [_eventsManager getEventsFromCalendarAndPushToStack];
        }
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
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
                                                       [self.eventsManager performSelector:@selector(queryAndPushFacebookEventsToStack)];
                                                   }
                                                   
                                               }];
    }    
    
}

@end