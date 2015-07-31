//
//  QXwaterflowerviewCell.m
//  瀑布流1.1
//
//  Created by 崇庆旭 on 15/6/24.
//  Copyright (c) 2015年 崇庆旭. All rights reserved.
//

#import "QXwaterflowerviewCell.h"
#import "UIImageView+WebCache.h"
@interface QXwaterflowerviewCell ()



@end

@implementation QXwaterflowerviewCell

- (instancetype) initWithIdentifier:(NSString *) identifier
{
    QXwaterflowerviewCell *cell = [[QXwaterflowerviewCell alloc] init];
    if (self = [super init]) {
        cell.identifier = identifier;
//        [self setUpSubviews];
    }
    return cell;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setUpSubviews];
    }
    return self;
}

- (void)setUpSubviews
{
//    UIImageView *imageView = [[UIImageView alloc] init];
//    self.imageView = imageView;
//    [self addSubview:imageView];
//    self.imageView.backgroundColor = [UIColor yellowColor];
//
//    UILabel *textLabel = [[UILabel alloc] init];
//    self.textLabel = textLabel;
//    [self addSubview:textLabel];
//    textLabel.font = [UIFont systemFontOfSize:15];
//    self.textLabel.text = @"cellTiTle";
//
//    UIButton *detailTextLabel = [[UIButton alloc] init];
////    self.detailTextLabel = detailTextLabel;
//    [detailTextLabel setTitle:@"????" forState:UIControlStateNormal];
//    detailTextLabel.backgroundColor = [UIColor yellowColor];
//    [self addSubview:detailTextLabel];
////    detailTextLabel.font = [UIFont systemFontOfSize:12];
////    self.detailTextLabel.text = @"cellDetailTitle";
    
}

#define kmarginX  5
#define kmarginTop  5
#define kmarginImage 5
#define kmarginImageWidth


- (void)layoutSubviews
{
   
    self.imageView.frame = CGRectMake(kmarginX, kmarginTop, self.frame.size.width - kmarginX *2, self.frame.size.height * 2 / 3);
    
    self.textLabel.frame = CGRectMake(kmarginX, self.frame.size.height * 2 / 3 + kmarginImage , self.frame.size.width,self.frame.size.height / 6 );
    
    self.detailTextLabel.frame = CGRectMake(kmarginX, self.frame.size.height * 5 / 6 + kmarginImage, self.frame.size.width, self.frame.size.height / 6 - kmarginImage);

    
 
    
    
}


@end
