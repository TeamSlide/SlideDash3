//
//  TweetViewController.h
//  SlideDash
//
//  Created by Mcoe mac on 7/21/12.
//  Copyright (c) 2012 teamslide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WidgetViewController.h"

@interface TweetViewController : WidgetViewController
{
    NSMutableArray * array;
    int myint;
}

@property (strong , nonatomic) NSTimer *timer;
@property (strong , nonatomic) NSTimer *timer2;
@property (strong, nonatomic) IBOutlet UIScrollView *TweetStrollView;
@property (nonatomic, strong) NSMutableArray *array;
@property (strong, nonatomic) IBOutlet UILabel *TweetUser;

@property (strong, nonatomic) IBOutlet UILabel *TweetTextLabel;
@property (strong, nonatomic) IBOutlet UIButton *TweetImgButton;

@property (strong, nonatomic) IBOutlet UIImageView *ImageTweet;

@end
