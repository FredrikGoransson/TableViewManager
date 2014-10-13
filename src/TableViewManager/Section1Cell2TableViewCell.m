//
//  Section1Cell2TableViewCell.m
//  TableViewManager
//
//  Created by Fredrik Göransson on 10/10/14.
//  Copyright (c) 2014 Forefront Consulting Group AB. All rights reserved.
//

#import "Section1Cell2TableViewCell.h"

@implementation Section1Cell2TableViewCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {

    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)buttonTapped:(UIButton *)sender
{
    // Send the action to the action handler
    [self.actionHandler handleAction:_cmd withSender:sender];
}

- (IBAction)switchSwitched:(id)sender {
    // Send the action to the action handler
    [self.actionHandler handleAction:_cmd withSender:sender];
}

@end
