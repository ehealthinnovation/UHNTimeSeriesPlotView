//
//  UHNGraphView.h
//  bant
//
//  Created by Mat Trudel on 09-10-28.
//  Copyright 2015 University Health Network. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UHNGraphScaleDataSource;
@class UHNGraphDecoration;
@class UHNGraphGridLines;
@class UHNXRealScale;
@class UHNYRealScale;

@interface UHNGraphView : UIView

@property(nonatomic,strong) IBOutlet UHNXRealScale *xScale;
@property(nonatomic,strong) IBOutlet UHNYRealScale *yScale;
@property(nonatomic,strong) IBOutlet UHNGraphGridLines *grid;
@property(nonatomic,strong) NSMutableArray *decorations;
@property(nonatomic,assign) BOOL updateGridWithPlot;

- (void)addDecoration: (UHNGraphDecoration*)decoration;
- (void)removeAllDecorationsOfClass:(Class)aClass;

@end
