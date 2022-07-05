package com.ruoyi.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 报名管理对象 sport_registrations
 *
 * @author leftHand
 * @date 2022-07-05
 */
public class SportRegistrations extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** id */
    private Long id;

    /** 比赛 */
    @Excel(name = "比赛")
    private Long gameId;

    /** 用户 */
    @Excel(name = "用户")
    private Long userId;

    /** 场地 */
    @Excel(name = "场地")
    private Long fieldId;

    /** 审核状态 */
    @Excel(name = "审核状态")
    private String status;

    /** 比赛成绩 */
    @Excel(name = "比赛成绩")
    private Long score;

    /** 比赛积分 */
    @Excel(name = "比赛积分")
    private Long points;

    /** 备注信息(是否破纪录等) */
    @Excel(name = "备注信息(是否破纪录等)")
    private String comment;

    public void setId(Long id)
    {
        this.id = id;
    }

    public Long getId()
    {
        return id;
    }
    public void setGameId(Long gameId)
    {
        this.gameId = gameId;
    }

    public Long getGameId()
    {
        return gameId;
    }
    public void setUserId(Long userId)
    {
        this.userId = userId;
    }

    public Long getUserId()
    {
        return userId;
    }
    public void setFieldId(Long fieldId)
    {
        this.fieldId = fieldId;
    }

    public Long getFieldId()
    {
        return fieldId;
    }
    public void setStatus(String status)
    {
        this.status = status;
    }

    public String getStatus()
    {
        return status;
    }
    public void setScore(Long score)
    {
        this.score = score;
    }

    public Long getScore()
    {
        return score;
    }
    public void setPoints(Long points)
    {
        this.points = points;
    }

    public Long getPoints()
    {
        return points;
    }
    public void setComment(String comment)
    {
        this.comment = comment;
    }

    public String getComment()
    {
        return comment;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
                .append("id", getId())
                .append("gameId", getGameId())
                .append("userId", getUserId())
                .append("fieldId", getFieldId())
                .append("status", getStatus())
                .append("score", getScore())
                .append("points", getPoints())
                .append("comment", getComment())
                .append("createTime", getCreateTime())
                .append("updateTime", getUpdateTime())
                .toString();
    }
}
