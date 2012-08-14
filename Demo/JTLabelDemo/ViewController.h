//
//  ViewController.h
//  JTLabelDemo
//
//  Created by Konstantin Sokolinskyi on 8/14/12.
//  Copyright (c) 2012 SROST studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, retain) IBOutlet UILabel *kerningLabel;
@property (nonatomic, retain) IBOutlet UILabel *shadowBlurLabel;

- (IBAction)useBlurredShadow:(id)sender;
- (IBAction)useColorShadow:(id)sender;
- (IBAction)noShadow:(id)sender;
- (IBAction)kerningSliderValueChanged:(id)sender;
- (IBAction)blurSliderValueChanged:(id)sender;

@end
