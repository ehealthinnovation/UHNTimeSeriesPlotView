//
//  UHNScrollingTimeSeriesPlotView.h
//  Monashee
//
//  Created by Nathaniel Hamming on 12-03-01.
//  Copyright (c) 2015 UHN. All rights reserved.
//

#import "UHNGraphView.h"

@interface UHNScrollingTimeSeriesPlotView : UHNGraphView

@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, strong) UIColor *lineHeadColor;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) double plotRefreshRateInHz;
@property (nonatomic, assign) double samplingRateInHz;
@property (nonatomic, assign) NSInteger windowMaxSize;

- (void)updatePlot;
- (void)generateRandomData: (BOOL)on;
- (void)addDataPoint: (NSNumber*)dataPoint;
- (void)addDataPoints: (NSArray *)dataPoints;
- (void)plotData: (NSArray*)data;
- (void)removeAllDataPoints;
- (void)shouldRefresh: (BOOL)refresh;
- (void)hidePlot: (BOOL)hidden;
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
                gridLineWidth: (CGFloat)gridFrameWidth
                drawGridFrame: (BOOL)drawGridFrame
            fadeGridLineEdges: (BOOL)fadeGridLineEdges
                    lineColor: (UIColor*)lineColor 
                lineHeadColor: (UIColor*)lineHeadColor
                 andLineWidth: (CGFloat)width;

@end
