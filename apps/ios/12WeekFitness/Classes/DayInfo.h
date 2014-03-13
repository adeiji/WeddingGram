//
//  DayInfo.h
//  90DayFitness
//
//  Created by Bruce Green on 7/2/09.
//  Copyright 2009 Stylographix. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kDayTypeNone -1
#define kDayTypeUpperBody 1
#define kDayTypeCardio 2
#define kDayTypeFree 3
#define kDayTypeLowerBody 4

@interface DayInfo : NSObject <NSCoding> {
    BOOL completed;
    int dayType;
    NSMutableDictionary *chest;
    NSMutableDictionary *biceps;
    NSMutableDictionary *shoulders;
    NSMutableDictionary *triceps;
    NSMutableDictionary *back;
    NSMutableDictionary *forearms;
    NSMutableDictionary *abs;
    NSMutableDictionary *quadriceps;
    NSMutableDictionary *hamstrings;
    NSMutableDictionary *calves;
    NSMutableDictionary *other;
    NSMutableDictionary *cardio;
}

@property (nonatomic) BOOL completed;
@property (nonatomic) int dayType;
@property (nonatomic, retain) NSMutableDictionary *chest;
@property (nonatomic, retain) NSMutableDictionary *biceps;
@property (nonatomic, retain) NSMutableDictionary *shoulders;
@property (nonatomic, retain) NSMutableDictionary *triceps;
@property (nonatomic, retain) NSMutableDictionary *back;
@property (nonatomic, retain) NSMutableDictionary *forearms;
@property (nonatomic, retain) NSMutableDictionary *abs;
@property (nonatomic, retain) NSMutableDictionary *quadriceps;
@property (nonatomic, retain) NSMutableDictionary *hamstrings;
@property (nonatomic, retain) NSMutableDictionary *calves;
@property (nonatomic, retain) NSMutableDictionary *other;
@property (nonatomic, retain) NSMutableDictionary *cardio;

-(DayInfo *)copy;
-(NSMutableDictionary *)copyDictionary:(NSMutableDictionary *)original;

@end
