//
//  Prompt.h
//  Inspection Form App
//
//  Created by adeiji on 4/10/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class InspectionPoint;

@interface Prompt : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * requiresDeficiency;
@property (nonatomic, retain) NSString * objectId;
@property (nonatomic, retain) InspectionPoint *inspectionPoint;

@end
