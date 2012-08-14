//
//  ViewController.m
//  JTLabelDemo
//
//  Created by Konstantin Sokolinskyi on 8/14/12.
//  Copyright (c) 2012 SROST studio. All rights reserved.
//

#import "ViewController.h"
#import "JTLabel.h"

@interface ViewController ()

@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) JTLabel *jtLabel;

@end

@implementation ViewController

@synthesize label = _label;
@synthesize jtLabel = _jtLabel;
@synthesize kerningLabel = _kerningLabel;
@synthesize shadowBlurLabel = _shadowBlurLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.jtLabel = [[JTLabel alloc] initWithFrame: CGRectMake(60, 100, 200, 24)];
    self.jtLabel.font = [UIFont systemFontOfSize: 20];
    self.jtLabel.textColor = [UIColor blueColor];
    self.jtLabel.shadowColor = [UIColor redColor];
    self.jtLabel.shadowOffset = CGSizeMake(0, 1);
    self.jtLabel.kerning = 3;
    self.jtLabel.shadowBlur = 1.0;
    self.jtLabel.useBlurredShadow = NO;
    
    self.kerningLabel.text = @"1.0";
    
    [self.view addSubview: self.jtLabel];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Actions

- (IBAction)useBlurredShadow:(id)sender
{
    self.jtLabel.text = [NSString stringWithFormat: @"%@ 1", self.jtLabel.text];
    self.jtLabel.useBlurredShadow = YES;
    self.jtLabel.shadowOffset = CGSizeMake(0, 2);
}


- (IBAction)useColorShadow:(id)sender
{
    self.jtLabel.useBlurredShadow = NO;
    self.jtLabel.shadowColor = [UIColor redColor];
    self.jtLabel.shadowOffset = CGSizeMake(0, 1);
}


- (IBAction)noShadow:(id)sender
{
    self.jtLabel.useBlurredShadow = NO;
    self.jtLabel.shadowColor = [UIColor clearColor];
}


- (IBAction)kerningSliderValueChanged:(id)sender
{
    UISlider *slider = sender;
    self.jtLabel.kerning = slider.value;
    self.kerningLabel.text = [NSString stringWithFormat: @"%.2f", slider.value];
}

- (IBAction)blurSliderValueChanged:(id)sender
{
    UISlider *slider = sender;
    self.jtLabel.shadowBlur = slider.value;
    self.shadowBlurLabel.text = [NSString stringWithFormat: @"%.2f", slider.value];
}


@end
