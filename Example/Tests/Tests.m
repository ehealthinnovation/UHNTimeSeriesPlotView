//
//  UHNTimeSeriesPlotViewTests.m
//  UHNTimeSeriesPlotViewTests
//
//  Created by Nathaniel Hamming on 02/04/2015.
//  Copyright (c) 2014 Nathaniel Hamming. All rights reserved.
//

#import <UHNTimeSeriesPlotView/UHNTimeSeriesPlotView.h>

SpecBegin(PlotSpecs)

describe(@"Testing plotting points and updating style", ^{

    __block UHNGraphGridLines *grid = nil;
    __block UHNScrollingTimeSeriesPlotView *plot = nil;
    __block UIView *container = nil;
    
    beforeEach(^{
        container = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 302, 202)];
        container.backgroundColor = [UIColor blackColor];
        
        plot = [[UHNScrollingTimeSeriesPlotView alloc] initWithFrame: CGRectMake(0, 0, 300, 200)];
        grid = [[UHNGraphGridLines alloc] initWithFrame: CGRectMake(0, 0, 300, 200)];
        grid.backgroundColor = [UIColor clearColor];
        grid.graph = plot;
        
        plot.grid = grid;
        [plot setupPlotWithXAxisMin: 0.
                           xAxisMax: 30.
                         xMinorStep: 2
                         xMajorStep: 10.
                         xAxisLabel: nil
                  xAxisFormatString: nil
                           yAxisMin: 0.
                           yAxisMax: 20.
                         yMinorStep: 5.
                         yMajorStep: 10.
                         yAxisLabel: nil
                  yAxisFormatString: nil
                          gridColor: [UIColor grayColor]
                     gridFrameWidth: 1.
                      drawGridFrame: NO
                  fadeGridLineEdges: YES
                          lineColor: [UIColor whiteColor]
                      lineHeadColor: [UIColor blueColor]
                       andLineWidth: 1.];
        plot.plotRefreshRateInHz = 1;
        plot.samplingRateInHz = 1;
        plot.windowMaxSize = 60;
        plot.backgroundColor = [UIColor clearColor];
        
        plot.center = container.center;
        grid.center = container.center;
        [container addSubview: plot];
        [container addSubview: grid];
    });
    
    it(@"plot can present data", ^{
        NSArray *points = @[@2., @4., @6., @8., @10., @12., @14., @16., @18., @20., @18., @16., @14., @12., @10., @8., @6., @4., @2.];
        [plot plotData: points];
        expect(container).to.haveValidSnapshot();
    });
    
    it(@"plot and grid style can change", ^{
        NSArray *points = @[@2., @4., @6., @8., @10., @12., @14., @16., @18., @20., @18., @16., @14., @12., @10., @8., @6., @4., @2.];
        [plot plotData: points];
        plot.lineColor = [UIColor blueColor];
        plot.lineHeadColor = [UIColor yellowColor];
        plot.lineWidth = 5.;
        grid.frameColor = [UIColor orangeColor];
        grid.gridLineColor = [UIColor redColor];
        grid.frameLineWidth = 3.;
        grid.fadeGridLineEdges = NO;
        grid.drawsFrame = YES;
        expect(container).to.haveValidSnapshot();
    });
});

SpecEnd
