//
//  MainMenuViewController.m
//  90DayFitness
//
//  Created by adeiji on 4/18/14.
//  Copyright (c) 2014 Stylographix. All rights reserved.
//

#import "MainMenuViewController.h"
#import <Masonry/Masonry.h>

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

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
    UISwipeGestureRecognizer *bottomSwipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftDetected:)];
    UISwipeGestureRecognizer *bottomSwipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRightDetected:)];
    
    bottomSwipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:bottomSwipeLeft];
    
    bottomSwipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:bottomSwipeRight];
    
    [self configureBlurView];
}

- (void) configureBlurView {
    //Configure blur view
    self.blurView.dynamic = YES;
    self.blurView.contentMode = UIViewContentModeBottom;
    self.blurView.tintColor = [UIColor blackColor];
    self.blurView.blurRadius = 80.0;
    
    //Bring the blur view all the way to the right
    [self.blurView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view.mas_top);
//        make.left.equalTo(self.view.mas_left);
//        make.bottom.equalTo(self.view.mas_bottom);
//        make.right.equalTo(self.view.mas_right);
        
    }];
    
    [self.bottomSwipeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@47);
    }];
}


//When the user swipes the bottom of the screen where it says swipe here, then we make the visual change to the screen.
- (void) swipeRightDetected : (UISwipeGestureRecognizer *) gestureRecognizer {
    
    
    [UIView animateWithDuration:.2 animations:^{
        self.blurView.frame = CGRectMake(320, 0, 320, 568);
    }];
}

//When the user swipes the bottom of the screen where it says swipe here, then we make the visual change to the screen.
- (void) swipeLeftDetected : (UISwipeGestureRecognizer *) gestureRecognizer {
    [UIView animateWithDuration:.2 animations:^{
        self.blurView.frame = CGRectMake(0, 0, 320, 568);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [super dealloc];
}
@end
