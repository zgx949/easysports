package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.SportFeedback;

/**
 * 反馈Service接口
 * 
 * @author lsq
 * @date 2022-10-10
 */
public interface ISportFeedbackService 
{
    /**
     * 查询反馈
     * 
     * @param feedbackId 反馈主键
     * @return 反馈
     */
    public SportFeedback selectSportFeedbackByFeedbackId(Long feedbackId);

    /**
     * 查询反馈列表
     * 
     * @param sportFeedback 反馈
     * @return 反馈集合
     */
    public List<SportFeedback> selectSportFeedbackList(SportFeedback sportFeedback);

    /**
     * 新增反馈
     * 
     * @param sportFeedback 反馈
     * @return 结果
     */
    public int insertSportFeedback(SportFeedback sportFeedback);

    /**
     * 修改反馈
     * 
     * @param sportFeedback 反馈
     * @return 结果
     */
    public int updateSportFeedback(SportFeedback sportFeedback);

    /**
     * 批量删除反馈
     * 
     * @param feedbackIds 需要删除的反馈主键集合
     * @return 结果
     */
    public int deleteSportFeedbackByFeedbackIds(Long[] feedbackIds);

    /**
     * 删除反馈信息
     * 
     * @param feedbackId 反馈主键
     * @return 结果
     */
    public int deleteSportFeedbackByFeedbackId(Long feedbackId);

    /**
     * 用户新增反馈
     * @param sportFeedback
     * @return
     */
    public int insertUserFeedback(SportFeedback sportFeedback);

    /**
     * 用户修改反馈
     * @param sportFeedback
     * @return
     */
    public int updateUserFeedback(SportFeedback sportFeedback);

    /**
     * 将一条反馈标记为已查看
     * @param feedbackId
     * @return
     */
    public int checkUserFeedback(Long feedbackId);

    /**
     * 用户查询自身所有反馈
     * @return
     */
    public List<SportFeedback> selectUserFeedbacks();

    /**
     * 用户删除自己的一条反馈
     * @param feedbackId
     * @return
     */
    public int deleteUserFeedback(Long feedbackId);
}
