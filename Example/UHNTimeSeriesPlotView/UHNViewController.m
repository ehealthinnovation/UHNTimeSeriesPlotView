//
//  UHNViewController.m
//  UHNTimeSeriesPlotView
//
//  Created by Nathaniel Hamming on 02/04/2015.
//  Copyright (c) 2014 Nathaniel Hamming. All rights reserved.
//

#import "UHNViewController.h"
#import <UHNTimeSeriesPlotView/UHNScrollingTimeSeriesPlotView.h>

#define kDefaultStrokeWidth 1.

@interface UHNViewController ()
@property(nonatomic,strong) IBOutlet UHNScrollingTimeSeriesPlotView *plotView;
@property(nonatomic,strong) IBOutlet UISwitch *generateDataSwitch;
@property(nonatomic,strong) IBOutlet UISwitch *hidePlotSwitch;
@property(nonatomic,strong) IBOutlet UISlider *strokeWidthSlider;
@end

@implementation UHNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //setup the plot Scrolling Time Series Plot View
    [self.plotView setupPlotWithXAxisMin: 0.
                                xAxisMax: 30.
                              xMinorStep: 2
                              xMajorStep: 10.
                              xAxisLabel: nil
                       xAxisFormatString: nil
                                yAxisMin: 0.
                                yAxisMax: 200.
                              yMinorStep: 50.
                              yMajorStep: 100.
                              yAxisLabel: nil
                       yAxisFormatString: nil
                               gridColor: [UIColor grayColor]
                           gridFrameWidth: kDefaultStrokeWidth
                           drawGridFrame: YES
                       fadeGridLineEdges: YES
                               lineColor: [UIColor whiteColor]
                           lineHeadColor: [UIColor blueColor]
                            andLineWidth: kDefaultStrokeWidth];
    self.plotView.plotRefreshRateInHz = 1;
    self.plotView.samplingRateInHz = 1;
    self.plotView.windowMaxSize = 60;
    self.plotView.backgroundColor = [UIColor clearColor];
    
    [self.plotView generateRandomData: NO];
    
    [self.strokeWidthSlider setValue: self.plotView.lineWidth animated: YES];
}

#pragma mark - User Interface

- (IBAction)sliderDidChange:(id)sender
{
    if ([sender isKindOfClass: [UISlider class]]) {
        UISlider *slider = sender;
        self.plotView.lineWidth = slider.value;
    }
}

- (IBAction)switchDidChange:(id)sender
{
    if ([sender isKindOfClass: [UISwitch class]]) {
        UISwitch *switchCtrl = sender;
        if (switchCtrl == self.generateDataSwitch) {
            [self.plotView generateRandomData: switchCtrl.on];
        } else if (switchCtrl == self.hidePlotSwitch) {
            [self.plotView hidePlot: switchCtrl.on];
        }
    }
}

- (IBAction)resetButtonPressed:(id)sender
{
    [self.plotView generateRandomData:NO];
    [self.generateDataSwitch setOn: NO animated: YES];
    [self.plotView hidePlot: NO];
    [self.hidePlotSwitch setOn: NO animated: YES];
    self.plotView.lineWidth = kDefaultStrokeWidth;
    [self.strokeWidthSlider setValue: self.plotView.lineWidth animated: YES];
    [self.plotView removeAllDataPoints];
}

@end
