//
//  AddItemViewController.h
//  EasyLearn
//
//  Created by adeiji on 4/18/15.
//  Copyright (c) 2015 adeiji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DEConstants.h"

@interface AddItemViewController : UIViewController

@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *numberButtons;
@property (weak, nonatomic) IBOutlet UITextField *txtLine1;
@property (weak, nonatomic) IBOutlet UITextField *txtLine2;
@property (strong, nonatomic) NSMutableArray *timesOfDay;

- (IBAction)numberButtonPressed:(id)sender;

@end
