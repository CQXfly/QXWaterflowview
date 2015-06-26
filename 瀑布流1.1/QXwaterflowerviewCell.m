//
//  QXwaterflowerviewCell.m
//  瀑布流1.1
//
//  Created by 崇庆旭 on 15/6/24.
//  Copyright (c) 2015年 崇庆旭. All rights reserved.
//

#import "QXwaterflowerviewCell.h"

@implementation QXwaterflowerviewCell

- (instancetype) initWithIdentifier:(NSString *) identifier
{
    QXwaterflowerviewCell *cell = [[QXwaterflowerviewCell alloc] init];
    if (self = [super init]) {
        cell.identifier = identifier;
    }
    return cell;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
