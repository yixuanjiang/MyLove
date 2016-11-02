//
//  cardView.h
//
//  Created by Neo on 16/10/27.
//  Copyright (c) 2016年  All rights reserved.
//

#import "cardView.h"

#import <POP.h>
@interface cardView()
@property (weak, nonatomic) IBOutlet UIButton *tapButton;

@end

@implementation cardView

-(void)awakeFromNib
{

}

-(void)prepareForInterfaceBuilder
{
    [self config];
}
-(void)config{
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.layer.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(self.cornerRadius, self.cornerRadius)].CGPath;
    self.layer.mask = maskLayer;
    [self setBackgroundColor:self.bgColor];

    self.tapButton.layer.cornerRadius = self.buttonConnerRadius;
    self.tapButton.layer.masksToBounds = YES;
 
    [self.tapButton updateConstraints];
    [self layoutIfNeeded];

}

- (IBAction)tapClick:(UIButton *)sender {

    NSLog(@"%zd",self.tag);

}

@end
