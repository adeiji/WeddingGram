//
//  ViewMessagesViewController.h
//  WeddingGram
//
//  Created by adeiji on 4/27/15.
//  Copyright (c) 2015 adeiji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParseSync.h"
#import <AVFoundation/AVFoundation.h>
#import "VideoTableViewCell.h"

@interface ViewMessagesViewController : UITableViewController

@property (strong, nonatomic) NSArray *messages;
@property (strong, nonatomic) NSMutableArray *players;

@end
