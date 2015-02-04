//
//  UHNYRealScale.m
//  Bant
//
//  Created by Mat Trudel on 09-10-05.
//  Copyright 2015 University Health Network. All rights reserved.
//

#import "UHNYRealScale.h"

@implementation UHNYRealScale
@synthesize min, max, minorStep, majorStep;
@synthesize units;
@synthesize formatString;
@synthesize tickColor;

- (void)drawRect:(CGRect)rect {
    if (!self.formatString) 
    {
        self.formatString = @"%f";
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
    
    NSString *text = nil;
    CGRect textbox;
    
    UIFont *font = [UIFont systemFontOfSize: [UIFont smallSystemFontSize]];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByClipping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{ NSFontAttributeName: font,
                                  NSParagraphStyleAttributeName: paragraphStyle };

    if (self.units)
    {
        text = self.units;
        textbox = CGRectMake(self.bounds.origin.x, [self screenValueForDomain: self.min] - [UIFont smallSystemFontSize], self.bounds.size.width, 0);
        [text drawInRect: textbox withAttributes: attributes];
    }
	
	for (float value = [self.min floatValue] + [self.majorStep floatValue]; value <= [self.max floatValue] - [self.majorStep floatValue]; value += [self.majorStep floatValue]) {	
        text = [NSString stringWithFormat: self.formatString, value];
		textbox = CGRectMake(self.bounds.origin.x, [self screenValueForDomain: [NSNumber numberWithFloat: value]] - [UIFont smallSystemFontSize]/2, self.bounds.size.width, 0);
        [text drawInRect: textbox withAttributes: attributes];
	}
    
	text = [NSString stringWithFormat: self.formatString, [self.max floatValue]];
	textbox = CGRectMake(self.bounds.origin.x, [self screenValueForDomain: self.max] - [UIFont smallSystemFontSize]/4, self.bounds.size.width, 0);
    [text drawInRect: textbox withAttributes: attributes];
	
	CGContextStrokePath(context);
    
    if (self.tickColor) 
    {
        CGContextSetStrokeColorWithColor(context, [self.tickColor CGColor]);
    }
    else
    {
        CGContextSetStrokeColorWithColor(context, [[UIColor colorWithWhite: 0.17 alpha: 1] CGColor]);
    }

	CGContextSetLineWidth(context, 2.0);
	for (CGFloat value = [self.min floatValue] + [self.minorStep floatValue]; value <= [self.max floatValue]; value += [self.minorStep floatValue]) {		
		CGFloat y = [self screenValueForDomain: [NSNumber numberWithFloat: value]];
		CGContextMoveToPoint(context, self.bounds.size.width , y);
		CGContextAddLineToPoint(context, self.bounds.size.width - 5, y);
	}
	CGContextStrokePath(context);
}

- (CGFloat)screenValueForDomain: (id)domainValue {
    return self.bounds.size.height - super.bounds.size.height * ([domainValue floatValue] - [self.min floatValue]) / ([self.max floatValue] - [self.min floatValue]);
}

- (id)domainValueForScreen: (CGFloat)screenValue {
	return [NSNumber numberWithFloat: [self.max floatValue] - ([self.max floatValue] - [self.min floatValue])*((screenValue - self.bounds.origin.y) / self.bounds.size.height)];	
}

- (id)valueByAdding: (id)delta to: (id)original {
	return [NSNumber numberWithFloat: [original floatValue] + [delta floatValue]];
}

- (NSComparisonResult)compare: (id)a to: (id)b {
	return [a compare: b];
}

@end
