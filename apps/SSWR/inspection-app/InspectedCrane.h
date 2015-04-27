//
//  InspectedCrane.h
//  Inspection Form App
//
//  Created by adeiji on 4/13/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Condition, Customer;

@interface InspectedCrane : NSManagedObject

@property (nonatomic, retain) NSString * capacity;
@property (nonatomic, retain) NSString * craneDescription;
@property (nonatomic, retain) NSString * craneSrl;
@property (nonatomic, retain) NSString * equipmentNumber;
@property (nonatomic, retain) NSString * hoistMdl;
@property (nonatomic, retain) NSString * hoistMfg;
@property (nonatomic, retain) NSString * hoistSrl;
@property (nonatomic, retain) NSString * mfg;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) Customer *customer;
@property (nonatomic, retain) NSSet *conditions;
@end

@interface InspectedCrane (CoreDataGeneratedAccessors)

- (void)addConditionsObject:(Condition *)value;
- (void)removeConditionsObject:(Condition *)value;
- (void)addConditions:(NSSet *)values;
- (void)removeConditions:(NSSet *)values;

@end
