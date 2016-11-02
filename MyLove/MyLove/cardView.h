//
//  cardView.h
//
//  Created by Neo on 16/10/27.
//  Copyright (c) 2016年  All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface cardView : UIImageView
@property(nonatomic)IBInspectable UIColor * bgColor;
@property(nonatomic)IBInspectable CGFloat cornerRadius;
@property(nonatomic)IBInspectable CGFloat buttonConnerRadius;
@property(nonatomic)IBInspectable UIColor * tapColor1;
@property(nonatomic)IBInspectable UIColor * tapColor2;
@property(nonatomic)IBInspectable CGSize circleSize;
@property(nonatomic)IBInspectable CGSize shadowSize;
-(void)config;
@end
