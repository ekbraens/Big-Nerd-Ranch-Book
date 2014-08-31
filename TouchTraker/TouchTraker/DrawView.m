//
//  DrawView.m
//  TouchTraker
//
//  Created by New on 8/30/14.
//  Copyright (c) 2014 New. All rights reserved.
//

#import "DrawView.h"
#import "Line.h"

@interface DrawView ()

@property (nonatomic, strong) NSMutableDictionary * linesInProgress;
@property (nonatomic, strong) NSMutableArray * finishedLines;

@end

@implementation DrawView

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch * t in touches)
    {
        CGPoint location = [t locationInView:self];
        
        Line * line = [[Line alloc] init];
        line.startPoint = location;
        line.endPoint = location;
        
        NSValue * key = [NSValue valueWithNonretainedObject:t];
        self.linesInProgress[key] = line;
    }
    
    [self setNeedsDisplay];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch * t in touches)
    {
        NSValue * key = [NSValue valueWithNonretainedObject:t];
        Line * line = self.linesInProgress[key];
        
        line.endPoint = [t locationInView:self];
    }
    
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch * t in touches)
    {
        NSValue * key = [NSValue valueWithNonretainedObject:t];
        Line * line = self.linesInProgress[key];
        
        [self.finishedLines addObject:line];
        [self.linesInProgress removeObjectForKey:key];
    }
    
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect
{
    // Draw finished lines in black
    [[UIColor blackColor] set];
    for (Line * line in self.finishedLines)
    {
        [self strokeLine:line];
    }
    [[UIColor redColor] set];
    for (NSValue * key in self.linesInProgress)
    {
        [self strokeLine:self.linesInProgress[key]];
    }
}

-(void)strokeLine:(Line *)line
{
    UIBezierPath * bp = [[UIBezierPath alloc] init];
    bp.lineWidth = 10;
    bp.lineCapStyle = kCGLineCapRound;
    
    [bp moveToPoint:line.startPoint];
    [bp addLineToPoint:line.endPoint];
    [bp stroke];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.linesInProgress = [[NSMutableDictionary alloc] init];
        self.backgroundColor = [UIColor grayColor];
        self.multipleTouchEnabled = YES;
    }
    
    return self;
}

@end
