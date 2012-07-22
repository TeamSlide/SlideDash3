//
//  CommuteViewController.h
//  SlideDash
//
//  Created by Mcoe mac on 7/22/12.
//  Copyright (c) 2012 teamslide. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommuteViewController : UIViewController
{

}

@property(nonatomic, strong) IBOutlet UILabel * line_id;
@property (strong, nonatomic) IBOutlet UIImageView *TransPortTypeImg;

@property(nonatomic, strong) IBOutlet UILabel * departure_time;
@property(nonatomic, strong)NSMutableArray* step2;
@property(nonatomic, strong) NSMutableArray* step3;
@end
