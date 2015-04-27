//
//  Condition.h
//  Inspection Form App
//
//  Created by adeiji on 4/13/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class InspectedCrane;

@interface Condition : NSManagedObject

@property (nonatomic, retain) NSNumber * isDeficient;
@property (nonatomic, retain) NSNumber * isApplicable;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSNumber * optionSelectedIndex;
@property (nonatomic, retain) NSManagedObject *defectivePart;
@property (nonatomic, retain) InspectedCrane *inspectedCrane;

@end
