package com.ruoyi.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 用户信息对象 fitness_test_base_info
 * 
 * @author leftHand
 * @date 2022-10-17
 */
public class FitnessTestBaseInfo extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 基础信息表主键 */
    private Long id;

    /** 学号 */
    @Excel(name = "学号")
    private Long userId;

    /** 姓名 */
    @Excel(name = "姓名")
    private String userName;

    /** 学院 */
    @Excel(name = "学院")
    private String dept;

    /** 班级 */
    @Excel(name = "班级")
    private String classNum;

    /** 用户性别（0男 1女 2未知） */
    @Excel(name = "用户性别", readConverterExp = "0=男,1=女,2=未知")
    private Long sex;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }
    public void setUserId(Long userId) 
    {
        this.userId = userId;
    }

    public Long getUserId() 
    {
        return userId;
    }
    public void setUserName(String userName) 
    {
        this.userName = userName;
    }

    public String getUserName() 
    {
        return userName;
    }
    public void setDept(String dept) 
    {
        this.dept = dept;
    }

    public String getDept() 
    {
        return dept;
    }
    public void setClassNum(String classNum) 
    {
        this.classNum = classNum;
    }

    public String getClassNum() 
    {
        return classNum;
    }
    public void setSex(Long sex) 
    {
        this.sex = sex;
    }

    public Long getSex() 
    {
        return sex;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("userId", getUserId())
            .append("userName", getUserName())
            .append("dept", getDept())
            .append("classNum", getClassNum())
            .append("sex", getSex())
            .append("remark", getRemark())
            .toString();
    }
}
