//
//  MainViewController.h
//  SlideDash
//
//  Created by Mathias Hansen on 21/07/12.
//
//

#import <UIKit/UIKit.h>
#import "DashboardViewController.h"

@class PageViewManager;

@interface MainViewController : UIViewController<UIAlertViewDelegate, DashboardViewControllerDelegate> {
    PageViewManager *pageViewManager;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIPageControl *pageControl;
    IBOutlet UIView *slideMenu;
    BOOL isAnimatingMenu;
    NSMutableArray *dashboardViewControllers;
    __weak IBOutlet UIView *overlayView;
}

- (IBAction)addDashboardClicked:(id)sender;
- (IBAction)replaceWidgetsClicked:(id)sender;
- (IBAction)removeDashboardClicked:(id)sender;
- (IBAction)menuButtonClicked:(id)sender;

@property (strong) id <DashboardViewControllerDelegate> delegate;

@end
