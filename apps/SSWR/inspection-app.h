//
//  inspection-app.h
//  Inspection Form App
//
//  Created by adeiji on 4/1/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class InspectionPoint;

@interface inspection_app : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * objectId;
@property (nonatomic, retain) NSSet *relationship;
@end

@interface  (CoreDataGeneratedAccessors)

- (void)addRelationshipObject:(InspectionPoint *)value;
- (void)removeRelationshipObject:(InspectionPoint *)value;
- (void)addRelationship:(NSSet *)values;
- (void)removeRelationship:(NSSet *)values;

@end
