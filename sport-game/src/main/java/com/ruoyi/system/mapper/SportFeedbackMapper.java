package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.SportFeedback;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

/**
 * 反馈Mapper接口
 * 
 * @author lsq
 * @date 2022-10-10
 */
@Repository
public interface SportFeedbackMapper 
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
     * 删除反馈
     * 
     * @param feedbackId 反馈主键
     * @return 结果
     */
    public int deleteSportFeedbackByFeedbackId(Long feedbackId);

    /**
     * 批量删除反馈
     *
     * @param feedbackIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteSportFeedbackByFeedbackIds(Long[] feedbackIds);

    /**
     * 用户删除一条反馈
     * @param feedbackId
     * @param userId
     * @return
     */
    @Delete("delete from sport_feedback where feedback_id=#{feedbackId} and user_id=#{userId}")
    public int deleteUserFeedback(@Param("feedbackId") Long feedbackId,@Param("userId") Long userId);

    /**
     * 用户更新反馈内容
     * @param sportFeedback
     * @return
     */
    public int updateUserFeedback(SportFeedback sportFeedback);
}
