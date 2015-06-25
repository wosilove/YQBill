//
//  YQLockView.m
//  记账软件
//
//  Created by nickchen on 15/5/9.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import "YQLockView.h"
#import "YQCircleView.h"

@interface YQLockView ()

@property (nonatomic, strong) NSMutableArray *selectedButtons;
@property (nonatomic, assign) CGPoint currentMovePoint;

@end

@implementation YQLockView

#pragma mark - 初始化
- (NSMutableArray *)selectedButtons
{
    if (_selectedButtons == nil) {
        _selectedButtons = [NSMutableArray array];
    }
    return _selectedButtons;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

/**
 初始化
 */
- (void)setup
{
    for (int index = 0; index<9; index++) {
        // 创建按钮
        YQCircleView *btn = [YQCircleView buttonWithType:UIButtonTypeCustom];
        btn.tag = index;
        // 添加按钮
        [self addSubview:btn];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (int index = 0; index<self.subviews.count; index++) {
        // 取出按钮
        YQCircleView *btn = self.subviews[index];
        
        // 设置frame
        CGFloat btnW = 74;
        CGFloat btnH = 74;
        
        int totalColumns = 3;
        int col = index % totalColumns;
        int row = index / totalColumns;
        CGFloat marginX = (self.frame.size.width - totalColumns * btnW) / (totalColumns + 1);
        CGFloat marginY = marginX;
        
        CGFloat btnX = marginX + col * (btnW + marginX);
        CGFloat btnY = row * (btnH + marginY);
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
}

#pragma mark - 私有方法
/**
 根据touches集合获得对应的触摸点位置
 */
- (CGPoint)pointWithTouches:(NSSet *)touches
{
    UITouch *touch = [touches anyObject];
    return [touch locationInView:touch.view];
}

/**
 根据触摸点位置获得对应的按钮
 */
- (YQCircleView *)buttonWithPoint:(CGPoint)point
{
    for (YQCircleView *btn in self.subviews) {
        //        CGFloat wh = 24;
        //        CGFloat frameX = btn.center.x - wh * 0.5;
        //        CGFloat frameY = btn.center.y - wh * 0.5;
        //        if (CGRectContainsPoint(CGRectMake(frameX, frameY, wh, wh), point)) {
        if (CGRectContainsPoint(btn.frame, point)) {
            return btn;
        }
    }
    
    return nil;
}

#pragma mark - 触摸方法
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 清空当前的触摸点
    self.currentMovePoint = CGPointZero;
    
    // 1.获得触摸点
    CGPoint pos = [self pointWithTouches:touches];
    
    // 2.获得触摸的按钮
    YQCircleView *btn = [self buttonWithPoint:pos];
    
    // 3.设置状态
    if (btn && btn.selected == NO) {
        btn.selected = YES;
        [self.selectedButtons addObject:btn];
    }
    
    // 4.刷新
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 1.获得触摸点
    CGPoint pos = [self pointWithTouches:touches];
    
    // 2.获得触摸的按钮
    YQCircleView *btn = [self buttonWithPoint:pos];
    
    // 3.设置状态
    if (btn && btn.selected == NO) { // 摸到了按钮
        btn.selected = YES;
        [self.selectedButtons addObject:btn];
    } else { // 没有摸到按钮
        self.currentMovePoint = pos;
    }
    
    // 4.刷新
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(lockView:didFinishPath:)]) {
        NSMutableString *path = [NSMutableString string];
        for (YQCircleView *btn in self.selectedButtons) {
            [path appendFormat:@"%ld", btn.tag];
        }
        [self.delegate lockView:self didFinishPath:path];
    }
    
    // 取消选中所有的按钮
    //    for (MJCircleView *btn in self.selectedButtons) {
    ////        btn.selected = NO;
    //        [btn setSelected:NO];
    //    }
    [self.selectedButtons makeObjectsPerformSelector:@selector(setSelected:) withObject:@(NO)];
    
    // 清空选中的按钮
    [self.selectedButtons removeAllObjects];
    [self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}

#pragma mark - 绘图
- (void)drawRect:(CGRect)rect
{
    if (self.selectedButtons.count == 0) return;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // 遍历所有的按钮
    for (int index = 0; index<self.selectedButtons.count; index++) {
        YQCircleView *btn = self.selectedButtons[index];
        
        if (index == 0) {
            [path moveToPoint:btn.center];
        } else {
            [path addLineToPoint:btn.center];
        }
    }
    
    // 连接
    if (CGPointEqualToPoint(self.currentMovePoint, CGPointZero) == NO) {
        [path addLineToPoint:self.currentMovePoint];
    }
    
    // 绘图
    path.lineWidth = 8;
    path.lineJoinStyle = kCGLineJoinBevel;
    //    [[UIColor greenColor] set];
    [[UIColor colorWithRed:32/255.0 green:210/255.0 blue:254/255.0 alpha:0.5] set];
    [path stroke];
}


@end
