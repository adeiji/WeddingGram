//
//  ViewController.m
//  WeddingGram
//
//  Created by adeiji on 4/27/15.
//  Copyright (c) 2015 adeiji. All rights reserved.
//

#import "ViewController.h"
#import "UIView+DEScrollOnShowKeyboard.h"

static NSString *ENTRY_VIEW_CONTROLLER = @"EntryViewController";

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[_btnJoin layer] setCornerRadius:5.0f];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(eventJoined) name:@"com.weddinggram.event.joined" object:nil];
    [self.navigationController setNavigationBarHidden:YES];
    [_txtEventId becomeFirstResponder];
}


- (void) eventJoined {
    EntryViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:ENTRY_VIEW_CONTROLLER];
    [self showViewController:viewController sender:nil];
}

//- (void) textFieldDidBeginEditing:(UITextField *)textField  {
//    [self.view scrollViewToTopOfKeyboard:(UIScrollView *) self.view Notification:nil View:self.view TextFieldOrView:textField];
//    
//    _activeField = textField;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)joinEventPressed:(id)sender {
    if (![_txtEventId.text isEqualToString:@""])
    {
        [[ParseSync sharedManager] joinEventWithId:_txtEventId.text];
    }
}

@end
