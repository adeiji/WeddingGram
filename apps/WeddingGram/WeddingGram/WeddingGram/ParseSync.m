//
//  ParseSync.m
//  WeddingGram
//
//  Created by adeiji on 4/27/15.
//  Copyright (c) 2015 adeiji. All rights reserved.
//

#import "ParseSync.h"
#import "Constants.h"

@implementation ParseSync

+ (id)sharedManager {
    static ParseSync *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(getAllMessagesForEvent) userInfo:nil repeats:YES];
    }
    
    return self;
}

+ (void) createEvent {
    PFObject *event = [PFObject objectWithClassName:PARSE_CLASS_EVENT];
    event[EVENT_NAME] = @"Ade's Wedding";
    
    [event saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error)
        {
            NSLog(@"com.WeddingGram.saved.event - Event saved to the server");
        }
    }];
}

- (void) getAllMessagesForEvent {
    if (_event) {
        PFQuery *query = [PFQuery queryWithClassName:PARSE_CLASS_MESSAGE];
        [query whereKey:MESSAGE_EVENT equalTo:_event];
        [query whereKey:OBJECT_ID notContainedIn:_loadedObjects];
        
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (objects) {
                _messages = objects;
            }
            
            for (PFObject *object in objects) {
                if (![_loadedObjects containsObject:object.objectId]) {
                    [_loadedObjects addObject:object.objectId];
                }
            }
        }];
    }
}

- (void) joinEventWithId : (NSString *) objectId {
    
    PFQuery *query = [PFQuery queryWithClassName:PARSE_CLASS_EVENT];
    [query whereKey:OBJECT_ID equalTo:objectId];
    dispatch_semaphore_t sema_done = dispatch_semaphore_create(0);
    __block PFObject *object;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        object = [query getFirstObject];
        dispatch_semaphore_signal(sema_done);
    });
    
    dispatch_semaphore_wait(sema_done, DISPATCH_TIME_FOREVER);
    
    // Now we have our result we free the resources and return
    _event = object;
    [self getAllMessagesForEvent];
}

- (void) storeToParseData : (id) object
                 VideoUrl : (NSString *) filePath
{
    PFObject *message = [PFObject objectWithClassName:PARSE_CLASS_MESSAGE];
    PFFile *file;
    
    if ([object isKindOfClass:[NSString class]])
    {
        NSData *data = [object dataUsingEncoding:NSUTF8StringEncoding];
        file = [PFFile fileWithData:data];
    }
    else if (filePath) {
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        file = [PFFile fileWithData:data];
    }
    else if ([object isKindOfClass:[UIImage class]]) {
        NSData *data = UIImageJPEGRepresentation((UIImage *) object, .01f);
        file = [PFFile fileWithData:data];
    }
    
    message[MESSAGE_DATA] = file;
    message[MESSAGE_EVENT]= _event;

    [message saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error)
        {
            NSLog(@"com.WeddingGram.saved.message - Message saved to the server");
        }
    }];
}



@end
