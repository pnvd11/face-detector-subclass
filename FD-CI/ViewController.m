//
//  ViewController.m
//  FD-CI
//
//  Created by Nguyet Le on 7/7/15.
//  Copyright (c) 2015 Nguyet Le. All rights reserved.
// no rotate.

//FaceDetectionExample
//
//  Created by Johann Dowa on 11-11-01.
//  Copyright (c) 2011 ManiacDev.Com All rights reserved.
//
//  "Monster Face" Image by Tobyotter on Flickr

#import <CoreImage/CoreImage.h>
#import <QuartzCore/QuartzCore.h>

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize ku=_ku;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    imageVm = [[UIImageView alloc] initWithFrame:CGRectMake(30, 180, 320, 300)];
    
    imageVm.image = [UIImage imageNamed:@"shapeimage_3.png"];
    realsizeimgm = [UIImage imageNamed:@"shapeimage_3.png"];
    
     _ku = [[fD_CI alloc] initWithFrame:self.view.frame] ;
    [_ku faceDetector:imageVm realSizeImage:realsizeimgm];
    [self.view addSubview:_ku];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
