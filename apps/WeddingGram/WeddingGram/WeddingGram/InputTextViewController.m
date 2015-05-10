//
//  InputTextViewController.m
//  WeddingGram
//
//  Created by adeiji on 4/27/15.
//  Copyright (c) 2015 adeiji. All rights reserved.
//

#import "InputTextViewController.h"

@interface InputTextViewController ()

@end

@implementation InputTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_txtMessage becomeFirstResponder];
    [_txtMessage setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)doneButtonPressed:(id)sender {
    [_txtMessage resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [defaults objectForKey:USER_DEFAULTS_NAME];
    if ([[userName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""] || !userName) {
        userName = @"Anonymous";
    }
    NSString *messageString = [NSString stringWithFormat:@"\"%@\",\n\n%@", _txtMessage.text, userName];
    
    [[ParseSync sharedManager] storeToParseData:messageString VideoUrl:nil];
}

- (IBAction)cancelButtonPressed:(id)sender {
    [_txtMessage resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSUInteger newLength = [textView.text length] + [text length] - range.length;
    
    // Get how many characters are available to be entered after the data is pasted
    int targetLength = 300 - (int) newLength;
    
    if (targetLength > -1)
    {
        self.lblMinCharacters.text = [NSString stringWithFormat:@"%lu", 300 - newLength];
    }
    else
    {
        self.lblMinCharacters.text = @"0";
        return NO;
    }
    
    return  YES;
}

@end
