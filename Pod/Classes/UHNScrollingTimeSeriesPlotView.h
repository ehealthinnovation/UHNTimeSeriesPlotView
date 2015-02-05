//
//  UHNScrollingTimeSeriesPlotView.h
//  Monashee
//
//  Created by Nathaniel Hamming on 12-03-01.
//  Copyright (c) 2015 UHN. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "UHNGraphView.h"

/**
 `UHNScrollingTimeSeriesPlotView` is a dynamic time series plot capable of displaying data collected in real-time. It is a subclass of the UHNGraphView with convenience methods for adding/removing data points, setting refresh of the plot (when the data is being collected faster then the UI can handle. This would present data points in blocks), etc.
 
 Construction of the plot view is a large setup method with a variety of parameters. This implementation is indented that the plot is constructed once with all relevant details. For the parameters that are can be updated dynamically, additional convenience methods or class properties are provided.
 
 This plot view can be using in conjunction with the UHNGraphGridView, if a grid is desired with the plot. As well, the axes can be visualized with UHNXRealScale and UHNYRealScale views. All these classes are provided as part of this cocoapod.
 
 Future development of this cocoapod is to include a UIScrollView container for the plot, such that the user can pause the plot refresh and scroll back to view historical data. Currently this feature is partially implemented.
 */
@interface UHNScrollingTimeSeriesPlotView : UHNGraphView

/**
 The color of the line plotted. Default is the white color
 */
@property (nonatomic, strong) UIColor *lineColor;

/**
 The color of the line head. The line head color is a circular gradient from the specified color with alpha of 1 fading to an alpha of 0.
 */
@property (nonatomic, strong) UIColor *lineHeadColor;

/**
 The width of the line plotted. Default value is 1.
 */
@property (nonatomic, assign) CGFloat lineWidth;

/**
 The refresh rate of the plot in Hz. If this slower than the sampling rate, the plot will refresh with blocks of data. Making this value faster than the sampling rate is not appropriate, as the plot would refresh without any additional data. Default value is 1 Hz.
 */
@property (nonatomic, assign) double plotRefreshRateInHz;

/**
 The sampling rate of the collected data in Hz. This value is needed to appropriately visualize the data points on a time-based scale. Default value is 1 Hz.
 */
@property (nonatomic, assign) double samplingRateInHz;

/**
 The max size of the data point window, which indicates how many data points should be stored in memory before being dropped. When a UIScrollView container is used and the max window size is greater than the x-axis range, the plot view will extend past the UIScrollView frame and allow for historical viewing of data.
 */
@property (nonatomic, assign) NSInteger windowMaxSize;

/**
 Allows for manual plot updates. This method could be linked to a timer or specific actions
 */
- (void)updatePlot;

/**
 Generate random data to be plotted. This should be used as a visual test to ensure the plot view is acting correctly.
 
 @param on Specifies is data generation should be on
 */
- (void)generateRandomData: (BOOL)on;

/**
 Add a single data point to the plot.
 
 @param dataPoint The data point to be added to the plot
 */
- (void)addDataPoint: (NSNumber*)dataPoint;

/**
 Add an array of data points to the plot. The data in the array should be ordered from oldest to newest. The array must contain NSNumber objects.
 
 @param dataPoints Array of the data points (NSNumber) to be added to the plot.
 */
- (void)addDataPoints: (NSArray *)dataPoints;

/**
 First clear the plot and then plot the data in the array. The data in the array should be ordered from oldest to newest. The array must contain NSNumber objects.
 
 @param data Array of the data points (NSNumber) to be added to the plot.
 */
- (void)plotData: (NSArray*)data;

/**
 Remove all the data points from the plot.
 */
- (void)removeAllDataPoints;

/**
 Used to set an independent refresh cycle for the plot, based on the plot refresh rate. This should be used when the data collected is too fast for the UI.
 
 @param refresh Specifies if the plot should run indepent refresh cycle
 */
- (void)shouldRefresh: (BOOL)refresh;

/** 
 Hides the plot
 
 @param hidden Specifies if the plot should be hidden
 */
- (void)hidePlot: (BOOL)hidden;

/**
 Construction of the plot view. This method should be called after the plot view has been instantiated. It includes all relevant details of the plot to be visualized and present data.
 
 @param xMin The minimum value of the x-axis range
 @param xMax The maximum value of the x-axis range
 @param xMinorStep The minor step of the x-axis and used to visual x-axis minor ticks on the graph grid
 @param xMajorStep The major step of the x-axis and used to visual x-axis major ticks on the graph grid
 @param xLabel The unit label for the x-axis
 @param xFormatString The format string for presenting the x-axis major tick value on the graph grid
 @param yMin The minimum value of the y-axis range
 @param yMax The maximum value of the y-axis range
 @param yMinorStep The minor step of the y-axis and used to visual y-axis minor ticks on the graph grid
 @param yMajorStep The major step of the y-axis and used to visual y-axis major ticks on the graph grid
 @param yLabel The unit label for the y-axis
 @param yFormatString The format string for presenting the y-axis major tick value on the graph grid
 @param gridColor The color of the graph grid lines
 @param gridFrameWidth The line width of the graph grid frame
 @param drawGridFrame Specifies if the frame of the graph grid shoul be drawn
 @param fadeGridLineEdges Specifies if the graph grid lines tips should be faded
 @param lineColor Specifies the color of the line plotted
 @param lineHeadColor Specifies the color of the line head. The line head is a circular gradient that fades from an alpha of 1 to 0
 @param lineWidth The width of the line plotted
 */
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
                    lineColor: (UIColor*)lineColor 
                lineHeadColor: (UIColor*)lineHeadColor
                 andLineWidth: (CGFloat)lineWidth;

@end
