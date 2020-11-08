#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"

//通信标识
#define ChannelName    @"hh://MethodChannelPlugin"

//打开商品列表页面
#define OPEN_GOODS_LIST_PAGE    @"hh://openGoodsListPage"
#define OPEN_GOODS_PAGE    @"hh://openGoodsPage"

#define getLocation    @"hh://getLocation"
#define postLocation    @"hh://postLocation"
#import "HHGoodsListVc.h"

#import <CoreLocation/CoreLocation.h>


@interface AppDelegate ()<CLLocationManagerDelegate>{//添加代理协议 CLLocationManagerDelegate
    CLLocationManager *_locationManager;//定位服务管理类
    CLGeocoder * _geocoder;//初始化地理编码器
    
    FlutterMethodChannel* channel;
    NSString * _la;
    NSString * _lo;
}


@end


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification:) name:@"channel" object:nil];

    
    FlutterViewController* controller =
        (FlutterViewController*)self.window.rootViewController;
    
     channel = [FlutterMethodChannel
        methodChannelWithName:ChannelName
              binaryMessenger:controller.binaryMessenger];
    __weak typeof(self) weakSelf = self;
    [channel setMethodCallHandler:^(FlutterMethodCall* call,
                                           FlutterResult result) {
        NSLog(@"call.method: %@",call.method);
      if ([OPEN_GOODS_LIST_PAGE isEqualToString:call.method]) {
          HHGoodsListVc* lvc = [[HHGoodsListVc alloc] init];
          UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:lvc];
          navi.navigationBarHidden = true;
          [controller presentViewController:navi animated:YES completion:nil];
          result(@"");
        
      } else if ([getLocation isEqualToString:call.method]) {
          
          NSDictionary *dic = @{@"latitude":_la, @"longitude":_lo};
//          [channel invokeMethod:postLocation arguments:dic];
          result(dic);
      } else{
        result(FlutterMethodNotImplemented);
      }
    }];

    [self initializeLocationService];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}


- (void)initializeLocationService {
    // 初始化定位管理器
    _locationManager = [[CLLocationManager alloc] init];
    [_locationManager requestWhenInUseAuthorization];

    // 设置代理
    _locationManager.delegate = self;
    // 设置定位精确度到米
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    // 设置过滤器为无
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    // 开始定位
    [_locationManager startUpdatingLocation];//开始定位之后会不断的执行代理方法更新位置会比较费电所以建议获取完位置即时关闭更新位置服务
    //初始化地理编码器
    _geocoder = [[CLGeocoder alloc] init];
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{

    NSLog(@"%lu",(unsigned long)locations.count);
    CLLocation * location = locations.lastObject;
    // 纬度
    CLLocationDegrees latitude = location.coordinate.latitude;
    // 经度
    CLLocationDegrees longitude = location.coordinate.longitude;
    NSLog(@"%@",[NSString stringWithFormat:@"%lf", location.coordinate.longitude]);
    NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f", location.coordinate.longitude, location.coordinate.latitude,location.altitude,location.course,location.speed);
    _la = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
    _lo = [NSString stringWithFormat:@"%f",location.coordinate.longitude];

//    NSDictionary *dic = @{@"latitude":_la, @"longitude":_lo};
    //主动向flutter发送定位
//    [channel invokeMethod:postLocation arguments:dic];
    
//    [manager stopUpdatingLocation];不用的时候关闭更新位置服务
}
//实现方法
-(void)notification:(NSNotification *)noti{

//使用object处理消息
    NSString *info = [noti object];
    NSLog(@"接收 object传递的消息：%@",info);
    [channel invokeMethod:OPEN_GOODS_PAGE arguments:info];

}

- (void)dealloc {
    //移除所有观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
