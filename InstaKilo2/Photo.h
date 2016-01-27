//
//  Photo.h
//  InstaKilo2
//
//  Created by Benson Huynh on 2016-01-27.
//  Copyright © 2016 Benson Huynh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Photo : NSObject

@property (nonatomic) UIImage *image;
@property (nonatomic) NSString *location;
@property (nonatomic) NSString *subject;

-(instancetype)initWithImage: (UIImage *) image location: (NSString *) location subject: (NSString *)subject;

@end
