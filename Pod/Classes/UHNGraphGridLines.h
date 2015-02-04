//
//  UHNGraphGridLines.h
//  bant
//
//  Created by Mat Trudel on 10-03-10.
//  Copyright 2015 University Health Network. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UHNGraphView;

@interface UHNGraphGridLines : UIView

@property(nonatomic, assign) IBOutlet UHNGraphView *graph;
@property(nonatomic, assign) BOOL drawsFrame;
@property(nonatomic, assign) BOOL fadeGridLineEdges;
@property(nonatomic,retain) UIColor *frameColor;
@property(nonatomic) CGFloat frameLineWidth;
@property(nonatomic,retain) UIColor *gridLineColor;
@property(nonatomic) CGFloat xMinorScaleLineWidth;
@property(nonatomic) CGFloat xMajorScaleLineWidth;
@property(nonatomic) CGFloat yMinorScaleLineWidth;
@property(nonatomic) CGFloat yMajorScaleLineWidth;

@end
