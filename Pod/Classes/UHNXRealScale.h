//
//  UHNXRealScale.h
//  Bant
//
//  Created by Mat Trudel on 09-10-05.
//  Copyright 2015 University Health Network. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UHNGraphScaleDataSource.h"

@interface UHNXRealScale : UIView <UHNGraphScaleDataSource>

@property(nonatomic,retain) NSString *units;
@property(nonatomic,retain) NSString *formatString;
@property(nonatomic,retain) UIColor *tickColor;

@end
