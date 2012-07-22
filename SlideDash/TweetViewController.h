//
//  TweetViewController.h
//  SlideDash
//
//  Created by Mcoe mac on 7/21/12.
//  Copyright (c) 2012 teamslide. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetViewController : UIViewController
{
    NSMutableArray * array;
}

@property (strong, nonatomic) IBOutlet UIScrollView *TweetStrollView;
@property (nonatomic, strong) NSMutableArray *array;

@property (strong, nonatomic) IBOutlet UILabel *TweetTextLabel;

@property (strong, nonatomic) IBOutlet UIImageView *ImageTweet;

@end
