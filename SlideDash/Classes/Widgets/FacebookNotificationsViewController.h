//
//  FacebookNotificationsViewController.h
//  SlideDash
//
//  Created by Mathias Hansen on 22/07/12.
//  Copyright (c) 2012 teamslide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WidgetViewController.h"

@class FBSession;

@interface FacebookNotificationsViewController : WidgetViewController {
    
}

@property (weak, nonatomic) IBOutlet UILabel *labelFriends;
@property (weak, nonatomic) IBOutlet UILabel *labelMessages;
@property (weak, nonatomic) IBOutlet UILabel *labelNotifications;
@property (weak, nonatomic) IBOutlet UIView *notificationsView;
@property (weak, nonatomic) IBOutlet UIButton *facebookButton;
- (IBAction)facebookButtonClicked:(id)sender;

@end
