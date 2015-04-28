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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    static NSString *CellIdentifier = @"CountryCell";
    CGRect screenSize = [[UIScreen mainScreen] bounds];
    CGFloat width = screenSize.size.width;
    CGFloat height = width;
    
    UITableViewCell *cell = [UITableViewCell new];
    
    CGRect frame = [cell frame];
    frame.size.height = height;
    frame.size.width = width;
    id message = [_messages objectAtIndex:indexPath.row];
    
    if ([message[MESSAGE_TYPE] isEqualToString:MESSAGE_TYPE_TEXT]) {
        [message[MESSAGE_DATA] getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                NSString *messageString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                UILabel *label = [[UILabel alloc] initWithFrame:frame];
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
        [message[MESSAGE_DATA] getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
//                UIImage *image = [UIImage imageWithData:data];
                UIView *imageView = [[UIView alloc] initWithFrame:frame];
                [cell addSubview:imageView];
            }
        }];
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


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[UIScreen mainScreen] bounds].size.width;
}
@end
