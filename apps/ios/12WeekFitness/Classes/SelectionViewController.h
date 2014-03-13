//
//  SelectionViewController.h
//  90DayFitness
//
//  Created by Bruce Green on 8/3/09.
//  Copyright 2009 Stylographix. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kUpperBodyView 1
#define kLowerBodyView 2
#define kCardioView 3
#define kFreeDay 4
#define kCancel 5
#define kCopyDay 6
#define kPasteDay 7

@protocol SelectionViewControllerDelegate;

@interface SelectionViewController : UIViewController {
	id<SelectionViewControllerDelegate> delegate;
	int actionType;
	UIButton *button;
}

@property (nonatomic, assign) id <SelectionViewControllerDelegate> delegate;
@property (nonatomic, retain) UIButton *button;
@property (nonatomic) int actionType;

-(IBAction)upperClicked;
-(IBAction)lowerClicked;
-(IBAction)cardioClicked;
-(IBAction)freeClicked;
-(IBAction)cancelClicked;
-(IBAction)copyDay;
-(IBAction)pasteDay;

-(void)closeView;

@end

@protocol SelectionViewControllerDelegate <NSObject>

-(void)closeSelectionViewController:(SelectionViewController *)controller;

@end