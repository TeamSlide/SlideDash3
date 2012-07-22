//
//  FacebookViewController.m
//  SlideDash
//
//  Created by Fang Chen on 7/21/12.
//  Copyright (c) 2012 teamslide. All rights reserved.
//

#import "FacebookViewController.h"
#import "AppDelegate.h"

@interface FacebookViewController () <FBLoginViewDelegate>
@property (strong, nonatomic) FBSession *fbMasterSession;
@end

@implementation FacebookViewController
@synthesize facebook;
@synthesize fbMasterSession = _fbMasterSession;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setFacebook:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
                                                       [self performSelector:@selector(getEvents)];
                                                   }
                                                   
                                               }];
    }    
    
}
- (void)getEvents {
    
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
            NSArray *arrayOfEvents = [eventObject objectForKey:@"data"];
            NSDictionary *theActualUpcomingEvent = [arrayOfEvents objectAtIndex:0];
            NSLog(@"theActualUpcomingEvent = %@",theActualUpcomingEvent);
        }
    }];
    
    [eventConnection start];

}
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user {
    NSLog(@"loginView, %@ has fetched user, %@", loginView, user);
}
- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    NSLog(@"loginView, %@", loginView); 
}  
- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    // not necessary for now
}













@end
