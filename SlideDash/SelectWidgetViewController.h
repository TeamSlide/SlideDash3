//
//  SelectWidgetViewController.h
//  SlideDash
//
//  Created by Mathias Hansen on 22/07/12.
//  Copyright (c) 2012 teamslide. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DashboardViewController;

@protocol SelectViewControllerDelegate <NSObject>
@optional
- (void)didSelectWidget:(NSString*)widgetId forLocation:(int)location;
@end

@interface SelectWidgetViewController : UITableViewController {
    NSArray *widgets;
    id <SelectViewControllerDelegate> delegate;
}

@property (strong) id <SelectViewControllerDelegate> delegate;

@end
