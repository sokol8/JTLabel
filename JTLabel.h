//
//  JTLabel.h
//
//  Created by Konstantin Sokolinskyi on 8/14/12.
//  Copyright 2012 SROST studio. 
//
// License: This project is in the public domain.

#import <UIKit/UIKit.h>

#ifndef JT_STRONG
#if __has_feature(objc_arc)
    #define JT_STRONG strong
#else
    #define JT_STRONG retain
#endif
#endif


@interface JTLabel : UIView
{
	UIFont		*m_font;
	UIColor		*m_textColor;
	NSString	*m_text;
	UIColor		*m_shadowColor;
	CGSize		m_shadowOffset;
	NSInteger	m_kerning;
    
    CGFloat     m_shadowBlur;
    BOOL        m_useBlurredShadow;
}

@property (nonatomic, copy) NSString *text;

@property (nonatomic, JT_STRONG) UIFont *font;
@property (nonatomic, JT_STRONG) UIColor *textColor;

@property (nonatomic, JT_STRONG) UIColor *shadowColor;
@property (nonatomic, assign) CGSize shadowOffset;

@property (nonatomic, assign) NSInteger kerning;

@property (nonatomic, assign) BOOL useBlurredShadow; //Shadow color RGBA = {0, 0, 0, 1.0/3.0}
@property (nonatomic, assign) CGFloat shadowBlur;

@end
