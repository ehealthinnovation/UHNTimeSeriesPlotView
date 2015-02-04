//
//  UHNGraphScaleDataSource.h
//  bant
//
//  Created by Mat Trudel on 09-10-28.
//  Copyright 2015 University Health Network. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UHNGraphScaleDataSource

@property(nonatomic, strong) id min;
@property(nonatomic, strong) id max;
@property(nonatomic, strong) id minorStep;
@property(nonatomic, strong) id majorStep;
@property(nonatomic, strong) id units;
@property(nonatomic, strong) id formatString;
@property(nonatomic, strong) id tickColor;

- (CGFloat)screenValueForDomain: (id)value;
- (id)domainValueForScreen: (CGFloat)value;

- (id)valueByAdding: (id)delta to: (id)original;
- (NSComparisonResult)compare: (id)a to: (id)b;

@end
