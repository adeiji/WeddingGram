//
//  ViewController.h
//  WeddingGram
//
//  Created by adeiji on 4/27/15.
//  Copyright (c) 2015 adeiji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParseSync.h"
#import "EntryViewController.h"

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btnJoin;
@property (weak, nonatomic) IBOutlet UITextField *txtEventId;
@property (strong, nonatomic) UITextField *activeField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

