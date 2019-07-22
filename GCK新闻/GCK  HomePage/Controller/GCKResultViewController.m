//
//  GCKResultViewController.m
//  GCK新闻
//
//  Created by Harden on 2019/7/18.
//  Copyright © 2019 gck. All rights reserved.
//

#import "GCKResultViewController.h"
#import "AFNetworking.h"
#import "Masonry.h"
#import "GCKNewsModel.h"
#import "GCKHomeCell0.h"
#import "GCKHomeCell1.h"
#import "GCKHomeCell2.h"
#import "GCKHomeCell3.h"
#import "GCKColorTool.h"
#import"GCKLocalDataTool.h"
#import<objc/runtime.h>

@interface GCKResultViewController ()<UITableViewDataSource,UITableViewDelegate>
   /**搜索框  */
@property(nonatomic,strong)UITextField *resulttextfield;
   /**搜索历史记录数组 */
@property(nonatomic,strong)NSMutableArray *searchhistoryArr;
 /**展示搜索结果数组 */
@property(nonatomic,strong)NSMutableArray *resultArr;
/**tableview  */
@property(nonatomic,strong)UITableView *resultview;
/**取消按钮 */
@property(nonatomic,strong)UIBarButtonItem*canclebtn;
/**搜索按钮  */
@property(nonatomic,strong)UIBarButtonItem*searchbtn;
/**搜索结果的字典数组  */
@property(nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation GCKResultViewController
//懒加载搜索记录数组
-(NSMutableArray *)searchhistoryArr
{
    if(!_searchhistoryArr)
    {
        _searchhistoryArr=[NSMutableArray array];
    }
    return _searchhistoryArr;
}
//懒加载数据数组
-(NSMutableArray *)dataArr
{
    if(!_dataArr)
    {
        _dataArr=[NSMutableArray array];
    }
    return _dataArr;
}
//懒加载结果数组
-(NSMutableArray *)resultArr
{
        //将字典数组转为模型数组
        NSMutableArray *temp=[NSMutableArray array];
        for(NSDictionary  *dict in self.dataArr)
        {
            [temp addObject:[GCKNewsModel NewsWithDict:dict]];
        }
        _resultArr=temp;
    return _resultArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //创建所有的veiw
    [self SetUpAllViews];
    // 创建navbar的子view
      [self SetUpNavbarSubViews];
    //对navbar的子view进行布局
    [self LayOutNavSubViews];
    //加载搜索记录数组
    self.searchhistoryArr=[NSMutableArray arrayWithArray:[GCKLocalDataTool ReadLocalDataWithFileName:@"searchhistory"]];
}
-(void)SetUpAllViews
{
    //创建结果tableview
    UITableView *resultview=[UITableView new];
    //设置为本控制器的view
    self.view=resultview;
    //用属性关联着tableview
    self.resultview=resultview;
    //设置本控制器为tableview数据源
    resultview.dataSource=self;
    //设置本控制器为tableview的代理
    self.resultview.delegate=self;
    //注册cell
    [self RegisterForCell];
    //设置cell的行高
    self.resultview.rowHeight=150;
    //不隐藏系统的navbar
    self.navigationController.navigationBar.hidden=NO;
    //设置navbar的背景色为白色
    self.navigationController.navigationBar.backgroundColor=[UIColor whiteColor];
    
}
/** 注册cell */
-(void)RegisterForCell
{
     [self.resultview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.resultview registerClass:[GCKHomeCell0 class] forCellReuseIdentifier:@"HomeCell0"];
    [self.resultview registerClass:[GCKHomeCell1 class] forCellReuseIdentifier:@"HomeCell1"];
    [self.resultview registerClass:[GCKHomeCell2 class] forCellReuseIdentifier:@"HomeCell2"];
    [self.resultview registerClass:[GCKHomeCell3 class] forCellReuseIdentifier:@"HomeCell3"];
}
-(void)SetUpNavbarSubViews
{
    //设置搜索框
    [self SetUpTextfield];
    //设置取消按钮
    [self SetUpCanlebtn];
    //设置搜索按钮
    [self SetUpSearchbtn];

}
//创建搜索框
-(void)SetUpTextfield
{
    //对搜索框进行一系列设置
    UITextField *resulttextfield=[[UITextField alloc]init];
    self.navigationItem.titleView=resulttextfield;
    self.resulttextfield=resulttextfield;
    self.resulttextfield.backgroundColor=[GCKColorTool colorWithHexString:@"#f4f5f7" alpha:1.0 ];
    self.resulttextfield.placeholder=@"搜索感兴趣的内容";
    //监听搜索框的文字变化
    [ self.resulttextfield addTarget:self action:@selector(TextfiledChange:) forControlEvents:UIControlEventEditingChanged];
    self.resulttextfield.tintColor=[UIColor blueColor];
    self.resulttextfield.borderStyle=UITextBorderStyleRoundedRect;
}
/**监听文本框*/
-(void)TextfiledChange:(UITextField *)textfield
{
    //如果文本框为空展示搜索记录
    if([textfield.text isEqual:@""])
    {
        [self.resultview reloadData];
    }
}
//设置搜索按钮
-(void)SetUpSearchbtn
//设置取消按钮
{
    //创建一个barbutton
    UIBarButtonItem *searchbtn=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"搜索"] style:  UIBarButtonItemStylePlain target:self action:@selector(Search)];
    //设置为tabbar左边的按钮
    self.navigationItem.leftBarButtonItem=searchbtn;
    //用一个属性关联值
    self.searchbtn=searchbtn;
}
//设置取消按钮
-(void)SetUpCanlebtn
{
    UIBarButtonItem *canclebtn=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"取消"] style:  UIBarButtonItemStylePlain target:self action:@selector(Cancle)];
    self.navigationItem.rightBarButtonItem=canclebtn;
    self.canclebtn=canclebtn;
}
//对navbar的子view进行布局
-(void)LayOutNavSubViews
{
    self.resulttextfield.frame=CGRectMake(5, 5, 300, 32);
    
}
//取消
-(void)Cancle
{
    [self.navigationController popViewControllerAnimated:YES];
}
//点击搜索按钮后进行的操作
-(void)Search
{
    //将文本作为kw请求数据
    [self AskForData:self.resulttextfield.text];
  //保存数据到缓存
    [self.searchhistoryArr addObject:self.resulttextfield.text];
    //将可变数组转为不可变数组
    NSArray *saveArr=[NSArray arrayWithArray:self.searchhistoryArr];
    //将数组保存到本地中
    [GCKLocalDataTool WriteLocalDataWithArray:saveArr AndFileName:@"searchhistory"];
    //刷新数据
    [self.resultview reloadData];
}
//请求数据
-(void)AskForData:(NSString *)kw
{
    //创建会话管理者
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    //创建一个参数字典
    NSDictionary *parameterdict=@{
                                  @"kw" :kw,
                                  @"site":@"qq.com",
                            @"apikey":@"FKo121FpJnj9cGJkkUjHKZXEH0BV1QCaY3gpVWZanmGXGg8fGDIXoWSFtGhcLLU6"
                                                                    };
    [manager GET:@"http://api01.idataapi.cn:8000/news/qihoo" parameters:parameterdict headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //成功后的回调
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //将请求下来的数组赋值到自己的数组中
        self.dataArr=responseObject[@"data"];
        [self.resultview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //失败打印错误
        NSLog(@"%@",error);
    }];
    
 }
#pragma mark--- tableview数据源方法
//设置tableveiw标题的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if([self.resulttextfield.text isEqual:@""])
    {
        return 60;
    }
    else return 0;
}
//设置tableveiw标题的高度
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if([self.resulttextfield.text isEqual:@""])
    {
        return@"搜索记录";
    }
    else return nil;
}
//设置一共有多少行cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([self.resulttextfield.text isEqual:@""])
    {
        tableView.rowHeight=60;
        return self.searchhistoryArr.count;
    }
    else
    {
        tableView.rowHeight=150;
    return self.resultArr.count;
    }
}
-(void)SetDeleteBtnForCell:(UITableViewCell *)cell AndIndexPath: (NSIndexPath *)indexPath
{
    //创建删除记录按钮
    UIButton *deletbtn=[UIButton new];
    //设置图片
    [deletbtn setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
    //添加到tableview的contentview中
    [cell.contentView addSubview:deletbtn];
    //监听点击
    [deletbtn addTarget:self action:@selector(DeleteHistory:) forControlEvents:UIControlEventTouchDown];
    //按钮传值
    objc_setAssociatedObject(deletbtn, @"indexPath",indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self  SetLayoutForDeleteBtn:deletbtn];
}
//删除历史记录
-(void)DeleteHistory:(UIButton *)btn
{
    //取到cell
    NSIndexPath *indexpath= objc_getAssociatedObject(btn, @"indexPath");
    //删除记录
    [self.searchhistoryArr removeObjectAtIndex:indexpath.row];
    //将可变数组转为不可变数组
    NSArray *saveArr=[NSArray arrayWithArray:self.searchhistoryArr];
    //将新的记录保存到本地中
    [GCKLocalDataTool WriteLocalDataWithArray:saveArr AndFileName:@"searchhistory"];
    //刷新数据
    [self.resultview reloadData];
    
    
}
//设置删除按钮的位置
-(void)SetLayoutForDeleteBtn:(UIButton *)btn
{
    btn.frame=CGRectMake(self.view.bounds.size.width-25, 20, 20, 20);
}
//设置每行的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.resulttextfield.text isEqual:@""])
    {
        UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];
        cell.textLabel.text=self.searchhistoryArr[indexPath.row];
        //设置字体大小
        cell.textLabel.font=[UIFont systemFontOfSize:20];
        //添加删除按钮
        [self SetDeleteBtnForCell:cell AndIndexPath:indexPath];
        return cell;
    }
    else
    {
        //获得当前那行新闻的图片个数
        GCKNewsModel *news=self.resultArr[indexPath.row];
        NSInteger  imagescount=news.imageUrls.count;
        switch (imagescount) {
                //图片个数为0
            case 0:
            {
                GCKHomeCell0 *cell0=[tableView dequeueReusableCellWithIdentifier:@"HomeCell0" ];
                cell0.news=news;
                //设置收藏按钮的监听事件
                [cell0.collectionbt addTarget:self action:@selector(ClickBtn:) forControlEvents:UIControlEventTouchUpInside];
                //按钮传值
                objc_setAssociatedObject(cell0.collectionbt, @"news",news, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                return cell0;
            }
                break;
                //图片个数为1
            case 1:
            {
                //访问缓存池有没有可利用cell
                GCKHomeCell1 *cell1=[tableView dequeueReusableCellWithIdentifier:@"HomeCell1" ];
                cell1.news=news;
                //设置收藏按钮的监听事件
                [cell1.collectionbt addTarget:self action:@selector(ClickBtn:) forControlEvents:UIControlEventTouchUpInside];
                //按钮传值
                objc_setAssociatedObject(cell1.collectionbt, @"news",news, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                return cell1;
            }
                break;
                //图片个数为2
            case 2:
            {
                //访问缓存池有没有可利用cell
                GCKHomeCell2 *cell2=[tableView dequeueReusableCellWithIdentifier:@"HomeCell2" ];
                //cell2赋值
                cell2.news=news;
                //设置收藏按钮的监听事件
                [cell2.collectionbt addTarget:self action:@selector(ClickBtn:) forControlEvents:UIControlEventTouchUpInside];
                //按钮传值
                objc_setAssociatedObject(cell2.collectionbt, @"news",news, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                return cell2;
            }
                break;
                
                //其他情况
            default:
            {
                //访问缓存池有没有可利用cell
                GCKHomeCell3 *cell3=[tableView dequeueReusableCellWithIdentifier:@"HomeCell3" ];
                cell3.news=news;
                //设置收藏按钮的监听事件
                [cell3.collectionbt addTarget:self action:@selector(ClickBtn:) forControlEvents:UIControlEventTouchUpInside];
                //按钮传值
                objc_setAssociatedObject(cell3.collectionbt, @"news",news, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                return cell3;
            }
                break;
        }
    }
}
#pragma mark--- tableview代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
