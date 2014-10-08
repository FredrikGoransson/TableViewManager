//
//  TableViewCellDefinition.m
//  TableViewManager
//
//  Created by Fredrik Göransson on 08/10/14.
//  Copyright (c) 2014 Forefront Consulting Group AB. All rights reserved.
//

#import "TableViewCellDefinition.h"

@implementation TableViewCellDefinition

@end

@implementation TableViewCellDefinitionWithIdentifier

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.height = -1;
    }
    return self;
}

@end

@implementation TableViewCellDefinitionWithView

@end