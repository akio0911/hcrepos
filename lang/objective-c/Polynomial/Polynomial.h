//
//  Polynomial.h
//  Polynomial
//
//  Created by akio0911 on 09/01/21.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Polynomial : NSObject {
	__strong CGFloat *terms;
	int termCount;
	__strong CGColorRef color;
}

-(float)valueAt:(float)x;
-(void)drawInRect:(CGRect)b
		inContext:(CGContextRef)ctx;
-(CGColorRef)color;

@end
