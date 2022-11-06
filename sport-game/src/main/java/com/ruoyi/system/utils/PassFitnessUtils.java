package com.ruoyi.system.utils;

import com.ruoyi.common.core.redis.RedisCache;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * @program: Ruoyi-Vue
 * @description: 体测成绩合格情况判断
 * @author: LeftHand
 * @create: 2022-11-04 12:31
 **/
@Component
public class PassFitnessUtils {
    @Autowired
    private RedisCache redisCache;

    /**
    * @Description: 判断50米成绩是否合格
    * @Param:
    * @return:
    * @Author: leftHand
    * @Date: 2022-11-04
    */
    public Boolean fifRun(Long gender, Float score) {
        if (score == null) {
            return false;
        }
        // 合格线
        String key = gender == 0L ? "sys_config:fitness:0:50" : "sys_config:fitness:1:50";
        float limit = Float.parseFloat(redisCache.getCacheObject(key));
        return score < limit;

    }

    /**
    * @Description: 长跑合格情况
    * @Param:
    * @return:
    * @Author: leftHand
    * @Date: 2022-11-04
    */
    public Boolean longRun (Long gender, Float score) {
        if (score == null) {
            return false;
        }
        // 合格线
        String key = gender == 0L ? "sys_config:fitness:0:1000" : "sys_config:fitness:1:800";
        float limit = Float.parseFloat(redisCache.getCacheObject(key));
        return score < limit;
    }

    /**
    * @Description: 体前屈合格情况
    * @Param:
    * @return:
    * @Author: leftHand
    * @Date: 2022-11-04
    */
    public Boolean flex(Long gender, Float score) {
        if (score == null) {
            return false;
        }
        // 合格线
        String key = gender == 0L ? "sys_config:fitness:0:flex" : "sys_config:fitness:1:flex";
        float limit = Float.parseFloat(redisCache.getCacheObject(key));
        return score > limit;
    }

    /**
    * @Description: 附加项目合格情况
    * @Param:
    * @return:
    * @Author: leftHand
    * @Date: 2022-11-04
    */
    public Boolean other (Long gender, Long score) {
        if (score == null) {
            return false;
        }
        // 合格线
        String key = gender == 0L ? "sys_config:fitness:0:other" : "sys_config:fitness:1:other";
        int limit = Integer.parseInt(redisCache.getCacheObject(key));
        return score > limit;
    }

    /**
    * @Description: 肺活量合格情况
    * @Param:
    * @return:
    * @Author: leftHand
    * @Date: 2022-11-04
    */
    public Boolean lung (Long gender, Long score) {
        if (score == null) {
            return false;
        }
        // 合格线
        String key = gender == 0L ? "sys_config:fitness:0:lung" : "sys_config:fitness:1:lung";
        int limit = Integer.parseInt(redisCache.getCacheObject(key));
        return score > limit;
    }

    /**
     * @Description: 立定跳合格情况
     * @Param:
     * @return:
     * @Author: leftHand
     * @Date: 2022-11-04
     */
    public Boolean jump (Long gender, Long score) {
        if (score == null) {
            return false;
        }
        // 合格线
        String key = gender == 0L ? "sys_config:fitness:0:jump" : "sys_config:fitness:1:jump";
        int limit = Integer.parseInt(redisCache.getCacheObject(key));
        return score > limit;
    }

}
