//
//  TJButton.m
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/22.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import "TJButton.h"

@implementation TJButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self setExclusiveTouch:YES];
}



- (void)drawRect:(CGRect)rect
{
    if (self.underlineEnable)
    {
        // Get the Render Context
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        // Measure the font size, so the line fits the text.
        // Could be that "titleLabel" is something else in other classes like UILable, dont know.
        // So make sure you fix it here if you are enhancing UILabel or something else..
        
        CGSize fontSize = CGSizeZero;
        
        
        CGSize maximumLabelSize = self.bounds.size;
        
        NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine |
        NSStringDrawingUsesLineFragmentOrigin;
        
        NSDictionary * attributes = @{NSFontAttributeName:self.titleLabel.font};
        
        CGRect titleLabelBounds = [self.titleLabel.text boundingRectWithSize:maximumLabelSize
                                                                     options:options
                                                                  attributes:attributes
                                                                     context:nil];
        fontSize = titleLabelBounds.size;
        
        
        // Get the fonts color.
        const CGFloat * colors = CGColorGetComponents(self.titleLabel.textColor.CGColor);
        // Sets the color to draw the line
        CGContextSetRGBStrokeColor(ctx, colors[0], colors[1], colors[2], 1.0f); // Format : RGBA
        
        // Line Width : make thinner or bigger if you want
        CGContextSetLineWidth(ctx, 1.0f);
        
        // Calculate the starting point (left) and target (right)
        float fontLeft = floorf(self.titleLabel.center.x - fontSize.width / 2.0);
        float fontRight = floorf(self.titleLabel.center.x + fontSize.width / 2.0);
        
        // Add Move Command to point the draw cursor to the starting point
        CGContextMoveToPoint(ctx, fontLeft, self.bounds.size.height - 1);
        
        // Add Command to draw a Line
        CGContextAddLineToPoint(ctx, fontRight, self.bounds.size.height - 1);
        
        // Actually draw the line.
        CGContextStrokePath(ctx);
    }
    
    // should be nothing, but who knows...
    [super drawRect:rect];
}


- (void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    [self configureButton];
}

- (void)setNormalColor:(UIColor *)normalColor
{
    _normalColor = normalColor;
    [self configureButton];
}

- (void)setHighlightColor:(UIColor *)highlightColor
{
    _highlightColor = highlightColor;
    [self configureButton];
}


- (void)setDisabledColor:(UIColor *)disabledColor
{
    _disabledColor = disabledColor;
    [self configureButton];
}

- (void)setSelectedColor:(UIColor *)selectedColor
{
    _selectedColor = selectedColor;
    [self configureButton];
}


- (void)configureButton
{
    if (self.normalColor)
    {
        [self setBackgroundImage:[UIImage imageWithColor:self.normalColor cornerRadius:self.cornerRadius] forState:UIControlStateNormal];
    }
    
    if (self.highlightColor)
    {
        [self setBackgroundImage:[UIImage imageWithColor:self.highlightColor cornerRadius:self.cornerRadius] forState:UIControlStateHighlighted];
    }
    
    if (self.disabledColor)
    {
        [self setBackgroundImage:[UIImage imageWithColor:self.disabledColor cornerRadius:self.cornerRadius] forState:UIControlStateDisabled];
    }
    
    
    if (self.selectedColor)
    {
        [self setBackgroundImage:[UIImage imageWithColor:self.selectedColor cornerRadius:self.cornerRadius] forState:UIControlStateSelected];
    }
}
@end
