//
//  GCKCollectionVC.m
//  GCK新闻
//
//  Created by Harden on 2019/7/12.
//  Copyright © 2019 gck. All rights reserved.
//

#import "GCKCollectionVC.h"
#import"GCKHomePageVC.h"
#import "GCKHomeCell0.h"
#import "GCKNewsModel.h"
@interface GCKCollectionVC ()<UITableViewDataSource>
@property(nonatomic,strong)UITableView *collectionview;
@property(nonatomic,strong)NSMutableArray *newsArr;
@end
@implementation GCKCollectionVC
/** 加载新闻数组*/
- (NSMutableArray  *)newsArr
{
    if(!_newsArr)
    {
        _newsArr=[NSMutableArray array];
    }
    return _newsArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化tableview
    [self SetupTableview];
   /**注册cell */
    [self RegisterCell];
}
/**初始化tableview  */
-(void) SetupTableview
{
    //创建tableview
    UITableView *collectionview=[UITableView new];
    //让一个属性关联着tableview
    self.collectionview=collectionview;
    //设置collctionview为本控制器view
    self.view=collectionview;
    //设置本控制器为tableview的数据源;
    collectionview.dataSource=self;
    //设置每行高度
    collectionview.rowHeight=120;
}
 /**注册cell */
-(void)RegisterCell
{
    [self.collectionview registerClass:[GCKHomeCell0 class] forCellReuseIdentifier:@"cell"];
}
//收藏新闻
-(void)CollectNews:(GCKNewsModel *)news
{
    //将新闻添加到数组中
    [self.newsArr addObject:news];
}
#pragma mark---  tableview数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.newsArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //访问缓存池有没有可用cell
    GCKHomeCell0 *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    //给cell赋值
    cell.news=self.newsArr[indexPath.row];
    //将收藏按钮去掉
    [cell.collectionbt removeFromSuperview];
    return cell;
}
//刷新数据
-(void)ReloadData
{
    [self.collectionview reloadData];
}
@end
