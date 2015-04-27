//
//  InspectionCrane.h
//  Inspection Form App
//
//  Created by adeiji on 4/1/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class InspectionPoint;

@interface InspectionCrane : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * objectId;
@property (nonatomic, retain) NSSet *inspectionPoints;
@end

@interface InspectionCrane (CoreDataGeneratedAccessors)

- (void)addInspectionPointsObject:(InspectionPoint *)value;
- (void)removeInspectionPointsObject:(InspectionPoint *)value;
- (void)addInspectionPoints:(NSSet *)values;
- (void)removeInspectionPoints:(NSSet *)values;

@end
