package com.ruoyi.system.domain.Vo;

import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

import java.io.Serializable;

public class FitnessBaseInfoVo extends BaseEntity {

    /** 学号 */
    private String userId;

    /** 姓名 */
    private String userName;

    /** 学院 */
    private String dept;

    /** 班级 */
    private String classNum;

    /** 用户性别（0男 1女 2未知） */
    private Long sex;

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getDept() {
        return dept;
    }

    public void setDept(String dept) {
        this.dept = dept;
    }

    public String getClassNum() {
        return classNum;
    }

    public void setClassNum(String classNum) {
        this.classNum = classNum;
    }

    public Long getSex() {
        return sex;
    }

    public void setSex(Long sex) {
        this.sex = sex;
    }
}
