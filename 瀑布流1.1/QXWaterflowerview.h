//
//  QXWaterflowerview.h
//  瀑布流1.1
//
//  Created by 崇庆旭 on 15/6/24.
//  Copyright (c) 2015年 崇庆旭. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    QXWaterflowerviewMarginTypeTop,
    QXWaterflowerviewMarginTypeBottom,
    QXWaterflowerviewMarginTypeLeft,
    QXWaterflowerviewMarginTypeRight,
    QXWaterflowerviewMarginTypeRow,
    QXWaterflowerviewMarginTypeColumn,
    
}QXWaterflowerviewMarginType ;


@class QXWaterflowerview,QXwaterflowerviewCell;

/**
 *  数据源方法
 */
@protocol QXWaterflowerviewDataSource <NSObject>

@required

/**
 *  how many cells
 */
- (NSUInteger) numberOfCellsInWaterflowerview:(QXWaterflowerview *) waterflowerview;

/**
 *  cell view at index
 */
- (QXwaterflowerviewCell *) waterflowerview:(QXWaterflowerview *) waterflowerview cellAtIndex:(NSUInteger ) index;


@optional

/**
 *  number of columns
 */
- (NSUInteger)  numberOfColumnsInWaterflowerview:(QXWaterflowerview *) waterflowerview;

/**
 *  headerview
 */
- (UIView *)  headerViewInWatervierflower:(QXWaterflowerview *) waterflowerview;

/**
 *  footerview
 */
- (UIView *) footerviewWaterviewflower:(QXWaterflowerview *) waterflowerview;

@end

/**
 *  代理方法
 */
@protocol QXWaterflowerviewDelegate <UIScrollViewDelegate>

@required

/**
 *  the cell's height in index
 */
- (CGFloat) waterflowerview:(QXWaterflowerview *) waterflowerview heightForRowInIndex:(NSInteger) index;

/**
 *  did select the cell in index
 */
- (void) waterflowerview:(QXWaterflowerview *) waterflowerview didSelectAtInIndex:(NSInteger ) index;

/**
 *  the cell's margin with (row,column,top,bottom,right,left)
 */
- (CGFloat) waterflowerview:(QXWaterflowerview *) waterflowerview maginForType:(QXWaterflowerviewMarginType) type;

@optional


@end

@interface QXWaterflowerview : UIScrollView

//set delegate and datasource

@property (nonatomic,weak) id <QXWaterflowerviewDataSource> dataSource;



@property (nonatomic,weak) id <QXWaterflowerviewDelegate> delegate;


- (void) reloadData;

- (id) dequeueReusableCellWithIdentifier:(NSString *) identifier;
@end
