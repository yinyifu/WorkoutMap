//
//  ifImageExist.m
//  applewatch_mapping
//
//  Created by IOS Design Coding on 11/5/17.
//  Copyright © 2017 CSE442_UB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES1/gl.h>
#import <UIKit/UIKit.h>
@interface imageExist : NSObject
- (BOOL) checkIfImage:(UIImage *)someImage;
@end
@implementation imageExist : NSObject


- (BOOL) checkIfImage:(UIImage *)someImage {
    CGImageRef image = someImage.CGImage;
    size_t width = CGImageGetWidth(image);
    size_t height = CGImageGetHeight(image);
    GLubyte * imageData = malloc(width * height * 4);
    int bytesPerPixel = 4;
    int bytesPerRow = bytesPerPixel * width;
    int bitsPerComponent = 8;
    CGContextRef imageContext =
    CGBitmapContextCreate(
                          imageData, width, height, bitsPerComponent, bytesPerRow, CGImageGetColorSpace(image),
                          kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big
                          );
    
    CGContextSetBlendMode(imageContext, kCGBlendModeCopy);
    CGContextDrawImage(imageContext, CGRectMake(0, 0, width, height), image);
    CGContextRelease(imageContext);
    
    int byteIndex = 0;
    
    BOOL imageExist = NO;
    for ( ; byteIndex < width*height*4; byteIndex += 4) {
        CGFloat red = ((GLubyte *)imageData)[byteIndex]/255.0f;
        CGFloat green = ((GLubyte *)imageData)[byteIndex + 1]/255.0f;
        CGFloat blue = ((GLubyte *)imageData)[byteIndex + 2]/255.0f;
        CGFloat alpha = ((GLubyte *)imageData)[byteIndex + 3]/255.0f;
        if( red != 1 || green != 1 || blue != 1 || alpha != 1 ){
            imageExist = YES;
            break;
        }
    }
    
    free(imageData);
    return imageExist;
}
@end
