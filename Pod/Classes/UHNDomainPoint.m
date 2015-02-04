/*
 *  UHNDomainPoint.c
 *  bant
 *
 *  Created by Mat Trudel on 09-11-02.
 *  Copyright 2015 University Health Network. All rights reserved.
 *
 */

#import "UHNDomainPoint.h"

@implementation UHNDomainPoint

+ (instancetype)pointWithX: (id)x andY: (id)y {
	UHNDomainPoint *result = [[[self class] alloc] init];
	result.x = x;
	result.y = y;
	return result;
}

@end