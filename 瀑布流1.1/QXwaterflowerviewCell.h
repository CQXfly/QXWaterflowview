//
//  QXwaterflowerviewCell.h
//  瀑布流1.1
//
//  Created by 崇庆旭 on 15/6/24.
//  Copyright (c) 2015年 崇庆旭. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface QXwaterflowerviewCell : UIView


/**
 *  展示图片
 */
@property (nonatomic,strong) UIImageView *imageView;

/**
 *  标题
 */
@property (nonatomic,strong) UILabel *textLabel;

/**
 *  详情
 */
@property (nonatomic,strong) UILabel *detailTextLabel;


/**
 *  重用标识符
 */
@property (nonatomic, copy) NSString *identifier;



- (instancetype) initWithIdentifier:(NSString *) identifier;

@end
