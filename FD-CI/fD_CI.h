//
//  fD_CI.h
//  FD-CI
//
//  Created by Nguyet Le on 8/16/15.
//  Copyright (c) 2015 Nguyet Le. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface fD_CI : UIView

-(void)markFaces:(UIImageView *)facePicture xRatio:(float)xRatio yRatio:(float)yRatio imgV4trsl:(UIImageView *)imgV4trsl;
-(void)faceDetector:(UIImageView *)imageV realSizeImage:(UIImage *)realsizeimg;
@end
