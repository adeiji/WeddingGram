//
//  ViewController.m
//  WeddingGram
//
//  Created by adeiji on 4/27/15.
//  Copyright (c) 2015 adeiji. All rights reserved.
//

#import "ViewController.h"

static NSString *ENTRY_VIEW_CONTROLLER = @"EntryViewController";

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[_btnJoin layer] setCornerRadius:5.0f];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(eventJoined) name:@"com.weddinggram.event.joined" object:nil];
}

- (void) eventJoined {
    EntryViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:ENTRY_VIEW_CONTROLLER];
    [self showViewController:viewController sender:nil];
}

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
