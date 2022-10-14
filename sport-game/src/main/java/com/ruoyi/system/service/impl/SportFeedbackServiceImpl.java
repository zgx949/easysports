package com.ruoyi.system.service.impl;

import java.util.List;
import java.util.concurrent.TimeUnit;

import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.SportFeedbackMapper;
import com.ruoyi.system.domain.SportFeedback;
import com.ruoyi.system.service.ISportFeedbackService;
import org.springframework.util.CollectionUtils;

/**
 * 反馈Service业务层处理
 * 
 * @author lsq
 * @date 2022-10-10
 */
@Service
public class SportFeedbackServiceImpl implements ISportFeedbackService 
{
    @Autowired
    private SportFeedbackMapper sportFeedbackMapper;

    @Autowired
    private RedisCache redisCache;

    /**
     * 查询反馈
     * 
     * @param feedbackId 反馈主键
     * @return 反馈
     */
    @Override
    public SportFeedback selectSportFeedbackByFeedbackId(Long feedbackId)
    {
        return sportFeedbackMapper.selectSportFeedbackByFeedbackId(feedbackId);
    }

    /**
     * 查询反馈列表
     * 
     * @param sportFeedback 反馈
     * @return 反馈
     */
    @Override
    public List<SportFeedback> selectSportFeedbackList(SportFeedback sportFeedback)
    {
        List<SportFeedback> sportFeedbacks = sportFeedbackMapper.selectSportFeedbackList(sportFeedback);
        return sportFeedbacks;
    }

    /**
     * 新增反馈
     * 
     * @param sportFeedback 反馈
     * @return 结果
     */
    @Override
    public int insertSportFeedback(SportFeedback sportFeedback)
    {
        sportFeedback.setCreateTime(DateUtils.getNowDate());
        return sportFeedbackMapper.insertSportFeedback(sportFeedback);
    }

    /**
     * 修改反馈
     * 
     * @param sportFeedback 反馈
     * @return 结果
     */
    @Override
    public int updateSportFeedback(SportFeedback sportFeedback)
    {
        sportFeedback.setUpdateTime(DateUtils.getNowDate());
        return sportFeedbackMapper.updateSportFeedback(sportFeedback);
    }

    /**
     * 批量删除反馈
     * 
     * @param feedbackIds 需要删除的反馈主键
     * @return 结果
     */
    @Override
    public int deleteSportFeedbackByFeedbackIds(Long[] feedbackIds)
    {
        return sportFeedbackMapper.deleteSportFeedbackByFeedbackIds(feedbackIds);
    }

    /**
     * 删除反馈信息
     * 
     * @param feedbackId 反馈主键
     * @return 结果
     */
    @Override
    public int deleteSportFeedbackByFeedbackId(Long feedbackId)
    {
        return sportFeedbackMapper.deleteSportFeedbackByFeedbackId(feedbackId);
    }

    /**
     * 用户新增反馈
     * @param sportFeedback
     * @return
     */
    @Override
    public int insertUserFeedback(SportFeedback sportFeedback) {
        String content = sportFeedback.getContent();
        if(content.length()>100){
            return 0;
        }
        if(StringUtils.isEmpty(content)){
            return 0;
        }
        sportFeedback.setUserId(SecurityUtils.getUserId());
        sportFeedback.setCreateTime(DateUtils.getNowDate());
        sportFeedback.setUpdateTime(DateUtils.getNowDate());
        sportFeedback.setStatus(0);
        String redisKey="sportFeedback:selectFeedback:feedbackList:"+SecurityUtils.getUserId();
        redisCache.deleteObject(redisKey);
        return sportFeedbackMapper.insertSportFeedback(sportFeedback);
    }

    /**
     * 用户修改反馈
     * @param sportFeedback
     * @return
     */
    @Override
    public int updateUserFeedback(SportFeedback sportFeedback) {
        String content = sportFeedback.getContent();
        if(content.length()>100){
            return 0;
        }
        if(StringUtils.isEmpty(content)){
            return 0;
        }
        Long feedbackId = sportFeedback.getFeedbackId();
        Integer status = sportFeedbackMapper.selectSportFeedbackByFeedbackId(feedbackId).getStatus();
        if(status==1){
            return 0;
        }
        String redisKey="sportFeedback:selectFeedback:feedbackList:"+SecurityUtils.getUserId();
        redisCache.deleteObject(redisKey);
        sportFeedback.setUpdateTime(DateUtils.getNowDate());
        sportFeedback.setUserId(SecurityUtils.getUserId());
        return sportFeedbackMapper.updateUserFeedback(sportFeedback);
    }

    /**
     * 将一条反馈标记为已查看
     * @param feedbackId
     * @return
     */
    @Override
    public int checkUserFeedback(Long feedbackId) {
        Long userId = sportFeedbackMapper.selectSportFeedbackByFeedbackId(feedbackId).getUserId();
        String redisKey="sportFeedback:selectFeedback:feedbackList:"+userId;
        redisCache.deleteObject(redisKey);
        SportFeedback sportFeedback = sportFeedbackMapper.selectSportFeedbackByFeedbackId(feedbackId);
        sportFeedback.setCheckTime(DateUtils.getNowDate());
        sportFeedback.setCheckId(SecurityUtils.getUserId());
        sportFeedback.setStatus(1);
        return sportFeedbackMapper.updateSportFeedback(sportFeedback);
    }

    /**
     * 用户查询自身所有反馈
     * @return
     */
    @Override
    public List<SportFeedback> selectUserFeedbacks() {
        String redisKey="sportFeedback:selectFeedback:feedbackList:"+SecurityUtils.getUserId();
        List<SportFeedback> cacheList = redisCache.getCacheList(redisKey);
        if(!CollectionUtils.isEmpty(cacheList)){
            return cacheList;
        }
        SportFeedback sportFeedback=new SportFeedback();
        sportFeedback.setUserId(SecurityUtils.getUserId());
        List<SportFeedback> sportFeedbacks = sportFeedbackMapper.selectSportFeedbackList(sportFeedback);
        redisCache.setCacheList(redisKey,sportFeedbacks);
        redisCache.expire(redisKey, 1, TimeUnit.HOURS);//将用户自身所有反馈进行缓存
        return sportFeedbacks;
    }


    /**
     * 用户删除一条反馈
     * @param feedbackId
     * @return
     */
    @Override
    public int deleteUserFeedback(Long feedbackId) {
        Long userId = sportFeedbackMapper.selectSportFeedbackByFeedbackId(feedbackId).getUserId();
        String redisKey="sportFeedback:selectFeedback:feedbackList:"+userId;
        redisCache.deleteObject(redisKey);
        return sportFeedbackMapper.deleteUserFeedback(feedbackId,userId);
    }
}
