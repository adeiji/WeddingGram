//
//  ParseSync.h
//  WeddingGram
//
//  Created by adeiji on 4/27/15.
//  Copyright (c) 2015 adeiji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "Constants.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ParseSync : NSObject

@property (strong, nonatomic) PFObject *event;
@property (strong, nonatomic) NSMutableArray *messages;
@property (strong, nonatomic) NSMutableArray *loadedObjects;

+ (id)sharedManager;
+ (void) createEvent;
- (void) getAllMessagesForEvent;
- (void) joinEventWithId : (NSString *) objectId
              ErrorLabel : (UILabel *) errorLabel;
- (void) storeToParseData : (id) object
                 VideoUrl : (NSString *) filePath;

@end
