//
//  FacebookViewController.m
//  SlideDash
//
//  Created by Fang Chen on 7/21/12.
//  Copyright (c) 2012 teamslide. All rights reserved.
//

#import "FacebookViewController.h"
#import "AppDelegate.h"

@interface FacebookViewController ()

@end

@implementation FacebookViewController
@synthesize facebook;

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

- (IBAction)facebookPressed:(id)sender {
    
    [FBSession sessionOpenWithPermissions:nil 
                        completionHandler:^(FBSession *session, 
                                            FBSessionState status, 
                                            NSError *error) {
                            // session might now be open.  
                            
                            if (session.isOpen) {
                                FBRequest *me = [FBRequest requestForMe];
                                [me startWithCompletionHandler: ^(FBRequestConnection *connection, 
                                                                  NSDictionary<FBGraphUser> *my,
                                                                  NSError *error) {
                                    NSLog(@"facebook.user.name = %@",my.first_name);
                                }];
                            }
                            
                        }];
    
}

@end
