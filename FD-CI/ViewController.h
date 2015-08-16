//
//  ViewController.h
//  FD-CI
//
//  Created by Nguyet Le on 7/7/15.
//  Copyright (c) 2015 Nguyet Le. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "fD_CI.h"

@interface ViewController : UIViewController {
    UIImageView *imageVm;
    UIImage *realsizeimgm;
   // float xRatio, yRatio;
   // fD_CI *ku;
}

@property(nonatomic,retain) fD_CI *ku;

@end

