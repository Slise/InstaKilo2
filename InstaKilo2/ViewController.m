//
//  ViewController.m
//  InstaKilo2
//
//  Created by Benson Huynh on 2016-01-27.
//  Copyright © 2016 Benson Huynh. All rights reserved.
//

#import "ViewController.h"
#import "Photo.h"
#import "CollectionViewCell.h"
#import "HeaderReusableView.h"

typedef NS_ENUM(NSUInteger, PhotoFilterType) {
    PhotoFilterTypeLocation,
    PhotoFilterTypeSubject,
};

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray *photoList;
@property (nonatomic, assign) PhotoFilterType photoFilterType;
@property (nonatomic, strong) NSMutableArray *photoLocations;
@property (weak, nonatomic) IBOutlet UICollectionView *photoCollectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Photo *image1 = [[Photo alloc] initWithImage:[UIImage imageNamed:@"Shinjuku.jpg"] location:@"World Picture" subject:@"travel"];
    Photo *image2 = [[Photo alloc] initWithImage:[UIImage imageNamed:@"Paris.jpg"] location:@"World Picture" subject:@"travel"];
    Photo *image3 = [[Photo alloc] initWithImage:[UIImage imageNamed:@"Yokohama.jpg"] location:@"World Picture" subject:@"travel"];
    Photo *image4 = [[Photo alloc] initWithImage:[UIImage imageNamed:@"Waikiki.jpg"] location:@"World Picture" subject:@"travel"];
    Photo *image5 = [[Photo alloc] initWithImage:[UIImage imageNamed:@"condo.jpg"] location:@"Downtown Vancouver" subject:@"weekend"];
    Photo *image6 = [[Photo alloc] initWithImage:[UIImage imageNamed:@"christmas.jpg"] location:@"Home" subject:@"holiday"];
    Photo *image7 = [[Photo alloc] initWithImage:[UIImage imageNamed:@"condo.jpg"] location:@"Home" subject:@"interests"];
    Photo *image8 = [[Photo alloc] initWithImage:[UIImage imageNamed:@"car.jpg"] location:@"Vancouver" subject:@"interests"];
    Photo *image9 = [[Photo alloc] initWithImage:[UIImage imageNamed:@"park.jpg"] location:@"World Picture" subject:@"travel"];
    Photo *image10 = [[Photo alloc] initWithImage:[UIImage imageNamed:@"mansion.jpg"] location:@"Vancouver" subject:@"interests"];
    
    self.photoList = [NSMutableArray arrayWithArray:@[image1, image2, image3, image4, image5, image6, image7, image8, image9, image10]];
    
    self.photoLocations = [NSMutableArray array];
    [self updatePhotoLocations];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self photoListGroupedByLocation].allKeys.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSString *location = [self photoListGroupedByLocation].allKeys[section];
    NSArray *locationPhotos = [[self photoListGroupedByLocation] objectForKey:location];
    return [locationPhotos count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSString *location = [self photoListGroupedByLocation].allKeys[indexPath.section];
    Photo *photo = [[[self photoListGroupedByLocation] objectForKey:location] objectAtIndex:indexPath.row];
    cell.photoImage.image = photo.image;
    return cell;
}

- (void)updatePhotoLocations {
    for (Photo *photo in self.photoList) {
        [self.photoLocations addObject:photo.location];
    }
}

- (NSDictionary *) photoListGroupedByLocation {
    NSMutableDictionary *groupedPhotos = [NSMutableDictionary dictionary];
    for (Photo *photo in self.photoList) {
        BOOL doesHaveLocationPhotos = [groupedPhotos[photo.location] isKindOfClass:[NSArray class]];
        if (doesHaveLocationPhotos) {
            groupedPhotos[photo.location] = [groupedPhotos[photo.location] arrayByAddingObject:photo];
        } else {
            groupedPhotos[photo.location] = @[photo];
        }
    }
    return groupedPhotos;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    HeaderReusableView *collectionReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"sectionHeader" forIndexPath:indexPath];
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        NSString *location = [[self photoListGroupedByLocation].allKeys objectAtIndex:indexPath.section];
        collectionReusableView.headerText.text = location;
    }
    return collectionReusableView;
}

@end
