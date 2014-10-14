//
//  TableViewCellActionSource.h
//  TableViewManager
//
//  Created by Fredrik Göransson on 10/10/14.
//  Copyright (c) 2014 Forefront Consulting Group AB. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol TableViewCellActionHandler <NSObject>

-(void)handleAction:(SEL)selector withSender:(id)sender;

@end

@protocol TableViewSectionActionHandler <NSObject>

-(void)handleAction:(SEL)selector withSender:(id)sender;

@end

@protocol TableViewCellDelegateActions <NSObject>

-(id<TableViewCellActionHandler>)actionHandler;
-(void)setActionHandler:(id)actionHandler;

@end

@protocol TableViewCellActionSource <NSObject>


@end
