/*
 *  UHNDomainPoint.h
 *  bant
 *
 *  Created by Mat Trudel on 09-11-02.
 *  Copyright 2015 University Health Network. All rights reserved.
 *
 */
#import <Foundation/Foundation.h>

@interface UHNDomainPoint : NSObject

@property(nonatomic,retain) id x;
@property(nonatomic,retain) id y;

+ (instancetype)pointWithX: (id)x andY: (id)y;

@end

