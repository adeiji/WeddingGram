//
//  AddItemViewController.m
//  EasyLearn
//
//  Created by adeiji on 4/18/15.
//  Copyright (c) 2015 adeiji. All rights reserved.
//

#import "AddItemViewController.h"
#import "DEConstants.h"

@interface AddItemViewController ()

@end

@implementation AddItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    for (UIButton *button in _numberButtons) {
        [[button layer] setCornerRadius:button.frame.size.width / 2.0f];
    }
    
    [_txtLine1 becomeFirstResponder];
    _timesOfDay = [NSMutableArray new];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)numberButtonPressed:(id)sender {
    UIButton *button = (UIButton *) sender;
    [button removeTarget:self action:@selector(numberButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(numberButtonPressedAgain:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor colorWithRed:66.0f/255.0f green:188.0f/255.0f blue:98.0f/255.0f alpha:1.0f]];
    
    [_timesOfDay addObject:[NSNumber numberWithInt:(int) button.tag]];
}

- (void) numberButtonPressedAgain : (id) sender {
    UIButton *button = (UIButton *) sender;
    [button removeTarget:self action:@selector(numberButtonPressedAgain:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(numberButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor colorWithRed:0.0f/255.0f green:172.0f/255.0f blue:238.0f/255.0f alpha:1.0f]];

    [_timesOfDay removeObject:[NSNumber numberWithInt:(int) button.tag]];
}

- (IBAction)cancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)okPressed:(id)sender {
    // Save the item to the server with all it's respective times
    _context = ((AppDelegate *) [[UIApplication sharedApplication] delegate]).managedObjectContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:CORE_DATA_ENTITY_ITEM inManagedObjectContext:_context];
    NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:_context];
    NSString *data = [NSString stringWithFormat:@"%@\n%@", _txtLine1.text, _txtLine2.text];
    NSMutableString *timesOfDay;
    
    for (NSNumber *timeOfDay in _timesOfDay) {
        [timesOfDay stringByAppendingString:[NSString stringWithFormat:@"%@,", [timeOfDay stringValue]]];
    }
    
    [object setValue:data forKey:CORE_DATA_ITEM_DATA];
    [object setValue:timesOfDay forKey:CORE_DATA_ITEM_TIMESOFDAY];
    
    NSError *error;
    [_context save:&error];
    if (error)
    {
        NSLog(@"CoreData error saving - %@", [error description]);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
