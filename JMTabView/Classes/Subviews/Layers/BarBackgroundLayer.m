//  Created by Jason Morrissey

#import "BarBackgroundLayer.h"
#import "UIColor+Hex.h"

@implementation BarBackgroundLayer

-(id)init;
{
    //original default by JMTabView
    return [self initWithFrame:CGRectMake(0, 0, 1024, (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) ? 48 : 60)];
}

- (id)initWithFrame:(CGRect)frame {

    self = [super init];
    if (self)
    {
        CAGradientLayer * gradientLayer = [[CAGradientLayer alloc] init];
        UIColor * startColor = [UIColor colorWithHex:0x282928];
        UIColor * endColor = [UIColor colorWithHex:0x4a4b4a];
        gradientLayer.frame = frame;
        gradientLayer.colors = [NSArray arrayWithObjects:(__bridge id)[startColor CGColor], (__bridge id)[endColor CGColor], nil];
        [self insertSublayer:gradientLayer atIndex:0];    
    }
    return self;
}


@end
