//
//  CAShapeLayer+AnimateText.h
//  BetterRefresh
//
//  Created by Hony on 2016/10/18.
//  Copyright © 2016年 Hony. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CAShapeLayer (AnimateText)

/**
 CAShapeLayer
 
 @param text 文字

 @return CAShapeLayer
 */
+(CAShapeLayer *)shapeLayerWithText:(NSString *)text fontSize:(CGFloat)fontSize;

@end
