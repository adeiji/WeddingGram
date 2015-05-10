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
    [_txtName becomeFirstResponder];
    [self registerForKeyboardNotifications];
}

- (void) registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
}

- (void) keyboardWillShow : (NSNotification *) aNotification {
    [self.view scrollViewToTopOfKeyboard:self.scrollView Notification:aNotification View:self.view TextFieldOrView:_activeField];
}

- (void) eventJoined {
    EntryViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:ENTRY_VIEW_CONTROLLER];
    [self showViewController:viewController sender:nil];
}

- (void) textFieldDidBeginEditing:(UITextField *)textField  {
    
    _activeField = textField;
}

- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([_activeField isEqual:_txtEventId]) {
        [_lblError setText:@""];
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)joinEventPressed:(id)sender {
    if (![_txtEventId.text isEqualToString:@""])
    {
        NSString *eventId = [_txtEventId.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        [[ParseSync sharedManager] joinEventWithId:eventId ErrorLabel:_lblError];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:[_txtName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] forKey:USER_DEFAULTS_NAME];
    }
}

@end
