//
//  GCKHistoryVC.m
//  GCK新闻
//
//  Created by Harden on 2019/7/12.
//  Copyright © 2019 gck. All rights reserved.
//

#import "GCKHistoryVC.h"
#import "GCKNewsModel.h"
#import "GCKLocalDataTool.h"

@interface GCKHistoryVC ()<UITableViewDelegate,UITableViewDataSource>
/**历史记录界面 */
@property(nonatomic,strong)UITableView *historyview;
/**历史记录属性 */
@property(nonatomic,strong)NSMutableArray *historyArr;
@end

@implementation GCKHistoryVC
/**懒加载历史记录数组 */
-(NSMutableArray *)historyArr
{
    if(!_historyArr)
    {
        _historyArr=[NSMutableArray array];
    }
    return _historyArr;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //加载主界面
    [self SetUpMainView];
    
}
//当要显示view时刷新数据
- (void)viewWillAppear:(BOOL)animated
{
    [self.historyview reloadData];
}
/**创建主界面  */
-(void)SetUpMainView
{
    /**创建主界面view */
    UITableView *historyview =[[UITableView alloc]init];
    /**用一个属性引用着view */
     self.historyview=historyview;
    //将主界面view设置为本控制器的view
    self.view=historyview;
    //设置行行高
    historyview.rowHeight=60;
    //将本控制器设为主界面view的数据源
    historyview.delegate=self;
    //将本控制器设为主界面view的代理
    historyview.dataSource=self;
    
    [historyview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark---tableview的数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.historyArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取出新闻模型
    GCKNewsModel *news=self.historyArr[indexPath.row];
    //访问缓存池是否有可用cell
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    //设置cell的标题
    cell.textLabel.text=news.title;
    return cell;
}
/**增加历史记录 */
-(void)AddHistory:(GCKNewsModel *)news
{
    /**增加历史记录 */
    [self.historyArr addObject:news];
    /**刷新记录 */
    [self.historyview reloadData];
}
#pragma mark---tableview的代理方法
@end
