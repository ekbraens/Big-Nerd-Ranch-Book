//
//  DrawView.m
//  TouchTraker
//
//  Created by New on 8/30/14.
//  Copyright (c) 2014 New. All rights reserved.
//

#import "DrawView.h"
#import "Line.h"

@interface DrawView () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIPanGestureRecognizer * moveRecog;
@property (nonatomic, strong) NSMutableDictionary * linesInProgress;
@property (nonatomic, strong) NSMutableArray * finishedLines;
@property (nonatomic) BOOL isSelected;

@property (nonatomic, weak) Line * selectedLine;

@end

@implementation DrawView

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch * t in touches)
    {
        CGPoint location = [t locationInView:self];
        
        if (!_isSelected)
        {
        Line * line = [[Line alloc] init];
        line.startPoint = location;
        line.endPoint = location;
        
        NSValue * key = [NSValue valueWithNonretainedObject:t];
        self.linesInProgress[key] = line;
        }
    }
    
    [self setNeedsDisplay];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_isSelected)
    {
        return;
    }
    
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
        if (!_isSelected)
        {
        NSValue * key = [NSValue valueWithNonretainedObject:t];
        Line * line = self.linesInProgress[key];
        
        [self.finishedLines addObject:line];
        [self.linesInProgress removeObjectForKey:key];
        }
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
    if (self.selectedLine)
    {
        [[UIColor greenColor] set];
        [self strokeLine:self.selectedLine];
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
        self.finishedLines = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor grayColor];
        self.multipleTouchEnabled = YES;
        
        UITapGestureRecognizer * doubleTapRecog = [[UITapGestureRecognizer alloc]
                                                initWithTarget:self action:@selector(doubleTap:)];
        doubleTapRecog.numberOfTapsRequired = 2;
        doubleTapRecog.delaysTouchesBegan = YES;
        [self addGestureRecognizer:doubleTapRecog];
        
        UITapGestureRecognizer * tapRecog = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
        tapRecog.delaysTouchesBegan = YES;
        [tapRecog requireGestureRecognizerToFail:doubleTapRecog];
        [self addGestureRecognizer:tapRecog];
        
        UILongPressGestureRecognizer * longPressRecog = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:longPressRecog];
        
        self.moveRecog = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveLine:)];
        
        self.moveRecog.delegate = self;
        self.moveRecog.cancelsTouchesInView = NO;
        [self addGestureRecognizer:self.moveRecog];
    }
    
    return self;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if (gestureRecognizer == self.moveRecog)
    {
        return YES;
    }
    return NO;
}

-(Line *)lineAtPoint:(CGPoint)p
{
    // Find a line close to p
    for (Line * line in self.finishedLines)
    {
        CGPoint start = line.startPoint;
        CGPoint end = line.endPoint;
        
        // check a few points on the line
        for (float t = 0.0; t <= 1.0; t+=.05)
        {
            float x = start.x + t * (end.x - start.x);
            float y = start.y + t * (end.y - start.y);
            
            if (hypot(x - p.x, y - p.y) < 20.0)
            {
                return line;
            }
        }
    }
    return nil;
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

-(void)deleteLine:(id)sender
{
    [self.finishedLines removeObject:self.selectedLine];
    
    [self setNeedsDisplay];
}

-(void)moveLine:(UIPanGestureRecognizer *)gr
{
    
    if (!self.selectedLine)
    {
        return;
    }
//
//    if (_isSelected && self.selectedLine != [self lineAtPoint:[gr locationInView:self]])
//    {
//        return;
//    }
    
    if (gr.state == UIGestureRecognizerStateChanged)
    {
        CGPoint translation = [gr translationInView:self];
        
        CGPoint begin = self.selectedLine.startPoint;
        CGPoint end = self.selectedLine.endPoint;
        begin.x += translation.x;
        begin.y += translation.y;
        end.x += translation.x;
        end.y += translation.y;
        
        self.selectedLine.startPoint = begin;
        self.selectedLine.endPoint = end;
        
        [self setNeedsDisplay];
        
        [gr setTranslation:CGPointZero inView:self];
    }
}

-(void)longPress:(UIGestureRecognizer *)gr
{
    if (gr.state == UIGestureRecognizerStateBegan)
    {
        CGPoint point = [gr locationInView:self];
        self.selectedLine = [self lineAtPoint:point];
        
        if (self.selectedLine)
        {
            [self.linesInProgress removeAllObjects];
        }
    }
    else if(gr.state == UIGestureRecognizerStateEnded)
    {
        self.selectedLine = nil;
    }
    [self setNeedsDisplay];
}

-(void)singleTap:(UIGestureRecognizer *)gr
{
    CGPoint point = [gr locationInView:self];
    self.selectedLine = [self lineAtPoint:point];
    
    if (self.selectedLine)
    {
        _isSelected = YES;
        
        [self becomeFirstResponder];
        
        UIMenuController * menu = [UIMenuController sharedMenuController];
        
        UIMenuItem * deleteItem = [[UIMenuItem alloc] initWithTitle:@"Delete" action:@selector(deleteLine:)];
        
        menu.menuItems = @[deleteItem];
        
        [menu setTargetRect:CGRectMake(point.x, point.y, 2, 2) inView:self];
        [menu setMenuVisible:YES animated:YES];
    }
    else
    {
        _isSelected = NO;
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
    }
    
    [self setNeedsDisplay];
}

-(void)doubleTap:(UIGestureRecognizer *)gr
{
    [self.linesInProgress removeAllObjects];
    [self.finishedLines removeAllObjects];
    [self setNeedsDisplay];
}

@end
