//
//  HHGoodsListVc.m
//  Runner
//
//  Created by 李顺风 on 2020/11/5.
//

#import "HHGoodsListVc.h"
#import "GoodsModel.h"
@interface HHGoodsListVc ()<UITableViewDelegate,UITableViewDataSource>

#pragma mark - 表格
@property (nonatomic,strong)UITableView *tableView;
#pragma mark - 数组
@property (nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation HHGoodsListVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];//添加表格到视图
        //添加数组元素
    GoodsModel *m = [[GoodsModel alloc]init];
        m.name = @"铁甲小宝玩具";
        m.price = @"16.99";
        [self.dataArray addObject:m];
    GoodsModel *m2 = [[GoodsModel alloc]init];
    m2.name = @"黄瓜五斤";
    m2.price = @"26.19";
    [self.dataArray addObject:m2];
    GoodsModel *m3 = [[GoodsModel alloc]init];
    m3.name = @"大盘鸡";
    m3.price = @"121.7";
    [self.dataArray addObject:m3];
    //注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"TableViewCellID"];
}

//懒加载
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        
        _tableView.delegate = self;//遵循协议
        _tableView.dataSource = self;//遵循数据源
    }
    return _tableView;
}
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];//初始化数组
    }
    return _dataArray;
}


#pragma mark - UITableViewDelegate,UITableViewDataSource
//分区，组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//每个分区的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GoodsModel *m = self.dataArray[indexPath.row];//取出数组元素
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"channel" object:m];
}
//每个单元格的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellID"];
    }
    GoodsModel *m = self.dataArray[indexPath.row];//取出数组元素
    cell.textLabel.text = [NSString stringWithFormat:@"商品:%@,价格:%@",m.name,m.price];
    
   
    return cell;
}

@end


