//
//  UHNXRealScale.m
//  Bant
//
//  Created by Mat Trudel on 09-10-05.
//  Copyright 2015 University Health Network. All rights reserved.
//

#import "UHNXRealScale.h"

@implementation UHNXRealScale
@synthesize min, max, minorStep, majorStep;
@synthesize units;
@synthesize formatString;
@synthesize tickColor;

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);

	NSString *text = self.units;
	CGRect textbox = CGRectMake([self screenValueForDomain: self.min] + 3, 
								self.bounds.origin.y + self.bounds.size.height - [UIFont smallSystemFontSize] - 3,
								50, 0);
    UIFont *font = [UIFont systemFontOfSize: [UIFont smallSystemFontSize]];
    NSMutableParagraphStyle *paragraphStyleAlignLeft = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyleAlignLeft.lineBreakMode = NSLineBreakByClipping;
    paragraphStyleAlignLeft.alignment = NSTextAlignmentLeft;
    NSDictionary *attributesAlignLeft = @{ NSFontAttributeName: font,
                                           NSParagraphStyleAttributeName: paragraphStyleAlignLeft };

    [text drawInRect: textbox withAttributes: attributesAlignLeft];
	
	for (float value = [self.min floatValue] + [self.majorStep floatValue]; value <= [self.max floatValue] - [self.majorStep floatValue]; value += [self.majorStep floatValue]) {	
		text = [NSString stringWithFormat: self.formatString, value];
		textbox = CGRectMake([self screenValueForDomain: [NSNumber numberWithFloat: value]] - 25, 
									self.bounds.origin.y + self.bounds.size.height - [UIFont smallSystemFontSize] - 3,
									50, 0);
        NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        paragraphStyle.lineBreakMode = NSLineBreakByClipping;
        paragraphStyle.alignment = NSTextAlignmentCenter;
        NSDictionary *attributes = @{ NSFontAttributeName: font,
                                      NSParagraphStyleAttributeName: paragraphStyle };
        [text drawInRect: textbox withAttributes: attributes];
    }

	text = [NSString stringWithFormat: self.formatString, [self.max floatValue]];
	textbox = CGRectMake([self screenValueForDomain: self.max] - 53, 
						 self.bounds.origin.y + self.bounds.size.height - [UIFont smallSystemFontSize] - 3,
								50, 0);

    NSMutableParagraphStyle *paragraphStyleAlignRight = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyleAlignRight.lineBreakMode = NSLineBreakByClipping;
    paragraphStyleAlignRight.alignment = NSTextAlignmentRight;
    NSDictionary *attributesAlignRight = @{ NSFontAttributeName: font,
                                            NSParagraphStyleAttributeName: paragraphStyleAlignRight };
    [text drawInRect: textbox withAttributes: attributesAlignRight];
	
	CGContextStrokePath(context);

	CGContextSetStrokeColorWithColor(context, [[UIColor colorWithWhite: 0.17 alpha: 1] CGColor]);
	CGContextSetLineWidth(context, 2.0);
	for (CGFloat value = [self.min floatValue] + [self.minorStep floatValue]; value < [self.max floatValue]; value += [self.minorStep floatValue]) {		
		CGFloat x = [self screenValueForDomain: [NSNumber numberWithFloat: value]];
		CGContextMoveToPoint(context, x, self.bounds.origin.y + 1);
		CGContextAddLineToPoint(context, x, self.bounds.origin.y + 5);
	}
	CGContextStrokePath(context);
	
}

- (CGFloat)screenValueForDomain: (id)domainValue {
	return self.bounds.origin.x + super.bounds.size.width * ([domainValue floatValue] - [self.min floatValue]) / ([self.max floatValue] - [self.min floatValue]);
}

- (id)domainValueForScreen: (CGFloat)screenValue {
	return [NSNumber numberWithFloat: [self.min floatValue] + ([self.max floatValue] - [self.min floatValue])*((screenValue - self.bounds.origin.x) / self.bounds.size.width)];	
}


- (id)valueByAdding: (id)delta to: (id)original {
	return [NSNumber numberWithFloat: [original floatValue] + [delta floatValue]];
}

- (NSComparisonResult)compare: (id)a to: (id)b {
	return [a compare: b];
}

@end
