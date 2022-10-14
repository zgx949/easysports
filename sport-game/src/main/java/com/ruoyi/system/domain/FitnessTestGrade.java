package com.ruoyi.system.domain;

import com.ruoyi.common.core.domain.entity.SysUser;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 体测成绩对象 fitness_test_grade
 *
 * @author leftHand
 * @date 2022-08-23
 */
public class FitnessTestGrade extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 成绩id */
    private Long id;

    /** 用户id */
    @Excel(name = "用户id")
    private String userId;
    private SysUser user;

    /** 体测活动id */
    @Excel(name = "体测活动id")
    private Long ftaId;
    private FitnessTestActivity fta;

    /** 项目id */
    @Excel(name = "项目id")
    private Long itemId;
    private SportItem item;

    /** 成绩 */
    @Excel(name = "成绩")
    private Long score;

    /** 创建人 */
    @Excel(name = "创建人")
    private Long createUid;
    private SysUser createUser;

    /** 最后修改的人 */
    @Excel(name = "最后修改的人")
    private Long updateUid;
    private SysUser updateUser;

    public SysUser getUser() {
        return user;
    }

    public void setUser(SysUser user) {
        this.user = user;
    }

    public FitnessTestActivity getFta() {
        return fta;
    }

    public void setFta(FitnessTestActivity fta) {
        this.fta = fta;
    }

    public SportItem getItem() {
        return item;
    }

    public void setItem(SportItem item) {
        this.item = item;
    }

    public SysUser getCreateUser() {
        return createUser;
    }

    public void setCreateUser(SysUser createUser) {
        this.createUser = createUser;
    }

    public SysUser getUpdateUser() {
        return updateUser;
    }

    public void setUpdateUser(SysUser updateUser) {
        this.updateUser = updateUser;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    public Long getId()
    {
        return id;
    }
    public void setUserId(String userId)
    {
        this.userId = userId;
    }

    public String getUserId()
    {
        return userId;
    }
    public void setFtaId(Long ftaId)
    {
        this.ftaId = ftaId;
    }

    public Long getFtaId()
    {
        return ftaId;
    }
    public void setItemId(Long itemId)
    {
        this.itemId = itemId;
    }

    public Long getItemId()
    {
        return itemId;
    }
    public void setScore(Long score)
    {
        this.score = score;
    }

    public Long getScore()
    {
        return score;
    }
    public void setCreateUid(Long createUid)
    {
        this.createUid = createUid;
    }

    public Long getCreateUid()
    {
        return createUid;
    }
    public void setUpdateUid(Long updateUid)
    {
        this.updateUid = updateUid;
    }

    public Long getUpdateUid()
    {
        return updateUid;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("userId", getUserId())
            .append("ftaId", getFtaId())
            .append("itemId", getItemId())
            .append("score", getScore())
            .append("remark", getRemark())
            .append("createUid", getCreateUid())
            .append("createTime", getCreateTime())
            .append("updateUid", getUpdateUid())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
