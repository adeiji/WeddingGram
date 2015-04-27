//
//  InspectionPoint.h
//  Inspection Form App
//
//  Created by adeiji on 4/9/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class InspectionCrane, InspectionOption, Prompt;

@interface InspectionPoint : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * objectId;
@property (nonatomic, retain) InspectionCrane *inspectionCrane;
@property (nonatomic, retain) NSSet *inspectionOptions;
@property (nonatomic, retain) NSSet *prompts;
@end

@interface InspectionPoint (CoreDataGeneratedAccessors)

- (void)addInspectionOptionsObject:(InspectionOption *)value;
- (void)removeInspectionOptionsObject:(InspectionOption *)value;
- (void)addInspectionOptions:(NSSet *)values;
- (void)removeInspectionOptions:(NSSet *)values;

- (void)addPromptsObject:(Prompt *)value;
- (void)removePromptsObject:(Prompt *)value;
- (void)addPrompts:(NSSet *)values;
- (void)removePrompts:(NSSet *)values;

@end
