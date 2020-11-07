package com.hh.flutter_to_native;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.widget.TextView;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

/**
 * @author 李顺风
 * @date 2020/11/7.
 * GitHub：https://github.com/hotdog45
 * email：mac2020@126.com
 * description：coding
 */
public class GoodsListActivity extends Activity {

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_goods_list);

        TextView goodsText = findViewById(R.id.tv_goods_list);
        TextView goGoodsPage = findViewById(R.id.tv_go_goods);
        goGoodsPage.setOnClickListener(v -> {
            Intent intent = new Intent();
            intent.putExtra("dic", "商品:车厘子,价格:129.77元");
            setResult(RESULT_OK, intent);
            finish();
        });

    }



}
