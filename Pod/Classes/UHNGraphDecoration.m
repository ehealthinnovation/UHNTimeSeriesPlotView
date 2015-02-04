//
//  UHNGraphDecoration.m
//  bant
//
//  Created by Mat Trudel on 09-10-30.
//  Copyright 2015 University Health Network. All rights reserved.
//

#import "UHNGraphDecoration.h"
#import "UHNGraphView.h"
#import "UHNGraphScaleDataSource.h"
#import "UHNDomainPoint.h"
#import "UHNXRealScale.h"
#import "UHNYRealScale.h"

@implementation UHNGraphDecoration

- (void)layoutInGraph:(UHNGraphView *)graph {
	CGPoint screenOrigin = CGPointMake(((self.origin.x)? [graph.xScale screenValueForDomain: self.origin.x] : self.superview.bounds.origin.x) + self.offset.x,
									   ((self.origin.y)? [graph.yScale screenValueForDomain: self.origin.y] : self.superview.bounds.origin.y) + self.offset.y);
	self.frame = CGRectMake(screenOrigin.x, screenOrigin.y,
								MAX(1, (self.extent.x)? [graph.xScale screenValueForDomain: self.extent.x]  - screenOrigin.x : self.superview.bounds.size.width),
								MAX(1, (self.extent.y)? [graph.yScale screenValueForDomain: self.extent.y]  - screenOrigin.y : self.superview.bounds.size.height));	
}

@end
