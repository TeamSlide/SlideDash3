//
//  MainViewController.h
//  SlideDash
//
//  Created by Mathias Hansen on 21/07/12.
//
//

#import <UIKit/UIKit.h>
#import "PageViewManager.h"

@interface MainViewController : UIViewController<UIAlertViewDelegate> {
    PageViewManager *pageViewManager;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIPageControl *pageControl;
    IBOutlet UIView *slideMenu;
    BOOL isAnimatingMenu;
    NSMutableArray *dashboardViews;
}

- (IBAction)addDashboardClicked:(id)sender;
- (IBAction)replaceWidgetsClicked:(id)sender;
- (IBAction)removeDashboardClicked:(id)sender;
- (IBAction)menuButtonClicked:(id)sender;

@end
