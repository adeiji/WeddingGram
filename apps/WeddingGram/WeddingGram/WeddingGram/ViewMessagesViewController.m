//
//  ViewMessagesViewController.m
//  WeddingGram
//
//  Created by adeiji on 4/27/15.
//  Copyright (c) 2015 adeiji. All rights reserved.
//

#import "ViewMessagesViewController.h"

@interface ViewMessagesViewController ()

@end

@implementation ViewMessagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _messages = [[[ParseSync sharedManager] messages] copy];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_messages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenSize = [[UIScreen mainScreen] bounds];
    CGFloat width = screenSize.size.width;
    CGFloat height = width;
    
    UITableViewCell *cell = [UITableViewCell new];
    [cell setBackgroundColor:[UIColor colorWithRed:228.0f/255.0f green:246.0f/255.0f blue:248.0f/255.0f alpha:1.0]];
    CGRect frame = [cell frame];
    frame.size.height = height;
    frame.size.width = width;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    PFObject *message = [_messages objectAtIndex:indexPath.row];
    
    if ([message[MESSAGE_TYPE] isEqualToString:MESSAGE_TYPE_TEXT]) {
        [message[MESSAGE_DATA] getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                NSString *messageString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                CGRect labelFrame = frame;
                labelFrame.size.width -= 20;
                labelFrame.origin.x += 10;
                UILabel *label = [[UILabel alloc] initWithFrame:labelFrame];
                label.text = messageString;
                [label setTextAlignment:NSTextAlignmentCenter];
                [label setFont:[UIFont systemFontOfSize:17.0f weight:1.0f]];
                [label setLineBreakMode:NSLineBreakByWordWrapping];
                label.numberOfLines = 15;
                [cell addSubview:label];
            }
        }];
    }
    else if ([message[MESSAGE_TYPE] isEqualToString:MESSAGE_TYPE_VIDEO]) {
        VideoTableViewCell *videoCell = [VideoTableViewCell new];
        videoCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [videoCell setBackgroundColor:[UIColor colorWithRed:228.0f/255.0f green:246.0f/255.0f blue:248.0f/255.0f alpha:1.0]];
        [message[MESSAGE_DATA] getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *documentsDirectory = [paths objectAtIndex:0];
                NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4", message.objectId]];
                [[NSFileManager defaultManager] createFileAtPath:path contents:data attributes:nil];
                NSURL *movieUrl = [NSURL fileURLWithPath:path];
                AVURLAsset *asset = [AVURLAsset URLAssetWithURL:movieUrl options:nil];
                AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:asset];
                videoCell.player = [AVPlayer playerWithPlayerItem:playerItem];
                // Create an AVPlayerLayer using the player
                AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:videoCell.player];
                [playerLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
                [playerLayer setFrame:frame];
                // Add it to your view's sublayers
                [videoCell.layer addSublayer:playerLayer];
                // You can play/pause using the AVPlayer object
                [videoCell.player play];
                [videoCell.player pause];
            }
        }];
        
        return videoCell;
    }
    else if ([message[MESSAGE_TYPE] isEqualToString:MESSAGE_TYPE_IMAGE]) {
        [message[MESSAGE_DATA] getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                UIImage *image = [UIImage imageWithData:data];
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
                [imageView setContentMode:UIViewContentModeScaleAspectFill];
                [imageView setClipsToBounds:YES];
                [imageView setImage:image];
                [cell addSubview:imageView];
            }
        }];
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[VideoTableViewCell class]]) {
        [((VideoTableViewCell *) cell).player seekToTime:kCMTimeZero];
        [((VideoTableViewCell *) cell).player pause];
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[VideoTableViewCell class]]) {
        [((VideoTableViewCell *) cell).player seekToTime:kCMTimeZero];
        [((VideoTableViewCell *) cell).player play];
    }
    

}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[UIScreen mainScreen] bounds].size.width + 5;
}
@end
