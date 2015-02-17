# UHNTimeSeriesPlotView

## Description

Dynamic plot for real-time data collection. 

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

The UHNScrollingTimeSeriesPlotView can be included in IB or created programmatically. It is a subclass of the UHNGraphView, which in turn sublclassses UIView. The domainate class in this pod is `UHNScrollingTimeSeriesPlotView`, which is used to plot data collected in real-time.

```
  #import "UHNScrollingTimeSeriesPlotView.h"
  @property(nonatomic,strong) IBOutlet UHNScrollingTimeSeriesPlotView *plotView;

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
                          gridFrameWidth: 1.
                           drawGridFrame: YES
                       fadeGridLineEdges: YES
                               lineColor: [UIColor whiteColor]
                           lineHeadColor: [UIColor blueColor]
                            andLineWidth: 1.];
    self.plotView.plotRefreshRateInHz = 1.;
    self.plotView.samplingRateInHz = 1.;
    self.plotView.windowMaxSize = 60;
    self.plotView.backgroundColor = [UIColor clearColor];

    [self.plotView generateRandomData: YES];
```

## Installation

To install UHNTimeSeriesPlotView in another project, simply add the following line to your Podfile:

    pod "UHNTimeSeriesPlotView"
    
## Documentation

`appledoc` of the pod can be found at `./doc/html/index.html`

## Author

Nathaniel Hamming, nhamming@ehealthinnovation.org

## License

UHNTimeSeriesPlotView is available under the MIT license. See the LICENSE file for more info.

