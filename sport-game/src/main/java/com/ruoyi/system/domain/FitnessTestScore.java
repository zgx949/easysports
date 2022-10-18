package com.ruoyi.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 体测成绩对象 fitness_test_score
 *
 * @author leftHand
 * @date 2022-10-18
 */
public class FitnessTestScore extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键id */
    private Long id;

    /** 学号 */
    @Excel(name = "学号")
    private String userId;

    /** 身高 */
    @Excel(name = "身高")
    private Long height;

    /** 体重 */
    @Excel(name = "体重")
    private Long weight;

    /** 左眼 */
    @Excel(name = "左眼")
    private Double leftEye;

    /** 右眼 */
    @Excel(name = "右眼")
    private Double rightEye;

    /** 肺活量 */
    @Excel(name = "肺活量")
    private Long vitalCapacity;

    /** 50米 */
    @Excel(name = "50米")
    private Double fiftyRun;

    /** 跳远 */
    @Excel(name = "跳远")
    private Long longJump;

    /** 坐位体前驱 */
    @Excel(name = "坐位体前驱")
    private Double sittingBodyBend;

    /** 耐力跑 */
    @Excel(name = "耐力跑")
    private Double enduranceRunning;

    /** 仰卧起坐 */
    @Excel(name = "仰卧起坐")
    private Long abdominalCurl;

    /** 引体向上 */
    @Excel(name = "引体向上")
    private Long pullUp;

    /** 是否免测 */
    @Excel(name = "是否免测")
    private Long isFree;

    /** 创建人 */
    @Excel(name = "创建人")
    private Long createUid;

    /** 最后修改的人 */
    @Excel(name = "最后修改的人")
    private Long updateUid;

    /** 年级 */
    @Excel(name = "年级")
    private String grade;

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
    public void setHeight(Long height)
    {
        this.height = height;
    }

    public Long getHeight()
    {
        return height;
    }
    public void setWeight(Long weight)
    {
        this.weight = weight;
    }

    public Long getWeight()
    {
        return weight;
    }
    public void setLeftEye(Double leftEye)
    {
        this.leftEye = leftEye;
    }

    public Double getLeftEye()
    {
        return leftEye;
    }
    public void setRightEye(Double rightEye)
    {
        this.rightEye = rightEye;
    }

    public Double getRightEye()
    {
        return rightEye;
    }
    public void setVitalCapacity(Long vitalCapacity)
    {
        this.vitalCapacity = vitalCapacity;
    }

    public Long getVitalCapacity()
    {
        return vitalCapacity;
    }
    public void setFiftyRun(Double fiftyRun)
    {
        this.fiftyRun = fiftyRun;
    }

    public Double getFiftyRun()
    {
        return fiftyRun;
    }
    public void setLongJump(Long longJump)
    {
        this.longJump = longJump;
    }

    public Long getLongJump()
    {
        return longJump;
    }
    public void setSittingBodyBend(Double sittingBodyBend)
    {
        this.sittingBodyBend = sittingBodyBend;
    }

    public Double getSittingBodyBend()
    {
        return sittingBodyBend;
    }
    public void setEnduranceRunning(Double enduranceRunning)
    {
        this.enduranceRunning = enduranceRunning;
    }

    public Double getEnduranceRunning()
    {
        return enduranceRunning;
    }
    public void setAbdominalCurl(Long abdominalCurl)
    {
        this.abdominalCurl = abdominalCurl;
    }

    public Long getAbdominalCurl()
    {
        return abdominalCurl;
    }
    public void setPullUp(Long pullUp)
    {
        this.pullUp = pullUp;
    }

    public Long getPullUp()
    {
        return pullUp;
    }
    public void setIsFree(Long isFree)
    {
        this.isFree = isFree;
    }

    public Long getIsFree()
    {
        return isFree;
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
    public void setGrade(String grade)
    {
        this.grade = grade;
    }

    public String getGrade()
    {
        return grade;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
                .append("id", getId())
                .append("userId", getUserId())
                .append("height", getHeight())
                .append("weight", getWeight())
                .append("leftEye", getLeftEye())
                .append("rightEye", getRightEye())
                .append("vitalCapacity", getVitalCapacity())
                .append("fiftyRun", getFiftyRun())
                .append("longJump", getLongJump())
                .append("sittingBodyBend", getSittingBodyBend())
                .append("enduranceRunning", getEnduranceRunning())
                .append("abdominalCurl", getAbdominalCurl())
                .append("pullUp", getPullUp())
                .append("isFree", getIsFree())
                .append("remark", getRemark())
                .append("createUid", getCreateUid())
                .append("createTime", getCreateTime())
                .append("updateUid", getUpdateUid())
                .append("updateTime", getUpdateTime())
                .append("grade", getGrade())
                .toString();
    }
}