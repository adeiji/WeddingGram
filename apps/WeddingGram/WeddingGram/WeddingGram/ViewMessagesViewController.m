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
    [self sortArray];
    
    [self.navigationController setNavigationBarHidden:NO];
    
}

- (void) sortArray {
    _messages = [_messages sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        PFObject *object1 = obj1;
        PFObject *object2 = obj2;
        
        return [[object1 createdAt] compare:[object2 createdAt]];
    }];
}

- (void) reloadData {
    _messages = [[[ParseSync sharedManager] messages] copy];
    [self sortArray];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:@"com.weddinggram.reload.events" object:nil];
}

- (void) viewDidDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    __block CGRect frame = [cell frame];
    frame.size.height = height;
    frame.size.width = width;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    PFObject *message = [_messages objectAtIndex:[_messages count] - (indexPath.row + 1)];
    
    if ([message[MESSAGE_TYPE] isEqualToString:MESSAGE_TYPE_TEXT]) {
        [message[MESSAGE_DATA] getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                NSString *messageString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                frame.size.height = height - 150;
                CGRect labelFrame = frame;
                labelFrame.size.width -= 20;
                labelFrame.origin.x += 10;
                UILabel *label = [[UILabel alloc] initWithFrame:labelFrame];
                [label setBackgroundColor:[UIColor colorWithRed:245.0f/255.0f green:245.0f/255.0f blue:245.0f/255.0f alpha:1.0f]];
                UIFont *font = [UIFont fontWithName:@"Avenir-LightOblique" size:17.0f];
                [label setFont:font];
                label.text = messageString;
                [label setTextAlignment:NSTextAlignmentCenter];
                [label setLineBreakMode:NSLineBreakByWordWrapping];
                label.numberOfLines = 15;
                [cell addSubview:label];
            }
        }];
    }
    else if ([message[MESSAGE_TYPE] isEqualToString:MESSAGE_TYPE_VIDEO]) {
        VideoTableViewCell *videoCell = [VideoTableViewCell new];
        videoCell.selectionStyle = UITableViewCellSelectionStyleNone;
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
                
                ViewLittleVideoIcon *view = [[ViewLittleVideoIcon alloc] initWithFrame:CGRectMake(5, 5, 50, 36)];
                [view setBackgroundColor:[UIColor clearColor]];
                [videoCell addSubview:view];
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
        if (((VideoTableViewCell *) cell).player.rate > 0 && !((VideoTableViewCell *) cell).player.error) {
            [((VideoTableViewCell *) cell).player pause];
        }
        else {
            [((VideoTableViewCell *) cell).player seekToTime:kCMTimeZero];
            [((VideoTableViewCell *) cell).player play];
        }
    }
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFObject *message = [_messages objectAtIndex:[_messages count] - (indexPath.row + 1)];
    
    if ([message[MESSAGE_TYPE] isEqualToString:MESSAGE_TYPE_TEXT]) {
        return [[UIScreen mainScreen] bounds].size.width - 120;
    }
    

    return [[UIScreen mainScreen] bounds].size.width + 15;
}
@end
