//
//  HypnosisView.m
//  Hypnosister
//
//  Created by New on 8/17/14.
//  Copyright (c) 2014 New. All rights reserved.
//

#import "HypnosisView.h"

@implementation HypnosisView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.circleColor = [UIColor lightGrayColor];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"the circle has been touched");
    
    float red = ((arc4random() % 100) / 100.0);
    float blue = ((arc4random() % 100) / 100.0);
    float green = ((arc4random() % 100) / 100.0);
    
    UIColor * touchedColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    self.circleColor = touchedColor;
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGRect bounds = self.bounds;
    
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2;
    center.y = bounds.origin.y + bounds.size.height / 2;
    
    //float radius = (MIN(bounds.size.width, bounds.size.height) / 2.0);
    float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;
    
    UIBezierPath * path = [[UIBezierPath alloc] init];
//    [path addArcWithCenter:center radius:radius startAngle:0.0 endAngle:M_PI * 2.0 clockwise:YES];
//    path.lineWidth = 10;
//    [[UIColor lightGrayColor] setStroke];
//    [path stroke];
    
    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20)
    {
        [path moveToPoint:CGPointMake(center.x + currentRadius, center.y)];
        
        [path addArcWithCenter:center radius:currentRadius startAngle:0.0 endAngle:M_PI * 2.0 clockwise:YES];
    }
    
    path.lineWidth = 10;
    [self.circleColor setStroke];
    [path stroke];

    //UIImage * SoIImage = [UIImage imageNamed:@"SoI120.png"];
    //[SoIImage drawInRect:bounds];
}


@end
