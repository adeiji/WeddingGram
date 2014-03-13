//
//  DayView.h
//  90DayFitness
//
//  Created by Fahim Farook on 12/8/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DayView : UIView {
	UILabel *label;
	UIButton *button;
}

@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) UIButton *button;

-(id)initWithIndex:(int)index;

@end
