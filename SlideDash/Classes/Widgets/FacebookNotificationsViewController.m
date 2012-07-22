//
//  FacebookNotificationsViewController.m
//  SlideDash
//
//  Created by Mathias Hansen on 22/07/12.
//  Copyright (c) 2012 teamslide. All rights reserved.
//

#import <FBiOSSDK/FacebookSDK.h>

#import "FacebookNotificationsViewController.h"
#import "AppDelegate.h"

@interface FacebookNotificationsViewController ()
@property (strong, nonatomic) FBSession *fbMasterSession;
@end


@implementation FacebookNotificationsViewController
@synthesize labelFriends;
@synthesize labelMessages;
@synthesize labelNotifications;
@synthesize notificationsView;
@synthesize facebookButton;
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
    
    if (_fbMasterSession && _fbMasterSession.state == FBSessionStateCreatedTokenLoaded) {
        // User is logged in
        [facebookButton setHidden:YES];
        [notificationsView setHidden:NO];
        
        [self updateNotifications];
    } else {
        // User is not logged in
        [facebookButton setHidden:NO];
        [notificationsView setHidden:YES];
    }
    
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(notificationsViewTapped:)];
    [notificationsView addGestureRecognizer:gestureRecognizer];
}

- (void)notificationsViewTapped:(id)sender
{
    NSURL *facebookAppUrl = [NSURL URLWithString:@"fb://feed"];
    [[UIApplication sharedApplication] openURL:facebookAppUrl];
}

- (void)viewDidUnload
{
    [self setLabelFriends:nil];
    [self setLabelMessages:nil];
    [self setLabelNotifications:nil];
    [self setNotificationsView:nil];
    [self setFacebookButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)facebookButtonClicked:(id)sender
{
    NSArray *arrayOfPermissions = [NSArray arrayWithObjects:@"user_events", @"read_requests", @"manage_notifications", @"read_mailbox", nil];
    
    if (!_fbMasterSession || _fbMasterSession.isOpen == NO) {
        _fbMasterSession = [FBSession sessionOpenWithPermissions:arrayOfPermissions
           completionHandler:^(FBSession *session,
                               FBSessionState status,
                               NSError *error) {               
               if (session.isOpen) {
                   [self updateNotifications];
                   
                   // Hide login buton
                   [facebookButton setHidden:YES];
                   [notificationsView setHidden:NO];
               }
               
           }];
    }
}

- (void)updateNotifications
{
    // Friend requests
    FBRequest *fql = [FBRequest requestForGraphPath:@"fql"];
    [fql.parameters setObject:@"SELECT uid_from, time, message FROM friend_request WHERE uid_to = me()"
                       forKey:@"q"];
    
    [fql startWithCompletionHandler:^(FBRequestConnection *connection,
                                      id result,
                                      NSError *error) {
        if (result) {
            NSLog(@"Friend requests: %@", result);
            
            int count = [[result objectForKey:@"data"] count];
            if (count > 0)
            {
                labelFriends.text = [NSString stringWithFormat:@"%d", count];
                [labelFriends setHidden:NO];
            }
            else
            {
                [labelFriends setHidden:YES];
            }
        }
    }];
    
    // Messages
    fql = [FBRequest requestForGraphPath:@"fql"];
    [fql.parameters setObject:@"SELECT thread_id, subject, recipients FROM thread WHERE folder_id = 0 and unread != 0"
                       forKey:@"q"];
    
    [fql startWithCompletionHandler:^(FBRequestConnection *connection,
                                      id result,
                                      NSError *error) {
        if (result) {
            NSLog(@"Messages: %@", result);
            
            int count = [[result objectForKey:@"data"] count];
            if (count > 0)
            {
                labelMessages.text = [NSString stringWithFormat:@"%d", count];
                [labelMessages setHidden:NO];
            }
            else
            {
                [labelMessages setHidden:YES];
            }
        }
    }];
    
    // Notifications
    fql = [FBRequest requestForGraphPath:@"fql"];
    [fql.parameters setObject:@"SELECT notification_id, sender_id, title_html, body_html, href FROM notification WHERE recipient_id=me() AND is_unread = 1 AND is_hidden = 0"
                       forKey:@"q"];
    
    [fql startWithCompletionHandler:^(FBRequestConnection *connection,
                                      id result,
                                      NSError *error) {
        if (result) {
            NSLog(@"Notifications: %@", result);
            
            int count = [[result objectForKey:@"data"] count];
            if (count > 0)
            {
                labelNotifications.text = [NSString stringWithFormat:@"%d", count];
                [labelNotifications setHidden:NO];
            }
            else
            {
                [labelNotifications setHidden:YES];
            }
        }
    }];
}


@end
