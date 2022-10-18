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
    private Float leftEye;

    /** 右眼 */
    @Excel(name = "右眼")
    private Float rightEye;

    /** 肺活量 */
    @Excel(name = "肺活量")
    private Long vitalCapacity;

    /** 50米 */
    @Excel(name = "50米")
    private Float fiftyRun;

    /** 跳远 */
    @Excel(name = "跳远")
    private Long longJump;

    /** 坐位体前驱 */
    @Excel(name = "坐位体前驱")
    private Float sittingBodyBend;

    /** 耐力跑 */
    @Excel(name = "耐力跑")
    private Float enduranceRunning;

    /** 活动id */
    @Excel(name = "活动id")
    private Long ftaId;

    /** 附加项目：引体向上/仰卧起坐 */
    @Excel(name = "附加项目：引体向上/仰卧起坐")
    private Long otherItem;

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

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public Long getHeight() {
        return height;
    }

    public void setHeight(Long height) {
        this.height = height;
    }

    public Long getWeight() {
        return weight;
    }

    public void setWeight(Long weight) {
        this.weight = weight;
    }

    public Float getLeftEye() {
        return leftEye;
    }

    public void setLeftEye(Float leftEye) {
        this.leftEye = leftEye;
    }

    public Float getRightEye() {
        return rightEye;
    }

    public void setRightEye(Float rightEye) {
        this.rightEye = rightEye;
    }

    public Long getVitalCapacity() {
        return vitalCapacity;
    }

    public void setVitalCapacity(Long vitalCapacity) {
        this.vitalCapacity = vitalCapacity;
    }

    public Float getFiftyRun() {
        return fiftyRun;
    }

    public void setFiftyRun(Float fiftyRun) {
        this.fiftyRun = fiftyRun;
    }

    public Long getLongJump() {
        return longJump;
    }

    public void setLongJump(Long longJump) {
        this.longJump = longJump;
    }

    public Float getSittingBodyBend() {
        return sittingBodyBend;
    }

    public void setSittingBodyBend(Float sittingBodyBend) {
        this.sittingBodyBend = sittingBodyBend;
    }

    public Float getEnduranceRunning() {
        return enduranceRunning;
    }

    public void setEnduranceRunning(Float enduranceRunning) {
        this.enduranceRunning = enduranceRunning;
    }

    public Long getFtaId() {
        return ftaId;
    }

    public void setFtaId(Long ftaId) {
        this.ftaId = ftaId;
    }

    public Long getOtherItem() {
        return otherItem;
    }

    public void setOtherItem(Long otherItem) {
        this.otherItem = otherItem;
    }

    public Long getIsFree() {
        return isFree;
    }

    public void setIsFree(Long isFree) {
        this.isFree = isFree;
    }

    public Long getCreateUid() {
        return createUid;
    }

    public void setCreateUid(Long createUid) {
        this.createUid = createUid;
    }

    public Long getUpdateUid() {
        return updateUid;
    }

    public void setUpdateUid(Long updateUid) {
        this.updateUid = updateUid;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
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
                .append("ftaId", getFtaId())
                .append("otherItem", getOtherItem())
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
