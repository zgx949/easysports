package com.ruoyi.system.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.SportFeedbackMapper;
import com.ruoyi.system.domain.SportFeedback;
import com.ruoyi.system.service.ISportFeedbackService;

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
        return sportFeedbackMapper.selectSportFeedbackList(sportFeedback);
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
        sportFeedback.setUpdateTime(DateUtils.getNowDate());
        return sportFeedbackMapper.updateSportFeedback(sportFeedback);
    }

    /**
     * 将一条反馈标记为已查看
     * @param feedbackId
     * @return
     */
    @Override
    public int checkUserFeedback(Long feedbackId) {
        SportFeedback sportFeedback = sportFeedbackMapper.selectSportFeedbackByFeedbackId(feedbackId);
        sportFeedback.setCheckTime(DateUtils.getNowDate());
        sportFeedback.setCheckId(SecurityUtils.getUserId());
        sportFeedback.setStatus(1);
        return sportFeedbackMapper.updateSportFeedback(sportFeedback);
    }
}
