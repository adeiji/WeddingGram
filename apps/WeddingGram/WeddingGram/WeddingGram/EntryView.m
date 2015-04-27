//
//  EntryView.m
//  WeddingGram
//
//  Created by adeiji on 4/27/15.
//  Copyright (c) 2015 adeiji. All rights reserved.
//

#import "EntryView.h"

@implementation EntryView

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [[_btnJoinEvent layer] setCornerRadius:5.0f];
    }
    
    return self;
}

@end
