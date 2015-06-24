//
//  DetailViewController.h
//  Reminder-iOS
//
//  Created by saqib on 6/21/15.
//  Copyright (c) 2015 saqib. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASFSharedViewTransition.h"

@interface DetailViewController : UIViewController <ASFSharedViewTransitionDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
