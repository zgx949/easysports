package com.ruoyi.framework.aspectj;

import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.ruoyi.common.annotation.DelPassCache;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.utils.Threads;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

/**
 * @program: Ruoyi-Vue
 * @description: 删除体测情况缓存
 * @author: LeftHand
 * @create: 2022-11-03 22:41
 **/
@Aspect
@Component
public class DelPassCacheAspect {
    private static final Logger logger = LoggerFactory.getLogger(Threads.class);

    @Autowired
    private RedisCache redisCache;

    /**
     * 处理完请求后执行
     *
     * @param joinPoint 切点
     */
    @AfterReturning(pointcut = "@annotation(controllerDelPassCache)", returning = "jsonResult")
    public void doAfterReturning(JoinPoint joinPoint, DelPassCache controllerDelPassCache, Object jsonResult)
    {
        String jsonString = JSONObject.toJSONString(joinPoint.getArgs()[0]);
        char c = jsonString.charAt(0);
        // 入参是对象类型
        if (c == '{') {
            JSONObject item = JSONObject.parseObject(jsonString);
            String userId = String.valueOf(item.get("userId"));
            // 删除缓存
            boolean delResult = redisCache.deleteObject("fitness:pass" + userId);
            logger.info("学号：{}, 存在新成绩录入, 删除缓存:{}", userId, delResult);

            // 入参是数组类型
        } else if (c == '['){
            List list = JSONArray.parseArray(jsonString);
            for (Object o : list) {
                Map<String, Object> mp = (Map<String, Object>) o;
                String userId = String.valueOf(mp.get("userId"));

                // 删除缓存
                boolean delResult = redisCache.deleteObject("fitness:pass" + userId);
                logger.info("学号：{}, 存在新成绩录入, 删除缓存:{}", userId, delResult);
            }
        }

    }
}
