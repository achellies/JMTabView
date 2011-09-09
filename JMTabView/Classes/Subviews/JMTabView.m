//  Created by Jason Morrissey

#import "JMTabView.h"
#import "JMTabContainer.h"
#import "BarBackgroundLayer.h"
#import "UIView+Positioning.h"

@interface JMTabView()
@property (nonatomic,retain) JMTabContainer * tabContainer;
-(void)setup;
@end

@implementation JMTabView

@synthesize tabContainer = tabContainer_;
@synthesize delegate = delegate_;
@synthesize tabItemFont;

- (void)dealloc;
{
    self.delegate = nil;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [self setup];
}

- (void)setup {
  
    [self setBackgroundLayer:[[BarBackgroundLayer alloc] initWithFrame:self.layer.bounds]];
    self.backgroundColor = [UIColor clearColor];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.tabContainer = [[JMTabContainer alloc] initWithFrame:self.bounds];
    self.tabItemFont = kTabItemFont;
    [self addSubview:self.tabContainer];
}

- (void)setTabItemFont:(UIFont *)font {
    self.tabContainer.tabItemFont = font;
    [self setNeedsDisplay];
    [self setNeedsLayout];
}

-(UIFont*)tabItemFont {
    return self.tabContainer.tabItemFont;
}

- (void)setBackgroundLayer:(CALayer *)backgroundLayer;
{
    CALayer * oldBackground = [[self.layer sublayers] objectAtIndex:0];
    if (oldBackground)
    {
        [self.layer replaceSublayer:oldBackground with:backgroundLayer];
    }
    else
    {
        [self.layer insertSublayer:backgroundLayer atIndex:0];
    }
}

- (void)layoutSubviews;
{
    [self.tabContainer centerInSuperView];
    [self setBackgroundLayer:[[BarBackgroundLayer alloc] initWithFrame:self.layer.bounds]];
}

#pragma Mark -
#pragma Mark Notifying Delegates

- (void)didSelectItemAtIndex:(NSUInteger)itemIndex;
{
    if (self.delegate)
    {
        [self.delegate tabView:self didSelectTabAtIndex:itemIndex];
    }
}

#pragma Mark -
#pragma External Interface



- (void)setMomentary:(BOOL)momentary;
{
    [self.tabContainer setMomentary:momentary];
}

- (void)addTabItem:(JMTabItem *)tabItem;
{
    [self.tabContainer addTabItem:tabItem];
}

- (void)addTabItemWithTitle:(NSString *)title icon:(UIImage *)icon;
{
    JMTabItem * tabItem = [JMTabItem tabItemWithTitle:title icon:icon];
    [self addTabItem:tabItem];
}

#if NS_BLOCKS_AVAILABLE
- (void)addTabItemWithTitle:(NSString *)title icon:(UIImage *)icon executeBlock:(JMTabExecutionBlock)executeBlock;
{
    JMTabItem * tabItem = [JMTabItem tabItemWithTitle:title icon:icon executeBlock:executeBlock];
    [self addTabItem:tabItem];
}
#endif

- (void)setSelectedIndex:(NSUInteger)itemIndex;
{
    [self.tabContainer layoutSubviews];
    [self.tabContainer animateSelectionToItemAtIndex:itemIndex];
}

#pragma Mark -
#pragma Customisation

- (void)setSelectionView:(JMSelectionView *)selectionView;
{
    [[self.tabContainer selectionView] removeFromSuperview];
    [self.tabContainer setSelectionView:selectionView];
    [self.tabContainer insertSubview:selectionView atIndex:0];
}

- (void)setItemSpacing:(CGFloat)itemSpacing;
{
    [self.tabContainer setItemSpacing:itemSpacing];
    [self.tabContainer setNeedsLayout];
}

@end
