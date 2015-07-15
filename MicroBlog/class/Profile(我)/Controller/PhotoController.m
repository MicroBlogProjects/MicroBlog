//
//  PhotoController.m
//  MicroBlog
//
//  Created by guanliyuan on 15/7/13.
//  Copyright (c) 2015年 laiweihuang. All rights reserved.
//

#import "PhotoController.h"
#import "AFHTTPSessionManager.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "AccountTool.h"
#import "AccountModel.h"
#import "PhotoCollectionViewCell.h"

@interface PhotoController ()

@end

@implementation PhotoController

static NSString * const reuseIdentifier = @"Cell";
static NSString * const DIY = @"DIYcell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的相册";
    [self getIPhoto];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:DIY];
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

- (void)getIPhoto
{
    //1.请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //2.拼接请求参数
    AccountModel *account = [AccountTool account]; //从沙盒中获取用户信息
    NSMutableDictionary *params= [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    NSLog(@"%@   %@",account.access_token,account.uid);
    [manager GET:@"https://api.weibo.com/2/place/users/photos.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject:%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:DIY forIndexPath:indexPath];
    [cell sizeToFit];
    return cell;
}
//每个collectionView就是一个cell
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = ([[UIScreen mainScreen]bounds].size.width - 4 *kStatusCellBorderWidth)/3;
    return CGSizeMake(width, width);
}
//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5,5,5,5);
}
//是否可以点击
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/
@end
