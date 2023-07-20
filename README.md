# 介绍
基于SpringBoot实现的商铺点评平台，主要实现了商铺缓存、优惠券秒杀、达人探店、好友关注、附近商户、用户签到等功能。

# 软件架构
软件架构说明 前端：Vue、Element-ui 后端：SpringBoot、Mybatis-plus、Mysql、Redis。

# 安装教程
1. 在resource文件夹中的db文件夹里找到数据库文件新建数据库
2. 在配置文件中配置自己的mysql和redis连接信息
3. 解压前端代码到nginx的html文件夹
4. 修改nginx.conf
```

worker_processes  1;

events {
    worker_connections  1024;
}

http {
    include       mime.types;
    default_type  application/json;

    sendfile        on;
    
    keepalive_timeout  65;

    server {
        listen       8080;
        server_name  localhost;
        # 指定前端项目所在的位置，主要修改这里
        location / {
            root   html/dp;
            index  index.html index.htm;
        }

        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }


        location /api {  
            default_type  application/json;
            #internal;  
            keepalive_timeout   30s;  
            keepalive_requests  1000;  
            #支持keep-alive  
            proxy_http_version 1.1;  
            rewrite /api(/.*) $1 break;  
            proxy_pass_request_headers on;
            #more_clear_input_headers Accept-Encoding;  
            proxy_next_upstream error timeout;  
            proxy_pass http://127.0.0.1:8081;
            #proxy_pass http://backend;
        }
    }

    upstream backend {
        server 127.0.0.1:8081 max_fails=5 fail_timeout=10s weight=1;
        #server 127.0.0.1:8082 max_fails=5 fail_timeout=10s weight=1;
    }  
}

```

5. 启动后端

