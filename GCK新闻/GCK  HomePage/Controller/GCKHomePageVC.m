//
//  GCKHomePageVC.m
//  GCK新闻
//
//  Created by Harden on 2019/7/12.
//  Copyright © 2019 gck. All rights reserved.
//

#import "GCKHomePageVC.h"
#import "GCKCollectionVC.h"
#import "GCKHistoryVC.h"
#import"AFNetworking.h"
#import "GCKNewsModel.h"
#import "GCKHomeCell0.h"
#import "GCKHomeCell1.h"
#import "GCKHomeCell2.h"
#import "GCKHomeCell3.h"
#import<objc/runtime.h>
#import "Masonry.h"
#import "GCKHomeNavigationBar.h"
#import "GCKResultViewController.h"
#import "GCKWebController.h"
@interface GCKHomePageVC ()<UITableViewDataSource,UITableViewDelegate,GCKTabBarDelegate>
@property(nonatomic,strong)UITableView *homepageview;
@property(nonatomic,strong)NSArray *AllNewsArr;
@property(nonatomic,strong)NSArray *DataArr;
@property(nonatomic,strong)UINavigationBar *homenavbar;
@end

@implementation GCKHomePageVC
-(NSArray *)DataArr
{
    if(!_DataArr)
    {
        [NSArray array];
    }
    return _DataArr;
}
-(NSArray *)AllNewsArr
{
        NSMutableArray *temp=[NSMutableArray array];
        for (NSDictionary * dict in self.DataArr) {
            [temp addObject:[GCKNewsModel NewsWithDict:dict]];
        }
        self.AllNewsArr=temp;
        return _AllNewsArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    //请求数据
    [self getdata];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    //设置导航栏
    [self SetUpNavigationBar];
    //添加子控件
    [self addsubviews];
}
-(void)SetUpNavigationBar
{
    //移除自身的navigationbar
//    [self.navigationController.navigationBar removeFromSuperview];
    self.navigationController.navigationBar.hidden = YES;
    
    //创建导航栏
    GCKHomeNavigationBar *homenavbar=[[GCKHomeNavigationBar alloc]init];
    self.homenavbar=homenavbar;
    //设置背景颜色
    homenavbar.backgroundColor=[UIColor whiteColor];
    //添加到view中
    [self.view addSubview:homenavbar];
//    [homenavbar setFrame:CGRectMake(10, 10, self.view.frame.size.width, 64)];
    
  //将自定义导航栏设置为控制器的导航栏
    [homenavbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.height.mas_equalTo(85);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
    }];
   //设置当前控制器为tabbar代理
    homenavbar.delegate=self;
}
- (void)search
{
    //创建结果控制器
    GCKResultViewController *resulutvc=[GCKResultViewController new];
    //切换到结果控制器
    [self.navigationController pushViewController:resulutvc animated:YES];
}
    /** 添加子控制器 */
-(void)addsubviews
{
    UITableView *homepageview=[[UITableView alloc]init];
    self.homepageview=homepageview;
    //设置代理为本控制器
    homepageview.delegate=self;
    //设置数据源为本控制器
    homepageview.dataSource=self;
    //设置每一行cell的高度为100
    homepageview.rowHeight=150;
    //将tableview加到view中
    [self.view addSubview:homepageview];
    [homepageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.homenavbar.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    //创建navigationbar
    [self SetUpNavigationBar];
    //注册cell
    [self RegisterForCell];
}
/** 注册cell */
-(void)RegisterForCell
{
    [self.homepageview registerClass:[GCKHomeCell0 class] forCellReuseIdentifier:@"HomeCell0"];
    [self.homepageview registerClass:[GCKHomeCell1 class] forCellReuseIdentifier:@"HomeCell1"];
    [self.homepageview registerClass:[GCKHomeCell2 class] forCellReuseIdentifier:@"HomeCell2"];
   [self.homepageview registerClass:[GCKHomeCell3 class] forCellReuseIdentifier:@"HomeCell3"];
}
 /** 请求数据 */

-(void)getdata
{
    //随机生成一个数
    NSString *kw=@"白";
    //创建一个管理者
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    NSDictionary *parameterdict=@{
                                                   @"kw":kw,
                                                    @"site":@"qq.com",
                                                   @"pageToken":@"17",
                                                  @"apikey":@"FKo121FpJnj9cGJkkUjHKZXEH0BV1QCaY3gpVWZanmGXGg8fGDIXoWSFtGhcLLU6"
                                                                    };
    /*
     第一个参数:请求路径(不包含参数)NSString
     第三个个参数:字典,发送给服务器的参数
     第四个参数:progress: 进程回调
     第五个参数:sucess 请求成功后的回调
     第六个参数:failure  请求失败后的回调
     */
    [manager GET:@"http://api01.idataapi.cn:8000/news/qihoo" parameters:parameterdict headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //拿到数据字典数组
        self.DataArr=responseObject[@"data"];
        [self.homepageview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
#pragma mark---- tableview数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.AllNewsArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获得当前那行新闻的图片个数
     GCKNewsModel *news=self.AllNewsArr[indexPath.row];
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


#pragma mark---tableview的代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取到这一行的新闻模型
    GCKNewsModel *news=self.AllNewsArr[indexPath.row];
    
    //获得历史记录控制器
    GCKHistoryVC *historyvc=self.navigationController.tabBarController.childViewControllers[3].childViewControllers[0];
    //将新闻模型加到历史记录数组中
    [historyvc AddHistory:news];
    //开启系统自带导航栏
    self.navigationController.navigationBar.hidden=NO;
    GCKWebController *webController=[GCKWebController new];
    //将新闻模型赋值给webvc
    webController.news=news;
    //切换到web
    [self.navigationController pushViewController:webController animated:YES];
}
/** 随机生成汉字 */
-(NSString *)RandomlyGenerateChinese
{
    NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    //随机生成汉字高位
    NSInteger randomH = 0xA1+arc4random()%(0xFE - 0xA1+1);
    //随机生成汉字低位
    NSInteger randomL = 0xB0+arc4random()%(0xF7 - 0xB0+1);
    NSInteger number = (randomH<<8)+randomL;
    NSData *data = [NSData dataWithBytes:&number length:2];
    NSString *string = [[NSString alloc] initWithData:data encoding:gbkEncoding];
    return string;
}
-(void)ClickBtn:(UIButton *)button
{
    //获得按钮的值
    GCKNewsModel *news=objc_getAssociatedObject(button, @"news");
    //获得收藏控制器
    GCKCollectionVC *collectionvc=self.navigationController.tabBarController.childViewControllers[2].childViewControllers[0];
    
    //传递新闻
    [collectionvc CollectNews:news];
    //刷新数据
    [collectionvc ReloadData];
}
@end
