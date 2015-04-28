//
//  VideoTableViewCell.h
//  WeddingGram
//
//  Created by adeiji on 4/28/15.
//  Copyright (c) 2015 adeiji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface VideoTableViewCell : UITableViewCell

@property (strong, nonatomic) AVPlayer *player;

@end
