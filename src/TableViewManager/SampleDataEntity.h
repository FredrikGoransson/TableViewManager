//
//  SampleDataEntity.h
//  TableViewManager
//
//  Created by Fredrik Göransson on 09/10/14.
//  Copyright (c) 2014 Forefront Consulting Group AB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SampleDataEntity : NSObject

@property (nonatomic, strong) NSString *heading;
@property (nonatomic, strong) NSString *title;
@property (nonatomic) BOOL showMidSection;

@property (nonatomic, strong) NSMutableArray *subData;

@end

@interface SampleDataSubEntity : NSObject

@property (nonatomic, strong) NSString *value;

- (instancetype)initWithValue:(NSString*)aValue;

@end