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
        [NSTimer scheduledTimerWithTimeInterval:20 target:self selector:@selector(getAllMessagesForEvent) userInfo:nil repeats:YES];
        _loadedObjects = [NSMutableArray new];
        _messages = [NSMutableArray new];
    }
    
    return self;
}
+ (NSString *) createUDID {
    CFUUIDRef uuidObj = CFUUIDCreate(nil);
    //Use CFBridgingRelease call to transfer ownership of a a + 1 CFStringRef into ARC
    NSString *uuid = (NSString *) CFBridgingRelease(CFUUIDCreateString(nil, uuidObj));
    CFRelease(uuidObj);
    
    return [uuid substringToIndex:7];
}

+ (void) createEvent {
    PFObject *event = [PFObject objectWithClassName:PARSE_CLASS_EVENT];
    event[EVENT_NAME] = @"Ade's Wedding";
    event.objectId = [event.objectId lowercaseString];
    event[EVENT_ID] = [[self createUDID] lowercaseString];
    
    [event saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error)
        {
            NSLog(@"com.WeddingGram.saved.event - Event saved to the server");
        }
    }];
}

- (void) getAllMessagesForEvent {

    PFQuery *query = [PFQuery queryWithClassName:PARSE_CLASS_MESSAGE];
    [query whereKey:MESSAGE_EVENT equalTo:_event];
    [query whereKey:OBJECT_ID notContainedIn:_loadedObjects];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for (PFObject *object in objects) {
            if (![_loadedObjects containsObject:object.objectId]) {
                [_loadedObjects addObject:object.objectId];
                [_messages addObject:object];
            }
        }
        
        NSLog(@"Messages retrieved from server - com.WeddingGram.retrieved.messages");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"com.weddinggram.reload.events" object:nil];
    }];

}

- (void) joinEventWithId : (NSString *) objectId {
    
    PFQuery *query = [PFQuery queryWithClassName:PARSE_CLASS_EVENT];
    [query whereKey:EVENT_ID equalTo:[objectId lowercaseString]];
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
    [[NSNotificationCenter defaultCenter] postNotificationName:@"com.weddinggram.event.joined" object:nil] ;
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
        message[MESSAGE_TYPE] = MESSAGE_TYPE_TEXT;
    }
    else if (filePath) {
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        file = [PFFile fileWithData:data];
        message[MESSAGE_TYPE] = MESSAGE_TYPE_VIDEO;
    }
    else if ([object isKindOfClass:[UIImage class]]) {
        NSData *data = UIImageJPEGRepresentation((UIImage *) object, .01f);
        file = [PFFile fileWithData:data];
        message[MESSAGE_TYPE] = MESSAGE_TYPE_IMAGE;
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
