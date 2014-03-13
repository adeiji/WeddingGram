//
//  FlipsideViewController.h
//  90DayFitness
//
//  Created by Bruce Green on 6/19/09.
//  Copyright Stylographix 2009. All rights reserved.
//

@protocol FlipsideViewControllerDelegate;


@interface FlipsideViewController : UIViewController <UIAlertViewDelegate> {
	id <FlipsideViewControllerDelegate> delegate;
}

@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;

-(IBAction)done;
-(IBAction)reset;

@end


@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

