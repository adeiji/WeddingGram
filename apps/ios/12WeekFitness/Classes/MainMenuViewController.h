//
//  MainMenuViewController.h
//  90DayFitness
//
//  Created by adeiji on 4/18/14.
//  Copyright (c) 2014 Stylographix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FXBlurView/FXBlurView.h>

@interface MainMenuViewController : UIViewController

#pragma mark - Views
@property (retain, nonatomic) IBOutlet FXBlurView *blurView;

@property (retain, nonatomic) IBOutlet UIView *bottomSwipeView;

#pragma mark - Gestures Recognizer


@end
