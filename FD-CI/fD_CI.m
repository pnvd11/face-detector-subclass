//
//  fD_CI.m
//  FD-CI
//
//  Created by Nguyet Le & Di Phan on 8/16/15.
//  Copyright (c) 2015 Nguyet Le & Di Phan. All rights reserved.
// ref:  Created by Johann Dowa on 11-11-01.
//  Copyright (c) 2011 ManiacDev.Com All rights reserved.
//
//  "Monster Face" Image by Tobyotter on Flickr

#import "fD_CI.h"

@implementation fD_CI




-(void)markFaces:(UIImageView *)facePicture xRatio:(float)xRatio yRatio:(float)yRatio imgV4trsl:(UIImageView *)imgV4trsl
{
    // draw a CIImage with the previously loaded face detection picture
    CIImage* image = [CIImage imageWithCGImage:facePicture.image.CGImage];
    
    // create a face detector - since speed is not an issue we'll use a high accuracy
    // detector
    
    CIContext *cntxt = [CIContext contextWithOptions:nil];
    NSDictionary *opts = @{CIDetectorAccuracy: CIDetectorAccuracyHigh};
    //CIDetector* detector = [CIDetector detectorOfType:CIDetectorTypeFace
    //                                          context:cntxt options:[NSDictionary dictionaryWithObject:CIDetectorAccuracyHigh forKey:CIDetectorAccuracy]];
    CIDetector* detector = [CIDetector detectorOfType:CIDetectorTypeFace
                                              context:cntxt options:opts];
    
    // create an array containing all the detected faces from the detector
    //opts = @{ CIDetectorImageOrientation : [[image properties] valueForKey: kCGImageAlphaFirst]};
    NSArray* features = [detector featuresInImage:image];
    //NSArray *features= [detector featuresInImage:image options:opts];
    
    // we'll iterate through every detected face.  CIFaceFeature provides us
    // with the width for the entire face, and the coordinates of each eye
    // and the mouth if detected.  Also provided are BOOL's for the eye's and
    // mouth so we can check if they already exist.
    for(CIFaceFeature* faceFeature in features)
    {
        // get the width of the face
        CGFloat faceWidth = faceFeature.bounds.size.width;
        
        // create a UIView using the bounds of the face
        UIView* faceView = [[UIView alloc] initWithFrame:faceFeature.bounds];
        
        // add a border around the newly created UIView
        faceView.layer.borderWidth = 1;
        faceView.layer.borderColor = [[UIColor blueColor] CGColor];
        
        //150815
        //[faceView setTransform:CGAffineTransformMakeScale(xRatio, yRatio)]; //150815
        //[faceView setTransform:CGAffineTransformMakeTranslation(imageVm.center.x, imageVm.center.y)];
        //[faceView setTransform:CGAffineTransformMakeTranslation(xRatio*imageVm.center.x, yRatio*imageVm.center.y)];
        //faceView setTransform:CGAffineTransformMakeTranslation(imageVm.center.x-imageVm.frame.size.width/2, imageVm.center.y-imageVm.frame.size.height/2)];
        faceView.center = CGPointMake(xRatio*faceView.center.x, yRatio*faceView.center.y);
        CGAffineTransform scl = CGAffineTransformMakeScale(xRatio, yRatio);
        CGAffineTransform trnsltn = CGAffineTransformMakeTranslation(imgV4trsl.center.x-imgV4trsl.frame.size.width/2, imgV4trsl.center.y-imgV4trsl.frame.size.height/2);
        [faceView setTransform:CGAffineTransformConcat(scl, trnsltn)];
        
        
        
        
        // add the new view to create a box around the face
        [self addSubview:faceView];
        //[imageV addSubview:faceView];
        //NSLog(@"ratio: %f ----%f",(faceWidth/self.view.bounds.size.width),(faceFeature.bounds.size.height/self.view.bounds.size.height ));
        // NSLog(@"ratio: %f ----%f",(imageV.bounds.size.height/self.view.bounds.size.height ));
        //150815
        //UIImage *realsizeimg = [UIImage imageNamed:@"shapeimage_3.png"];
        //NSLog(@"realsizeimage:%f----%f",realsizeimg.size.width,realsizeimg.size.height);
        //float xRatio = imageV.frame.size.width/realsizeimg.size.width;
        //float yRatio = imageV.frame.size.height/realsizeimg.size.height;
        
        if(faceFeature.hasLeftEyePosition)
        {
            // create a UIView with a size based on the width of the face
            UIView* leftEyeView = [[UIView alloc] initWithFrame:CGRectMake(faceFeature.leftEyePosition.x-faceWidth*0.15, faceFeature.leftEyePosition.y-faceWidth*0.15, faceWidth*0.3, faceWidth*0.3)];
            // change the background color of the eye view
            [leftEyeView setBackgroundColor:[[UIColor yellowColor] colorWithAlphaComponent:0.5]];
            // set the position of the leftEyeView based on the face
            [leftEyeView setCenter:faceFeature.leftEyePosition];
            // round the corners
            leftEyeView.layer.cornerRadius = faceWidth*0.15;
            leftEyeView.center = CGPointMake(xRatio*leftEyeView.center.x, yRatio*leftEyeView.center.y);
            // add the view to the window
            //150815
            CGAffineTransform scl = CGAffineTransformMakeScale(xRatio, yRatio);
            CGAffineTransform trnsltn = CGAffineTransformMakeTranslation(imgV4trsl.center.x-imgV4trsl.frame.size.width/2, imgV4trsl.center.y-imgV4trsl.frame.size.height/2);
            [leftEyeView setTransform:CGAffineTransformConcat(scl, trnsltn)];
            //[leftEyeView setTransform:CGAffineTransformMakeScale(xRatio, yRatio)]; //150815
            //[leftEyeView setTransform:CGAffineTransformMakeTranslation(imageVm.center.x, imageVm.center.y)];
            //[leftEyeView setTransform:CGAffineTransformMakeTranslation(imageVm.center.x-imageVm.frame.size.width/2, imageVm.center.y-imageVm.frame.size.height/2)];
            //[leftEyeView setTransform:CGAffineTransformMakeTranslation(xRatio, yRatio)]; //150815
            
            //[imageV addSubview:leftEyeView];
            [self addSubview:leftEyeView];
            
            //[leftEyeView setTransform:CGAffineTransformMakeScale(1, -1)]; //150815
            
            
        }
        
        if(faceFeature.hasRightEyePosition)
        {
            // create a UIView with a size based on the width of the face
            UIView* r8eye = [[UIView alloc] initWithFrame:CGRectMake(faceFeature.rightEyePosition.x-faceWidth*0.15, faceFeature.rightEyePosition.y-faceWidth*0.15, faceWidth*0.3, faceWidth*0.3)];
            // change the background color of the eye view
            [r8eye setBackgroundColor:[[UIColor orangeColor] colorWithAlphaComponent:0.5]];
            // set the position of the rightEyeView based on the face
            [r8eye setCenter:faceFeature.rightEyePosition];
            // round the corners
            r8eye.layer.cornerRadius = faceWidth*0.15;
            // add the new view to the window
            //150815
            // [leftEye setTransform:CGAffineTransformMakeScale(xRatio, yRatio)]; //150815
            //[leftEye setTransform:CGAffineTransformMakeTranslation(imageVm.center.x, imageVm.center.y)];
            // [leftEye setTransform:CGAffineTransformMakeTranslation(imageVm.center.x-imageVm.frame.size.width/2, imageVm.center.y-imageVm.frame.size.height/2)];
            r8eye.center = CGPointMake(xRatio*r8eye.center.x, yRatio*r8eye.center.y);
            CGAffineTransform scl = CGAffineTransformMakeScale(xRatio, yRatio);
            CGAffineTransform trnsltn = CGAffineTransformMakeTranslation(imgV4trsl.center.x-imgV4trsl.frame.size.width/2, imgV4trsl.center.y-imgV4trsl.frame.size.height/2);
            [r8eye setTransform:CGAffineTransformConcat(scl, trnsltn)];
            
            [self addSubview:r8eye];
        }
        
        if(faceFeature.hasMouthPosition)
        {
            // create a UIView with a size based on the width of the face
            UIView* mouth = [[UIView alloc] initWithFrame:CGRectMake(faceFeature.mouthPosition.x-faceWidth*0.2, faceFeature.mouthPosition.y-faceWidth*0.2, faceWidth*0.4, faceWidth*0.4)];
            // change the background color for the mouth to green
            [mouth setBackgroundColor:[[UIColor purpleColor] colorWithAlphaComponent:0.5]];
            // set the position of the mouthView based on the face
            [mouth setCenter:faceFeature.mouthPosition];
            // round the corners
            mouth.layer.cornerRadius = faceWidth*0.2;
            // add the new view to the window
            //150815
            //[mouth setTransform:CGAffineTransformMakeScale(xRatio, yRatio)]; //150815
            //[mouth setTransform:CGAffineTransformMakeTranslation(imageVm.center.x, imageVm.center.y)];
            //[mouth setTransform:CGAffineTransformMakeTranslation(imageVm.center.x-imageVm.frame.size.width/2, imageVm.center.y-imageVm.frame.size.height/2)];
            mouth.center = CGPointMake(xRatio*mouth.center.x, yRatio*mouth.center.y);
            CGAffineTransform scl = CGAffineTransformMakeScale(xRatio, yRatio);
            CGAffineTransform trnsltn = CGAffineTransformMakeTranslation(imgV4trsl.center.x-imgV4trsl.frame.size.width/2, imgV4trsl.center.y-imgV4trsl.frame.size.height/2);
            [mouth setTransform:CGAffineTransformConcat(scl, trnsltn)];
            
            
            [self addSubview:mouth];
        }
    }
}

-(void)faceDetector:(UIImageView *)imageV realSizeImage:(UIImage *)realsizeimg
{
    // Load the picture for face detection
    //UIImageView* image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"facedetectionpic.jpg"]];
    //UIImageView* image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"B'galla Mask.gif"]];
    //UIImageView* image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shapeimage_3.png"]];
    //UIImageView* image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"karlie-kloss-3d-printing-3.jpg"]];
    //UIImageView* image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Vanessa Hudgens.jpg"]];
    //UIImageView* image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Brit Vogue.jpg"]];
    //UIImageView* image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Claire Pettitbone.jpg"]];
    //UIImageView* imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    
    NSLog(@"realsizeimage:%f----%f",realsizeimg.size.width,realsizeimg.size.height);
    float xRatio = imageV.frame.size.width/realsizeimg.size.width;
    float yRatio = imageV.frame.size.height/realsizeimg.size.height;
    
    
    
    // Draw the face detection image
    [self addSubview:imageV];
    
    // Execute the method used to markFaces in background
    //[self performSelectorInBackground:@selector(markFaces:) withObject:imageV];
    //150815
    [self markFaces:imageV xRatio:xRatio yRatio:yRatio imgV4trsl:imageV];
    
    // flip image on y-axis to match coordinate system used by core image
    [imageV setTransform:CGAffineTransformMakeScale(1, -1)];
    
    // flip the entire window to make everything right side up
    [self setTransform:CGAffineTransformMakeScale(1, -1)];
    
    
}

@end
