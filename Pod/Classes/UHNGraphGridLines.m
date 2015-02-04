//
//  UHNGraphGridLines.m
//  bant
//
//  Created by Mat Trudel on 10-03-10.
//  Copyright 2015 University Health Network. All rights reserved.
//

#import "UHNGraphGridLines.h"
#import "UHNGraphView.h"
#import "UHNGraphScaleDataSource.h"
#import "UHNXRealScale.h"
#import "UHNYRealScale.h"

@interface UHNGraphGridLines()
- (void)drawGrayGridLineGradientsForContext: (CGContextRef)context inRect: (CGRect)rect;
@end

@implementation UHNGraphGridLines

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.drawsFrame = NO;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder: aDecoder]) {
        // Load defaults
        self.fadeGridLineEdges = NO;
        self.drawsFrame = NO;
        self.frameLineWidth = 1.0;
        self.frameColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	if (self.drawsFrame) {
        CGContextSetLineWidth(context, self.frameLineWidth);            
        CGContextSetStrokeColorWithColor(context, [self.frameColor CGColor]);
		CGContextStrokeRect(context, rect);	
		CGContextStrokePath(context);
	}
	
	if (self.gridLineColor) {
        CGContextSetStrokeColorWithColor(context, [self.gridLineColor CGColor]);
        if (self.xMinorScaleLineWidth) {
            CGContextSetLineWidth(context, self.xMinorScaleLineWidth);
            
            for (id value = [self.graph.xScale valueByAdding: self.graph.xScale.minorStep to: self.graph.xScale.min]; [self.graph.xScale compare: value	to: self.graph.xScale.max] == NSOrderedAscending; value = [self.graph.xScale valueByAdding: self.graph.xScale.minorStep to: value]) {
                
                if (self.fadeGridLineEdges)
                {
                    CGRect gradientRect = CGRectMake([self.graph.xScale screenValueForDomain: value],  self.bounds.origin.y,  self.xMinorScaleLineWidth,  self.bounds.origin.y + self.bounds.size.height);
                    [self drawGrayGridLineGradientsForContext: context inRect: gradientRect];
                }
                else
                {
                    CGFloat x = [self.graph.xScale screenValueForDomain: value];
                    CGContextMoveToPoint(context, x, self.bounds.origin.y);
                    CGContextAddLineToPoint(context, x, self.bounds.origin.y + self.bounds.size.height);
                }
            }
            CGContextStrokePath(context);
        }
        if (self.xMajorScaleLineWidth) {
            CGContextSetLineWidth(context, self.xMajorScaleLineWidth);
            for (id value = [self.graph.xScale valueByAdding: self.graph.xScale.majorStep to: self.graph.xScale.min]; [self.graph.xScale compare: value	to: self.graph.xScale.max] == NSOrderedAscending; value = [self.graph.xScale valueByAdding: self.graph.xScale.majorStep to: value]) {		
                if (self.fadeGridLineEdges) 
                {
                    CGRect gradientRect = CGRectMake([self.graph.xScale screenValueForDomain: value],  self.bounds.origin.y,  self.xMajorScaleLineWidth,  self.bounds.origin.y + self.bounds.size.height);
                    [self drawGrayGridLineGradientsForContext: context inRect: gradientRect];
                }
                else
                {
                    CGFloat x = [self.graph.xScale screenValueForDomain: value];
                    CGContextMoveToPoint(context, x, self.bounds.origin.y);
                    CGContextAddLineToPoint(context, x, self.bounds.origin.y + self.bounds.size.height);                    
                }
            }
            CGContextStrokePath(context);			
        }
        if (self.yMinorScaleLineWidth) {
            CGContextSetLineWidth(context, self.yMinorScaleLineWidth);
            for (id value = [self.graph.yScale valueByAdding: self.graph.yScale.minorStep to: self.graph.yScale.min]; [self.graph.yScale compare: value	to: self.graph.yScale.max] == NSOrderedAscending; value = [self.graph.yScale valueByAdding: self.graph.yScale.minorStep to: value]) {
                if (self.fadeGridLineEdges) 
                {
                    CGRect gradientRect = CGRectMake(self.bounds.origin.x, [self.graph.yScale screenValueForDomain: value],  self.bounds.origin.x + self.bounds.size.width, self.yMinorScaleLineWidth);
                    [self drawGrayGridLineGradientsForContext: context inRect: gradientRect];
                }
                else 
                {
                    CGFloat y = [self.graph.yScale screenValueForDomain: value];
                    CGContextMoveToPoint(context, self.bounds.origin.x, y);
                    CGContextAddLineToPoint(context, self.bounds.origin.x + self.bounds.size.width, y);
                }
            }
            CGContextStrokePath(context);			
        }
        if (self.yMajorScaleLineWidth) {
            CGContextSetLineWidth(context, self.yMajorScaleLineWidth);
            for (id value = [self.graph.yScale valueByAdding: self.graph.yScale.majorStep to: self.graph.yScale.min]; [self.graph.yScale compare: value	to: self.graph.yScale.max] == NSOrderedAscending; value = [self.graph.yScale valueByAdding: self.graph.yScale.majorStep to: value]) {		
                if (self.fadeGridLineEdges) 
                {
                    CGRect gradientRect = CGRectMake(self.bounds.origin.x, [self.graph.yScale screenValueForDomain: value],  self.bounds.origin.x + self.bounds.size.width, self.yMajorScaleLineWidth);
                    [self drawGrayGridLineGradientsForContext: context inRect: gradientRect];
                }
                else 
                {
                    CGFloat y = [self.graph.yScale screenValueForDomain: value];
                    CGContextMoveToPoint(context, self.bounds.origin.x, y);
                    CGContextAddLineToPoint(context, self.bounds.origin.x + self.bounds.size.width, y);
                }
            }
            CGContextStrokePath(context);
        }            
    }
}

- (void)drawGrayGridLineGradientsForContext: (CGContextRef)context inRect: (CGRect)rect
{
    // add rect to draw gradient in
    CGContextSaveGState(context);
    CGContextAddRect(context, rect);
    CGContextClip(context);
    
    // create gradient
    CGColorSpaceRef myColorspace=CGColorSpaceCreateDeviceGray();
    CGFloat whiteComponent, alphaComponent;
    [self.gridLineColor getWhite: &whiteComponent alpha: &alphaComponent];

    size_t num_locations = 5;
    CGFloat components[4 * 5] = { whiteComponent, 0.0,
        whiteComponent, 0.5,
        whiteComponent, 0.7,
        whiteComponent, 0.5,
        whiteComponent, 0.0};

    CGGradientRef gradient = CGGradientCreateWithColorComponents(myColorspace, components, nil, num_locations);
    
    // draw gradient
    CGContextDrawLinearGradient (context, gradient, CGPointMake(rect.origin.x, rect.origin.y), CGPointMake(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height), 0);
    CGContextRestoreGState(context);
}

@end
