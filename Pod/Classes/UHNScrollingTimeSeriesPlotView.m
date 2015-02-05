//
//  UHNScrollingTimeSeriesPlotView.m
//  Monashee
//
//  Created by Nathaniel Hamming on 12-03-01.
//  Copyright (c) 2015 UHN. All rights reserved.
//

#import "UHNScrollingTimeSeriesPlotView.h"
#import "UHNGraphScaleDataSource.h"
#import "UHNXRealScale.h"
#import "UHNYRealScale.h"
#import "UHNGraphGridLines.h"
#import "UHNDebug.h"

@interface UHNScrollingTimeSeriesPlotView() <UIScrollViewDelegate>
@property (nonatomic, retain) IBOutlet UIScrollView *container;
@property (nonatomic, retain) NSMutableArray *dataPoints;
@property (nonatomic, retain) NSTimer *dataGeneratorTimer;
@property (nonatomic, retain) NSTimer *plotUpdateTimer;
@property (nonatomic, assign) CGFloat xOffsetPerSample;
@property (nonatomic, assign) CGFloat yOffsetPerUnit;
@property (nonatomic, assign) CGFloat yOffsetForZeroLine;
@property (nonatomic, assign) NSInteger dataMaxSize;
- (void)addRandomDataPoint;
@end

@implementation UHNScrollingTimeSeriesPlotView

#pragma mark - Lifecycle Methods

- (id)initWithCoder:(NSCoder *)aDecoder 
{
    self = [super initWithCoder: aDecoder];
    if (self) 
    {
        self.dataPoints = [NSMutableArray array];
        
        //Load defaults
        self.plotRefreshRateInHz = 1;
        self.samplingRateInHz = 1;
        self.lineWidth = 1;
        self.lineColor = [UIColor whiteColor];
        
    }
    return self;    
}

- (void)setupPlotWithXAxisMin: (CGFloat)xMin
                     xAxisMax: (CGFloat)xMax
                   xMinorStep: (CGFloat)xMinorStep
                   xMajorStep: (CGFloat)xMajorStep
                   xAxisLabel: (NSString*)xLabel
            xAxisFormatString: (NSString*)xFormatString
                     yAxisMin: (CGFloat)yMin 
                     yAxisMax: (CGFloat)yMax
                   yMinorStep: (CGFloat)yMinorStep
                   yMajorStep: (CGFloat)yMajorStep
                   yAxisLabel: (NSString*)yLabel
            yAxisFormatString: (NSString*)yFormatString
                    gridColor: (UIColor*)gridColor
               gridFrameWidth: (CGFloat)gridFrameWidth
                drawGridFrame: (BOOL)drawGridFrame
            fadeGridLineEdges: (BOOL)fadeGridLineEdges
                    lineColor: (UIColor*)color 
                lineHeadColor: (UIColor*)headColor
                 andLineWidth: (CGFloat)lineWidth
{
    self.lineColor = color;
    self.lineHeadColor = headColor;
    self.lineWidth = lineWidth;
    
    // Setup x-axis
    if (!self.xScale) 
    {
        self.xScale = [[UHNXRealScale alloc] initWithFrame: self.frame];
    }
    self.xScale.min = [NSNumber numberWithDouble: xMin];
    self.xScale.max = [NSNumber numberWithDouble: xMax];
    self.xScale.minorStep = [NSNumber numberWithFloat: xMinorStep];	
    self.xScale.majorStep = [NSNumber numberWithFloat: xMajorStep];
    self.xScale.formatString = xFormatString;
    self.xScale.units = xLabel;
    self.xScale.tickColor = gridColor;
    [self.xScale setNeedsDisplay];	
    
    // Setup y-axis    
    if (!self.yScale) 
    {
        self.yScale = [[UHNYRealScale alloc] initWithFrame: self.frame];
    }
    self.yScale.min = [NSNumber numberWithDouble: yMin];
    self.yScale.max = [NSNumber numberWithDouble: yMax];
    self.yScale.minorStep = [NSNumber numberWithFloat: yMinorStep];	
    self.yScale.majorStep = [NSNumber numberWithFloat: yMajorStep];
    self.yScale.formatString = yFormatString;
    self.yScale.units = yLabel;
    self.yScale.tickColor = gridColor;
    [self.yScale setNeedsDisplay];
    
    //Setup Grid
    self.grid.drawsFrame = drawGridFrame;
    self.grid.fadeGridLineEdges = fadeGridLineEdges;
    self.grid.frameLineWidth = gridFrameWidth;
    self.grid.frameColor = gridColor;
    
    self.grid.gridLineColor = [gridColor colorWithAlphaComponent: 0.8];
    self.grid.xMinorScaleLineWidth = 1;
    self.grid.xMajorScaleLineWidth = 3;
    [self.grid setNeedsDisplay];
}

#pragma mark - Data Point methods

- (void)generateRandomData: (BOOL)on
{
    if (on) 
    {
        [self addRandomDataPoint];
        self.dataGeneratorTimer = [NSTimer scheduledTimerWithTimeInterval: 1.0/self.samplingRateInHz 
                                                                   target: self 
                                                                 selector: @selector(addRandomDataPoint) 
                                                                 userInfo: nil 
                                                                  repeats: YES];   
    }
    else 
    {
        [self.dataGeneratorTimer invalidate];
    }
}

- (void)addRandomDataPoint
{
    NSNumber *randomValue = [NSNumber numberWithInteger: (arc4random() % ([self.yScale.max integerValue] - [self.yScale.min integerValue]) + [self.yScale.min integerValue])];
    [self addDataPoint: randomValue];
}

- (void)addDataPoint: (NSNumber*)dataPoint
{
    [self.dataPoints addObject: dataPoint];
    if ([self.dataPoints count] > self.windowMaxSize) 
    {
        [self.dataPoints removeObjectAtIndex: 0];
    }
    [self updatePlot];
}

- (void)addDataPoints:(NSArray *)someDataPoints
{
    [self.dataPoints addObjectsFromArray: someDataPoints];
    NSInteger diff = [self.dataPoints count] - self.windowMaxSize;
    if (diff > 0) 
    {
        [self.dataPoints removeObjectsAtIndexes: [NSIndexSet indexSetWithIndexesInRange: NSMakeRange(0, diff)]];
    }
    [self updatePlot];
}

- (void)plotData: (NSArray*)data
{
    self.dataPoints = nil;
    self.dataPoints = [NSMutableArray arrayWithArray: data];
    [self updatePlot];
}

- (void)setSamplingRateInHz:(double)aSamplingRateInHz
{
    _samplingRateInHz = aSamplingRateInHz;
    self.xOffsetPerSample = [self.xScale screenValueForDomain: [NSNumber numberWithDouble: (1 / self.samplingRateInHz)]];
    LogDebugEvent(@"x offset per sample (%f sec/sample) in pixels: %f", (1/self.samplingRateInHz), self.xOffsetPerSample);
    self.yOffsetPerUnit = [self.yScale screenValueForDomain: [NSNumber numberWithDouble: [self.yScale.max doubleValue] - 1]];
    LogDebugEvent(@"y offset for 1 unit: %f", self.yOffsetPerUnit);
    self.yOffsetForZeroLine = [self.yScale screenValueForDomain: [NSNumber numberWithInt: 0]];
    LogDebugEvent(@"y offset for 0 line: %f", self.yOffsetForZeroLine);
    
    self.windowMaxSize = _samplingRateInHz * [self.xScale.max doubleValue];
    LogDebugEvent(@"array max size %ld", (long)self.windowMaxSize);
    LogDebugEvent(@"refresh rate: %f secs (%f samples/refresh)", 1/self.plotRefreshRateInHz, self.samplingRateInHz/self.plotRefreshRateInHz);
    
    // only store 4 windows of data
    self.dataMaxSize = 4 * self.windowMaxSize;
}

#pragma mark - Ploting Methods

- (void)hidePlot: (BOOL)hidden
{
    self.hidden = hidden;
    self.container.hidden = hidden;
    self.grid.hidden = hidden;
    self.yScale.hidden = hidden;
    self.xScale.hidden = hidden;
    if (self.plotUpdateTimer) {
        [self shouldRefresh: !hidden];
    }
}

- (void)shouldRefresh: (BOOL)refresh
{
    if (refresh && ![self.plotUpdateTimer isValid])
    {
        self.plotUpdateTimer = [NSTimer scheduledTimerWithTimeInterval: 1.0/self.plotRefreshRateInHz
                                                                target: self 
                                                              selector: @selector(updatePlot)
                                                              userInfo: nil
                                                               repeats: YES];
    }
    else if (!refresh)
    {
        [self.plotUpdateTimer invalidate];
        [self updatePlot];
    }
    
    self.container.scrollEnabled = !refresh;
}

- (void)updatePlot
{
    //TODO try extend redrawing view contents with scrolling

    if (![self.plotUpdateTimer isValid]) 
    {
        // trying extending the width at end of collection
        if (self.dataPoints.count > self.windowMaxSize) 
        {
            NSInteger numberOfOffScreenSamplesToDraw = self.dataPoints.count - self.windowMaxSize;
            CGFloat xOffset = (self.xOffsetPerSample * numberOfOffScreenSamplesToDraw);
            CGRect frame = self.frame;
            frame.size.width = frame.size.width + xOffset;
            self.frame = frame;
            self.container.contentSize = self.bounds.size;
            [self.container setContentOffset: CGPointMake(xOffset, 0) animated: NO];            
        }
    }
    [self setNeedsDisplay];
}

- (void)removeAllDataPoints
{
    [self.dataPoints removeAllObjects];
    self.container.contentSize = self.bounds.size;
    [self.container setContentOffset: CGPointMake(0, 0) animated: NO];
    [self setNeedsDisplay];
}

- (void) drawRect : (CGRect) rect
{
    [super drawRect : rect];
    CGContextRef context = UIGraphicsGetCurrentContext ();
    NSInteger numberOfDataPoints = self.dataPoints.count;
    CGFloat currentXValue = 0.;
    CGFloat currentYValue = 0.;
    if (numberOfDataPoints > 1) {
        CGContextSetLineWidth (context, self.lineWidth);
        CGContextSetStrokeColorWithColor(context, [self.lineColor CGColor]);
        
        // Draw only what is displayed.
        int indexCounter = 1;
        if ((numberOfDataPoints > self.windowMaxSize) && [self.plotUpdateTimer isValid]) 
        {
            indexCounter = (int)numberOfDataPoints - (int)self.windowMaxSize;
        }
        
        for (; indexCounter < numberOfDataPoints; indexCounter++) 
        {
            double previousDataPoint = [[self.dataPoints objectAtIndex: indexCounter - 1] doubleValue];
            double currentDataPoint = [[self.dataPoints objectAtIndex: indexCounter] doubleValue];
            
            CGFloat previousYValue = self.bounds.origin.y + self.yOffsetForZeroLine - (self.yOffsetPerUnit * previousDataPoint);
            currentYValue = self.bounds.origin.y + self.yOffsetForZeroLine - (self.yOffsetPerUnit * currentDataPoint);
            
            CGFloat previousXValue = self.bounds.size.width - (self.xOffsetPerSample * (numberOfDataPoints - indexCounter + 1)) - 20; 
            currentXValue = self.bounds.size.width - (self.xOffsetPerSample * (numberOfDataPoints - indexCounter)) - 20;
            
            CGContextMoveToPoint(context, previousXValue, previousYValue);
            CGContextAddLineToPoint(context, currentXValue, currentYValue);
        }            

        CGContextStrokePath(context);
        
        // draw line head with radial gradient
        CGColorSpaceRef myColorspace=CGColorSpaceCreateDeviceRGB();
        CGFloat redComponent, greenComponent, blueComponent, alphaComponent;
        [self.lineHeadColor getRed: &redComponent green: &greenComponent blue: &blueComponent alpha: &alphaComponent];
        
        size_t num_locations = 2;
        CGFloat components[8] = { redComponent, greenComponent, blueComponent, 0.7, redComponent, greenComponent, blueComponent, 0.1};
        CGGradientRef gradient = CGGradientCreateWithColorComponents(myColorspace, components, nil, num_locations);
        CGContextDrawRadialGradient(context, gradient, CGPointMake(currentXValue, currentYValue), 0, CGPointMake(currentXValue, currentYValue), 10, kCGGradientDrawsBeforeStartLocation);
    }
    else
    {
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        CGContextFillRect(context, rect);
    }
}

#pragma mark - UIScrollView Delegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
}

@end
