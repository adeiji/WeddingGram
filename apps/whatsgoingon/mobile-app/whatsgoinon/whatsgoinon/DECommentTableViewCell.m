//
//  DECommentTableViewCell.m
//  whatsgoinon
//
//  Created by adeiji on 9/23/14.
//  Copyright (c) 2014 adeiji. All rights reserved.
//

#import "DECommentTableViewCell.h"

@implementation DECommentTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
