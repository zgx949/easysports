package com.ruoyi.system.domain.Vo;

import com.ruoyi.common.core.domain.entity.SysDept;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.system.domain.FitnessTestActivity;
import com.ruoyi.system.domain.FitnessTestGrade;
import com.ruoyi.system.domain.SportItem;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * @program: Ruoyi-Vue
 * @description: 体测成绩出参
 * @author: LeftHand
 * @create: 2022-08-25 18:48
 **/
public class FitnessTestGradeVo implements Serializable {
    private Long userId;

    private String userName;

    private String gender;

    private SysDept dept;

    private FitnessTestActivity fta;

    private SportItem item;

    private Long score;

    private Date createTime;

    private Date updateTime;

    private SysUser createUser;

    private SysUser updateUser;

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public SysDept getDept() {
        return dept;
    }

    public void setDept(SysDept dept) {
        this.dept = dept;
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

    public Long getScore() {
        return score;
    }

    public void setScore(Long score) {
        this.score = score;
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
}
