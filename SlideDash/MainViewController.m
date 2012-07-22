//
//  MainViewController.m
//  SlideDash
//
//  Created by Mathias Hansen on 21/07/12.
//
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

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
    // Do any additional setup after loading the view, typically from a nib.
    
    // Create some views dynamically
    UIView* v1 = [[UIView alloc] initWithFrame: scrollView.frame];
    UIView* v2 = [[UIView alloc] initWithFrame: scrollView.frame];
    
    v1.backgroundColor = [UIColor redColor];
    v2.backgroundColor = [UIColor greenColor];
    
    // Put the views inside an NSArray:
    dashboardViews = [NSMutableArray arrayWithObjects:v1, v2, nil];
    
    /* Create the PageViewManager, which is a member (or property) of this
     UIViewController. The UIScrollView and UIPageControl belong to this
     UIViewController, but we're letting the PageViewManager manage them for us. */
    pageViewManager = [[PageViewManager alloc]
                        initWithScrollView:scrollView
                        pageControl:pageControl];
    
    // Make the PageViewManager display our array of UIViews on the UIScrollView.
    [pageViewManager loadPages:dashboardViews];
    
    // Hide slide menu
    [slideMenu setFrame:CGRectMake(slideMenu.frame.origin.x, -slideMenu.frame.size.height, slideMenu.frame.size.width, slideMenu.frame.size.height)];
    isAnimatingMenu = NO;
}

- (void)viewDidUnload
{
    scrollView = nil;
    pageControl = nil;
    slideMenu = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)addDashboardClicked:(id)sender {
    UIView* newDashboard = [[UIView alloc] initWithFrame: scrollView.frame];
    newDashboard.backgroundColor = [UIColor blueColor];
    
    [dashboardViews addObject:newDashboard];
    [pageViewManager loadPages:dashboardViews];
}

- (IBAction)replaceWidgetsClicked:(id)sender {
}

- (IBAction)removeDashboardClicked:(id)sender {
}

- (IBAction)menuButtonClicked:(id)sender {
    if (isAnimatingMenu)
        return;
    
    [UIView animateWithDuration:0.4f animations:^{
        isAnimatingMenu = YES;
        
        CGFloat newY = 0;
        
        if (slideMenu.frame.origin.y < 0)
        {
            newY = 0;
        }
        else
        {
            newY = -slideMenu.frame.size.height;
        }
        
        [slideMenu setFrame:CGRectMake(slideMenu.frame.origin.x, newY, slideMenu.frame.size.width, slideMenu.frame.size.height)];
    } completion:^(BOOL finished) {
        if (finished)
        {
            isAnimatingMenu = NO;
        }
    }];
}
@end
