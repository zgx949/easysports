package com.ruoyi.framework.aspectj;

import com.ruoyi.common.annotation.DelPassCache;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.utils.Threads;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.List;

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

    /**
     * 处理完请求后执行
     *
     * @param joinPoint 切点
     */
    @AfterReturning(pointcut = "@annotation(controllerDelPassCache)", returning = "jsonResult")
    public void doAfterReturning(JoinPoint joinPoint, DelPassCache controllerDelPassCache, Object jsonResult)
    {
        Object[] args = joinPoint.getArgs();
        logger.info("查询体测通过情况参数：" + args.toString());
    }
}
