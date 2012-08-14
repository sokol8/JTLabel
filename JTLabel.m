//
//  JTLabel.m
//
//  Created by Konstantin Sokolinskyi on 8/14/12.
//  Copyright 2011 SROST studio. 
//
//  License: This project is in the public domain.

#import "JTLabel.h"

#if __has_feature(objc_arc)
    #define JT_AUTORELEASE(exp) exp
    #define JT_RELEASE(exp)
    #define JT_RETAIN(exp) exp
#else
    #define JT_AUTORELEASE(exp) [exp autorelease]
    #define JT_RELEASE(exp) [exp release]
    #define JT_RETAIN(exp) [exp retain]
#endif



@implementation JTLabel

@synthesize font = m_font;
@synthesize textColor = m_textColor;
@synthesize text = m_text;
@synthesize kerning = m_kerning;
@synthesize shadowColor = m_shadowColor;
@synthesize shadowOffset = m_shadowOffset;
@synthesize useBlurredShadow = m_useBlurredShadow;
@synthesize shadowBlur = m_shadowBlur;


- (id)initWithFrame: (CGRect)frame
{
    self = [super initWithFrame: frame];
    if (self)
	{
		self.backgroundColor = [UIColor whiteColor];
		self.font = [UIFont systemFontOfSize: 14];
		self.textColor = [UIColor blackColor];
		self.text = @"JTLabel";
		self.kerning = 0;
		self.shadowColor = [UIColor clearColor];
		self.shadowOffset = CGSizeZero;
        self.useBlurredShadow = NO;
        self.shadowBlur = 0.0;
    }
    return self;
}


- (void)drawRect: (CGRect)rect
{	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	[self drawRect: rect inContext: context];
}


- (void)drawRect: (CGRect)rect inContext: (CGContextRef)context
{
	if ( nil == context )
	{
		NSLog( @"[ERROR]nil CG context provided" );
		return;
	}
	
    CGContextSetShouldSmoothFonts(context, YES);
    
	// setting text font properties
    CGContextSelectFont(context, [self.font.fontName cStringUsingEncoding: NSUTF8StringEncoding], self.font.pointSize, kCGEncodingMacRoman);
	
	// seting kerning - letter spacing. Why we need all this plays with
    CGContextSetCharacterSpacing(context, self.kerning);
	
	// setting text shadow
	CGContextSetShadowWithColor(context, self.shadowOffset, 0, self.shadowColor.CGColor);
    
    if ( self.useBlurredShadow ) {
        CGContextSetShadow(context, self.shadowOffset, self.shadowBlur);
    }
	
	// setting text drawing (filling) color
	[self.textColor setFill];
	CGContextSetTextDrawingMode(context, kCGTextFill);
	
	// transofoming coordinate system to draw text in UIKit coordinates
    CGAffineTransform xform = CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, 0.0);
    CGContextSetTextMatrix(context, xform);
	
    char *text = malloc([self.text length] + 1);
    sprintf(text, "%s", [self.text cStringUsingEncoding: NSUTF8StringEncoding]);
	
	CGContextShowTextAtPoint(context,
							 rect.origin.x,
							 rect.origin.y + self.font.pointSize,
							 text,
							 [self.text length]);
	
	free(text);
}


- (void)dealloc
{
#if !__has_feature(objc_arc)
	self.font = nil;
	self.textColor = nil;
	self.text = nil;
	self.shadowColor = nil;
	
    [super dealloc];
#endif
}


#pragma mark @property ( nonatomic, retain ) NSString *text;

- (void)setText: (NSString*)aText
{
	if (aText != m_text)
	{
        JT_RELEASE(m_text);
		m_text = [aText copy];
        [self setNeedsDisplay];
	}
}


#pragma mark @property (nonatomic, retain) UIFont *font;

- (void)setFont:(UIFont *)font
{
    if ( font != m_font ) {
        JT_RELEASE(m_font);
        m_font = JT_RETAIN(font);
        [self setNeedsDisplay];
    }
}


#pragma mark @property (nonatomic, retain) UIColor *textColor;

- (void)setTextColor:(UIColor *)textColor
{
    if ( textColor != m_textColor ) {
        JT_RELEASE(m_textColor);
        m_textColor = JT_RETAIN(textColor);
        [self setNeedsDisplay];
    }
}

#pragma mark @property (nonatomic, retain) UIColor *shadowColor;

- (void)setShadowColor:(UIColor *)shadowColor
{
    if ( shadowColor != m_shadowColor ) {
        JT_RELEASE(m_shadowColor);
        m_shadowColor = JT_RETAIN(shadowColor);
        [self setNeedsDisplay];
    }
}

#pragma mark @property (nonatomic, assign) CGSize shadowOffset;

- (void)setShadowOffset:(CGSize)shadowOffset
{
    if ( !CGSizeEqualToSize(m_shadowOffset, shadowOffset) ) {
        m_shadowOffset = shadowOffset;
        [self setNeedsDisplay];
    }
}

#pragma mark @property (nonatomic, assign) NSInteger kerning;

- (void)setKerning:(NSInteger)kerning
{
    if ( kerning != m_kerning ) {
        m_kerning = kerning;
        [self setNeedsDisplay];
    }
}

#pragma mark @property (nonatomic, assign) BOOL useBlurredShadow; //Shadow color RGBA = {0, 0, 0, 1.0/3.0}

- (void)setUseBlurredShadow:(BOOL)useBlurredShadow
{
    if ( useBlurredShadow != m_useBlurredShadow ) {
        m_useBlurredShadow = useBlurredShadow;
        [self setNeedsDisplay];
    }
}

#pragma mark @property (nonatomic, assign) CGFloat shadowBlur;

- (void)setShadowBlur:(CGFloat)shadowBlur
{
    if ( shadowBlur != m_shadowBlur ) {
        m_shadowBlur = shadowBlur;
        [self setNeedsDisplay];
    }
}


@end
