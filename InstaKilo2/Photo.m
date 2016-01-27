//
//  Photo.m
//  InstaKilo2
//
//  Created by Benson Huynh on 2016-01-27.
//  Copyright © 2016 Benson Huynh. All rights reserved.
//

#import "Photo.h"

@implementation Photo

- (instancetype)initWithImage:(UIImage *)image location:(NSString *)location subject:(NSString *)subject {
    self = [super init];
    if (self) {
        _image = image;
        _location = location;
        _subject = subject;
    }
    return self;
}

@end
