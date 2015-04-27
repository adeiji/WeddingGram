//
//  ParseSync.h
//  WeddingGram
//
//  Created by adeiji on 4/27/15.
//  Copyright (c) 2015 adeiji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>


@interface ParseSync : NSObject

@property (strong, nonatomic) PFObject *event;
@property (strong, nonatomic) NSArray *messages;
@property (strong, nonatomic) NSMutableArray *loadedObjects;

+ (id)sharedManager;
+ (void) createEvent;
- (void) getAllMessagesForEvent;
- (void) joinEventWithId : (NSString *) objectId;
- (void) storeToParseData : (id) object
                 VideoUrl : (NSString *) filePath;

@end
