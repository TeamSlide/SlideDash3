// Author: Emile Cormier
// http://stackoverflow.com/questions/9057462/how-do-i-add-views-to-an-uiscrollview-and-keep-it-synchronized-with-a-uipagecont

#import <Foundation/Foundation.h>

#define something @"sdfsdf"

@interface PageViewManager : NSObject <UIScrollViewDelegate>
{
    UIScrollView* scrollView_;
    UIPageControl* pageControl_;
    NSArray* pages_;
    BOOL pageControlUsed_;
    NSInteger pageIndex_;
}

@property (readonly) NSInteger pageIndex;

- (id)initWithScrollView:(UIScrollView*)scrollView
             pageControl:(UIPageControl*)pageControl;
- (void)loadPages:(NSArray*)pages;
- (void)loadControllerViews:(NSArray*)pageControllers;
- (void)animateToPage:(NSInteger)newPageIndex;

@end