//
//  QXWaterflowerview.m
//  瀑布流1.1
//
//  Created by 崇庆旭 on 15/6/24.
//  Copyright (c) 2015年 崇庆旭. All rights reserved.
//

#import "QXWaterflowerview.h"
#import "QXwaterflowerviewCell.h"

#define  QXWaterflowerviewDefaultCellHeight 80
#define  QXWaterflowerviewDefaultColumns 3
#define   QXWaterflowerviewDefaultMargin 5





@interface QXWaterflowerview ()

/**
 *  存放所有的frame
 */
@property (nonatomic,strong) NSMutableArray *cellFrames;

/**
 *  存放正在展示的cell
 */
@property (nonatomic,strong) NSMutableDictionary *displayingCells;

/**
 *  自定义的缓存池
 */
@property (nonatomic,strong) NSMutableSet *reusableCells;

@end

@implementation QXWaterflowerview

#pragma mark - 懒加载（lazy load）

- (NSMutableArray *)cellFrames
{
    if (_cellFrames == nil) {
        self.cellFrames = [NSMutableArray array];
    }
    return _cellFrames;
}

- (NSMutableDictionary *)displayingCells
{
    if (_displayingCells == nil) {
        self.displayingCells = [NSMutableDictionary dictionary];
    }
    return _displayingCells;
}

- (NSMutableSet *)reusableCells
{
    if (_reusableCells == nil) {
        self.reusableCells = [NSMutableSet set];
    }
    return _reusableCells;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

#pragma mark - publicAPI
/**
 *  刷新 ,从数据源中得到数据 计算每一个cell的frame
 */
- (void) reloadData
{
    //数据源方法需要返还的数据
    
    UIView *headerview = [self headerViewInwaterview:self];
    
    //cell的总数
    NSUInteger numberOfCells = [self.dataSource numberOfCellsInWaterflowerview:self];
    
    //总列数
    NSUInteger numberOfColumns = [self numberOfColums];
    
    //计算间距
    CGFloat topM = [self marginForType:QXWaterflowerviewMarginTypeTop];
    CGFloat bottomM = [self marginForType:QXWaterflowerviewMarginTypeBottom];
    CGFloat leftM = [self marginForType:QXWaterflowerviewMarginTypeLeft];
    CGFloat rightM = [self marginForType:QXWaterflowerviewMarginTypeRight];
    CGFloat rolM = [self marginForType:QXWaterflowerviewMarginTypeRow];
    CGFloat colM = [self marginForType:QXWaterflowerviewMarginTypeColumn];
    
    //cell的宽度
    CGFloat cellW = (self.frame.size.width - leftM - rightM - (numberOfColumns - 1)* colM )/ numberOfColumns ;
    
    //用C语言数组存放一个每一列的MaxY值 为什么不用OC数组  OC数组只能存放对象
    CGFloat maxYOfColumns[numberOfColumns];
    
    //初始化C语言数组
    for (int i = 0; i < numberOfColumns; i ++) {
        maxYOfColumns[i] = 0;
    }
    
    if (!headerview) {

    //计算所有cell的frame  每个cell应该加在对应列的最小Y值下面 这样才能保证瀑布流平铺
    
    for (int i = 0; i < numberOfCells ; i ++)
    {
        //cell处在的列数
        NSUInteger cellColumn = 0;
        
        //cell处在那一列的Y值
        CGFloat cellColumnY = maxYOfColumns[cellColumn];
        
        //求出最短一列
        for (int j = 1; j < numberOfColumns; j ++) {
            if (cellColumnY > maxYOfColumns[j]) {
                cellColumn = j;
                cellColumnY = maxYOfColumns[j];
                
            }
        }
        
        //计算代理第i位置cell的height
        CGFloat cellH = [self heightAtIndex:i];
        
        //cell的位置
        CGFloat cellX = leftM + cellColumn * (cellW + colM);
        
        CGFloat cellY = 0;
        
        
        
        if (cellColumnY == 0) {
            cellY = topM;
        } else cellY = cellColumnY + topM;
        
        CGRect cellFrame = CGRectMake(cellX, cellY, cellW, cellH);
        
        [self.cellFrames addObject:[NSValue valueWithCGRect:cellFrame]];
        
        QXwaterflowerviewCell *cell = [self.dataSource waterflowerview:self cellAtIndex:i];
        cell.frame = cellFrame;
        [self addSubview:cell];
        
        
        //设置最短那列的最大Y值
        maxYOfColumns[cellColumn] = CGRectGetMaxY(cellFrame);
        
    }
    // ! headerview
    }  else
    {
        CGFloat headviewH = headerview.frame.size.height;
        CGFloat headviewW = headerview.frame.size.width;
        CGFloat headviewX = leftM;
        CGFloat headviewY = topM;
        headerview.frame = CGRectMake(headviewX, headviewY, headviewW, headviewH);
        [self addSubview:headerview];
        
        //计算所有cell的frame  每个cell应该加在对应列的最小Y值下面 这样才能保证瀑布流平铺
        
        for (int i = 0; i < numberOfCells ; i ++)
        {
            //cell处在的列数
            NSUInteger cellColumn = 0;
            
            //cell处在那一列的Y值
            CGFloat cellColumnY = maxYOfColumns[cellColumn];
            
            //求出最短一列
            for (int j = 1; j < numberOfColumns; j ++) {
                if (cellColumnY > maxYOfColumns[j]) {
                    cellColumn = j;
                    cellColumnY = maxYOfColumns[j];
                    
                }
            }
            
            //计算代理第i位置cell的height
            CGFloat cellH = [self heightAtIndex:i];
            
            //cell的位置
            CGFloat cellX = leftM + cellColumn * (cellW + colM);
            
            CGFloat cellY = 0;
            
            
            
            if (cellColumnY == 0) {
                cellY = topM + headviewH + 10;
            } else cellY = cellColumnY + topM;
            
            CGRect cellFrame = CGRectMake(cellX, cellY, cellW, cellH);
            
            [self.cellFrames addObject:[NSValue valueWithCGRect:cellFrame]];
            
//            QXwaterflowerviewCell *cell = [self.dataSource waterflowerview:self cellAtIndex:i];
//            cell.frame = cellFrame;
//            [self addSubview:cell];
            
            
            //设置最短那列的最大Y值
            maxYOfColumns[cellColumn] = CGRectGetMaxY(cellFrame);
            
        }
        //headeview you
    }
    
    //设置contensize
    CGFloat contenH = maxYOfColumns[0];
    
    for (int k = 1 ; k < numberOfColumns; k ++) {
        if (contenH < maxYOfColumns[k]) {
            contenH = maxYOfColumns[k];
        }
    }
    
    contenH += bottomM;
    self.contentSize = CGSizeMake(0, contenH);
    
}


#pragma mark - 重用

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    NSUInteger numberofCells = self.cellFrames.count;
    
    for (int i = 0; i < numberofCells; i ++) {
        
         CGRect cellFrame = [self.cellFrames[i] CGRectValue];
        //从字典中取出cell
        // 对应位置的cell (刚出来是空)
        QXwaterflowerviewCell *cell = self.displayingCells[@(i)];
        
        //用来判断i位置所对应的frame是否在当前的屏幕上  在的话显示 不在的话隐藏
        if ([self isInScreen:cellFrame])
        {
            if (!cell) { //cell不存在
                //将这个位置的cell 添加到屏幕上
                cell = [self.dataSource waterflowerview:self cellAtIndex:i];
                cell.frame = cellFrame;
                [self addSubview:cell];
                
                //存放到字典中
                self.displayingCells[@(i)] = cell;
                
            }
        } else{ //不再屏幕上
            
            if (cell) {
                //将这个cell从字典中移除 保证字典中的对象都是当前屏幕上的
                [cell removeFromSuperview];
                [self.displayingCells removeObjectForKey:@(i)];
                
                //将不在屏幕上的cell放入缓存池中
                
                [self.reusableCells addObject:cell];
                
            }
        }
    }

}

/**
 *
 *  利用重用标识符从缓存池中找到cell
 */
- (id) dequeueReusableCellWithIdentifier:(NSString *) identifier
{
    
    // 用bloclk 修饰过才能在block中赋值成功
    __block QXwaterflowerviewCell *reusableCell = nil;
    
    //遍历 id obj 中 报错？
    [self.reusableCells enumerateObjectsUsingBlock:^(QXwaterflowerviewCell *cell, BOOL *stop) {
//        NSLog(@"cell.id %@",cell.identifier);
        if ([cell.identifier isEqualToString:identifier ] ) {
            reusableCell = cell;
            
//            NSLog(@"找到了");
            *stop = YES;
        }
    }];
    
    if (reusableCell) { // 找到了这个可以重用的cell 就从缓存池中删除 避免数据累🐔
        [self.reusableCells removeObject:reusableCell];
    }
    
    return reusableCell;
}

#pragma mark - priviateAPI


/**
 *  判断一个cell的frame 是否是在屏幕上
 *
 *  @param frame <#frame description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)isInScreen:(CGRect)frame
{
    return (CGRectGetMaxY(frame) > self.contentOffset.y) &&
    (CGRectGetMinY(frame) < self.contentOffset.y + self.frame.size.height);
}

/**
 *  margin
 *
 *  @param type <#type description#>
 *
 *  @return <#return value description#>
 */
- (CGFloat) marginForType:(QXWaterflowerviewMarginType ) type
{
    if ([self.delegate respondsToSelector:@selector(waterflowerview:maginForType:)]) {
        return [self.delegate waterflowerview:self maginForType:type];
    } else return QXWaterflowerviewDefaultMargin;
}


/**
 *  columns
 *
 *  @return <#return value description#>
 */
- (NSUInteger) numberOfColums
{
    if ([self.dataSource respondsToSelector:@selector(numberOfColumnsInWaterflowerview:)]) {
        return [self.dataSource numberOfColumnsInWaterflowerview:self];
    } else return QXWaterflowerviewDefaultColumns;
}


/**
 *  cell height
 */
- (CGFloat) heightAtIndex:(NSUInteger) index
{
    if ([self.delegate respondsToSelector:@selector(waterflowerview:heightForRowInIndex:)]) {
        return [self.delegate waterflowerview:self heightForRowInIndex:index];
    } else
    {
        return QXWaterflowerviewDefaultCellHeight;
    }
}


/**
 *  是否有headerview
 */

- (UIView *) headerViewInwaterview:(QXWaterflowerview *) waterview
{
    if ([self.dataSource respondsToSelector:@selector(headerViewInWatervierflower:)]) {
        NSLog(@"header");
       return  [self.dataSource headerViewInWatervierflower:self];
    } return nil;
}

#pragma mark - 事件处理
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (![self.delegate respondsToSelector:@selector(waterflowerview:didSelectAtInIndex:)]) return;
    
    // 获得触摸点
    UITouch *touch = [touches anyObject];
    //    CGPoint point = [touch locationInView:touch.view];
    CGPoint point = [touch locationInView:self];
    
    __block NSNumber *selectIndex = nil;
    [self.displayingCells enumerateKeysAndObjectsUsingBlock:^(id key, QXwaterflowerviewCell *cell, BOOL *stop) {
        if (CGRectContainsPoint(cell.frame, point)) {
            selectIndex = key;
            *stop = YES;
        }
    }];
    
    if (selectIndex) {
        [self.delegate waterflowerview :self didSelectAtInIndex:selectIndex.unsignedIntegerValue];
    }
}

@end
