//
//  SampleDataEntity.m
//  TableViewManager
//
//  Created by Fredrik Göransson on 09/10/14.
//  Copyright (c) 2014 Forefront Consulting Group AB. All rights reserved.
//

#import "SampleDataEntity.h"

@implementation SampleDataEntity

@end

@implementation SampleDataSubEntity

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (instancetype)initWithValue:(NSString*)aValue
{
    self = [super init];
    if (self) {
        self.value = aValue;
    }
    return self;
}

@end