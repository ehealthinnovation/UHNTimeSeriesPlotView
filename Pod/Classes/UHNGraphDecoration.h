//
//  UHNGraphDecoration.h
//  bant
//
//  Created by Mat Trudel on 09-10-30.
//  Copyright 2015 University Health Network. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UHNGraphView;
@class UHNDomainPoint;

@interface UHNGraphDecoration : UIView

@property(nonatomic, strong) id context;
@property(nonatomic, strong) UHNDomainPoint *origin;
@property(nonatomic, strong) UHNDomainPoint *extent;
@property(nonatomic, assign) CGPoint offset;

- (void)layoutInGraph: (UHNGraphView *)graph;

@end
