//
//  TableViewCellDataSource.h
//  TableViewManager
//
//  Created by Fredrik Göransson on 08/10/14.
//  Copyright (c) 2014 Forefront Consulting Group AB. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TableViewCellDataSource <NSObject>

-(void)setData:(NSObject*)data;

@end
