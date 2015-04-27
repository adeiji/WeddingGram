//
//  InspectionOption.h
//  Inspection Form App
//
//  Created by adeiji on 4/3/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class InspectionPoint;

@interface InspectionOption : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * objectId;
@property (nonatomic, retain) InspectionPoint *inspectionPoint;

@end
