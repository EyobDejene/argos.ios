//
//  ARFullPageCollectionViewCell.m
//  Argos
//
//  Created by Francis Tseng on 2/24/14.
//  Copyright (c) 2014 Argos. All rights reserved.
//

#import "ARFullPageCollectionViewCell.h"
#import "ARCircleButton.h"
#import <QuartzCore/QuartzCore.h>

@implementation ARFullPageCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        float xPadding = 10;
        float yPadding = 20;
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.imageView.image = [UIImage imageNamed:@"placeholder"];
        [self addSubview:self.imageView];
        
        // Text gradient (so the text is readable)
        UIView *textGradientView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        CAGradientLayer *textGradient = [CAGradientLayer layer];
        textGradient.frame = textGradientView.bounds;
        textGradient.colors = [NSArray arrayWithObjects:(id)[[UIColor clearColor] CGColor], (id)[[UIColor blackColor] CGColor], nil];
        [textGradientView.layer insertSublayer:textGradient atIndex:0];
        textGradientView.alpha = 0.7;
        [self addSubview:textGradientView];
        
        float textLabelHeight = 120;
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPadding, self.frame.size.height - textLabelHeight - yPadding, self.frame.size.width - 2*xPadding, textLabelHeight)];
        self.textLabel.numberOfLines = 10;
        self.textLabel.font = [UIFont mediumFontForSize:14];
        self.textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.textLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.textLabel];
        
        
        float titleLabelHeight = 40;
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPadding, self.textLabel.frame.origin.y - titleLabelHeight - yPadding, self.frame.size.width - 2*xPadding, titleLabelHeight)];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont titleFontForSize:20];
        self.titleLabel.numberOfLines = 2;
        self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self addSubview:self.titleLabel];
        
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPadding, self.titleLabel.frame.origin.y + titleLabelHeight, self.frame.size.width - 2*xPadding, 20)];
        self.timeLabel.textColor = [UIColor mutedColor];
        self.timeLabel.font = [UIFont mediumFontForSize:10];
        [self addSubview:self.timeLabel];
    }
    return self;
}

- (void)setImageForEntity:(id<AREntity>)entity
{
    id <AREntityWithFullImage> entityWithFullImage = (id<AREntityWithFullImage>)entity;
    if (!entityWithFullImage.imageFull) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            UIImage *croppedImage = [self cropImage:entity.image];
            entityWithFullImage.imageFull = croppedImage;
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imageView.image = entityWithFullImage.imageFull;
            });
        });
    } else {
        self.imageView.image = entityWithFullImage.imageFull;
    }
}

@end