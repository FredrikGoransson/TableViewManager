//
//  Section0HeaderView.m
//  TableViewManager
//
//  Created by Fredrik Göransson on 09/10/14.
//  Copyright (c) 2014 Forefront Consulting Group AB. All rights reserved.
//

#import "Section0HeaderView.h"
#import "SampleDataEntity.h"

@implementation Section0HeaderView

-(void)setData:(NSObject *)data
{
    if( [data isKindOfClass:[SampleDataSubEntity class]])
    {
        SampleDataSubEntity *dataEntity = (SampleDataSubEntity*)data;
        self.titleLable.text = dataEntity.value;
    }
}

@end
