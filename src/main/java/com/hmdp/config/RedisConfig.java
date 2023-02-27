package com.hmdp.config;

import io.lettuce.core.RedisClient;
import org.redisson.Redisson;
import org.redisson.api.RedissonClient;
import org.redisson.config.Config;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * @author xin
 * @since 2023/2/25 20:20
 */

@Configuration
public class RedisConfig {

    @Bean
    public RedissonClient redissonClient(){
        // 配置类
        Config config = new Config();
        // 添加Redis地址，这里配置了单点
        config.useSingleServer().setAddress("redis://47.115.220.46:6379").setPassword("000415");
        // 创建RedissonClient对象
        return Redisson.create(config);
    }

}
