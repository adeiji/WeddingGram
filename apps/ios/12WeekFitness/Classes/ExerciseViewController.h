//
//  ExerciseViewController.h
//  90DayFitness
//
//  Created by Bruce Green on 6/29/09.
//  Copyright 2009 Stylographix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExerciseViewCell.h"
#import "CalendarDay.h"
#import "PresetsViewController.h"

@interface ExerciseViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, UIAlertViewDelegate, PresetsViewControllerDelegate> {
    IBOutlet UINavigationItem *navItem;
	IBOutlet UITableView *tableView;
	IBOutlet UITextView *notes;
	IBOutlet UIImageView *back1;
	IBOutlet UIImageView *back2;
	BOOL editingNotes;
    ExerciseViewCell *exerciseCell;
    int buttonClicked;
    CalendarDay *dayInfo;
}

@property (nonatomic, retain) IBOutlet ExerciseViewCell *exerciseCell;
@property (nonatomic) int buttonClicked;
@property (nonatomic,retain) CalendarDay *dayInfo;

-(IBAction)closeView;
-(IBAction)addRow;
-(IBAction)resetClicked;
-(IBAction)editClicked;

-(NSMutableArray *)setupDictionary:(NSMutableDictionary *)dic;
-(void)showPresets:(NSNotification *)info;
-(void)saveNote;

@end
