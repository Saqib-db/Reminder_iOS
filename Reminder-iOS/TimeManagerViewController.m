//
//  TimeManagerViewController.m
//  Reminder-iOS
//
//  Created by saqib on 6/28/15.
//  Copyright (c) 2015 saqib. All rights reserved.
//

#import "TimeManagerViewController.h"
#import "Example2PieView.h"
#import "MyPieElement.h"
#import "PieLayer.h"


@interface TimeManagerViewController (){
    BOOL showPercent;
}

@end

@implementation TimeManagerViewController
@synthesize pieView,pieView2;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view..
    for(int year = 1; year <= 12; year++){
        MyPieElement* elem = [MyPieElement pieElementWithValue:(5+arc4random()%8) color:[self randomColor]];
        elem.title = [NSString stringWithFormat:@"%d am", year];
        [pieView.layer addValues:@[elem] animated:NO];
    }
    for(int year = 1; year <= 12; year++){
        MyPieElement* elem = [MyPieElement pieElementWithValue:(5+arc4random()%8) color:[self randomColor]];
        elem.title = [NSString stringWithFormat:@"%d pm", year];
        [pieView2.layer addValues:@[elem] animated:NO];
        
    }
    
    //mutch easier do this with array outside
    showPercent = NO;
    pieView.layer.transformTitleBlock = ^(PieElement* elem, float percent){
        return [(MyPieElement*)elem title];
    };
    pieView2.layer.transformTitleBlock = ^(PieElement* elem, float percent){
        return [(MyPieElement*)elem title];
    };
    pieView.layer.showTitles = ShowTitlesAlways;
    pieView2.layer.showTitles = ShowTitlesAlways;

    
    self.calendar = [JTCalendar new];
    
    [self.calendar setMenuMonthsView:self.calendarMenuView];
    [self.calendar setContentView:self.calendarContentView];
    [self.calendar setDataSource:self];
    self.calendar.calendarAppearance.isWeekMode = !self.calendar.calendarAppearance.isWeekMode;
    
    [self.calendar reloadAppearance];
    
    

    
    [self.calendar reloadData];
}
- (UIColor*)randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLayoutSubviews
{
    [self.calendar repositionViews];
}

- (BOOL)calendarHaveEvent:(JTCalendar *)calendar date:(NSDate *)date
{
    return NO;
}

- (void)calendarDidDateSelected:(JTCalendar *)calendar date:(NSDate *)date
{
    NSLog(@"%@", date);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
