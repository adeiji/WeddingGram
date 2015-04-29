//
//  ViewHome.m
//  WeddingGram
//
//  Created by adeiji on 4/28/15.
//  Copyright (c) 2015 adeiji. All rights reserved.
//

#import "ViewHome.h"
#import "StyleKit.h"

@implementation ViewHome


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [StyleKit drawHomeWithFrame:rect];
}


@end
