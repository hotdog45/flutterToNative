package com.hh.flutter_to_native;

import android.Manifest;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Build;
import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.core.app.ActivityCompat;

import java.util.HashMap;
import java.util.Map;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

    private static final String channelName = "hh://MethodChannelPlugin"; //

    //打开商品列表页
    private static final String OPEN_GOODS_LIST_PAGE = "hh://openGoodsListPage";

    // 获取定位
    private static final String GET_LOCATION = "hh://getLocation";

    private static final String POST_LOCATION = "hh://postLocation";


    private MethodChannel methodChannel;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        requestPermissions(99, Manifest.permission.ACCESS_FINE_LOCATION);
        getLocation();
    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {

        GeneratedPluginRegistrant.registerWith(flutterEngine);
        methodChannel = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), channelName);
        methodChannel.setMethodCallHandler(
                (methodCall, result) -> {

                    if (methodCall.method.equals(OPEN_GOODS_LIST_PAGE)) {
                        Intent intent = new Intent(MainActivity.this, GoodsListActivity.class);
                        startActivityForResult(intent, 110);
                    } else if (methodCall.method.equals(GET_LOCATION)) {
                        getLocation();
                        Map map2 = new HashMap();
                        map2.put("longitude", mLocation.getLongitude());
                        map2.put("latitude", mLocation.getLatitude());
                        result.success(map2);
                    } else {
                        result.notImplemented();
                    }
                }
        );


    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        if (resultCode == RESULT_OK) {
            if (requestCode == 110) {
                String faceImage = data.getStringExtra("dic");//
                methodChannel.invokeMethod("hh://openGoodsPage", faceImage);

            }
        }
    }


    public void requestPermissions(int requestCode, String permission) {
        if (permission != null && permission.length() > 0) {
            try {
                if (Build.VERSION.SDK_INT >= 23) {
                    // 检查是否有权限
                    int hasPer = checkSelfPermission(permission);
                    if (hasPer != PackageManager.PERMISSION_GRANTED) {
                        requestPermissions(new String[]{permission}, requestCode);
                        getLocation();
                    }
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }


    LocationManager locationManager;
    LocationListener locationListener;
    Location mLocation;

    void getLocation() {
        //获取系统的LocationManager对
        locationManager = (LocationManager) getSystemService(LOCATION_SERVICE);
        //添加权限检查
        if (ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
            return;
        }
        mLocation = locationManager.getLastKnownLocation(LocationManager.GPS_PROVIDER);

        locationListener = new LocationListener() {
            @Override
            public void onLocationChanged(Location location) {
                mLocation = location;
                //如果location不为空时
                if (location != null) {
                    //主动向flutter发送定位
//                    Map map = new HashMap();
//                    map.put("longitude",location.getLongitude());
//                    map.put("latitude",location.getLatitude());
//                    methodChannel.invokeMethod(POST_LOCATION, map);

                }

            }

            @Override
            public void onStatusChanged(String provider, int status, Bundle extras) {

            }

            @Override
            public void onProviderEnabled(String provider) {

            }

            @Override
            public void onProviderDisabled(String provider) {

            }
        };

        //设置每一秒获取一次location信息
        locationManager.requestLocationUpdates(
                LocationManager.GPS_PROVIDER,      //GPS定位提供者
                2000,       //更新数据时间为1秒
                1,      //位置间隔为1米
                //位置监听器
                locationListener);


    }


}
