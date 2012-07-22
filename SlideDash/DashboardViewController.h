//
//  DashboardViewController.h
//  SlideDash
//
//  Created by Mathias Hansen on 21/07/12.
//  Copyright (c) 2012 teamslide. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DashboardViewController;

@protocol DashboardViewControllerDelegate <NSObject>
@optional
- (void)didClickAddWidget:(UIView*)widgetView;
@end


@interface DashboardViewController : UIViewController
{
    id <DashboardViewControllerDelegate> delegate;
}

@property (weak, nonatomic) IBOutlet UIView *topWidget;
@property (weak, nonatomic) IBOutlet UIView *leftWidget;
@property (weak, nonatomic) IBOutlet UIView *rightWidget;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (strong) id <DashboardViewControllerDelegate> delegate;

- (IBAction)addWidgetClicked:(id)sender;

@end
