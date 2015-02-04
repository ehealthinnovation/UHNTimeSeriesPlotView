//
//  UHNGraphView.m
//  bant
//
//  Created by Mat Trudel on 09-10-28.
//  Copyright 2015 University Health Network. All rights reserved.
//

#import "UHNGraphView.h"
#import "UHNGraphDecoration.h"

@implementation UHNGraphView

# pragma mark - Memory routines

- (id)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super initWithCoder: aDecoder]) {
		self.decorations = [NSMutableArray array];
        self.updateGridWithPlot = YES;
	}
	return self;
}

#pragma mark - Subview routines

- (void)layoutSubviews {
	[super layoutSubviews];
	for (UHNGraphDecoration *decoration in self.decorations) {
		[decoration layoutInGraph: self];
		[self sendSubviewToBack: decoration];
	}
}

#pragma mark - Decoration Management routines

- (void)addDecoration: (UHNGraphDecoration*)decoration {
	[self addSubview: decoration];
	[decoration layoutInGraph: self];
	[self.decorations addObject: decoration];
}

- (void)removeAllDecorationsOfClass:(Class)aClass {
	for (UIView *subview in [self subviews]) {
		if ([subview isKindOfClass:aClass]) {
			[subview removeFromSuperview]; 
		}
	}	
}

@end
