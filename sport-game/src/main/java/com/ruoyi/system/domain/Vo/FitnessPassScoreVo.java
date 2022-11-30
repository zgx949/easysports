package com.ruoyi.system.domain.Vo;

import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;
import com.ruoyi.system.domain.FitnessTestScore;

import java.io.Serializable;

public class FitnessPassScoreVo implements Serializable {
    private String activityName;

    @Excel(name = "身高")
    private Long height;

    /** 体重 */
    private Long weight;

    /** 左眼 */
    private Float leftEye;

    /** 右眼 */
    private Float rightEye;

    /** 肺活量 */
    private Boolean vitalCapacityPass;

    /** 50米 */
    private Boolean fiftyRunPass;

    /** 跳远 */
    private Boolean longJumpPass;

    /** 坐位体前驱 */
    private Boolean sittingBodyBendPass;

    /** 耐力跑 */
    private Boolean enduranceRunningPass;

    /** 耐力跑 */
    private Boolean otherItemPass;

    private FitnessTestScore score;

    public FitnessTestScore getScore() {
        return score;
    }

    public void setScore(FitnessTestScore score) {
        this.score = score;
    }

    public String getActivityName() {
        return activityName;
    }

    public void setActivityName(String activityName) {
        this.activityName = activityName;
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

    public Boolean getVitalCapacityPass() {
        return vitalCapacityPass;
    }

    public void setVitalCapacityPass(Boolean vitalCapacityPass) {
        this.vitalCapacityPass = vitalCapacityPass;
    }

    public Boolean getFiftyRunPass() {
        return fiftyRunPass;
    }

    public void setFiftyRunPass(Boolean fiftyRunPass) {
        this.fiftyRunPass = fiftyRunPass;
    }

    public Boolean getLongJumpPass() {
        return longJumpPass;
    }

    public void setLongJumpPass(Boolean longJumpPass) {
        this.longJumpPass = longJumpPass;
    }

    public Boolean getSittingBodyBendPass() {
        return sittingBodyBendPass;
    }

    public void setSittingBodyBendPass(Boolean sittingBodyBendPass) {
        this.sittingBodyBendPass = sittingBodyBendPass;
    }

    public Boolean getEnduranceRunningPass() {
        return enduranceRunningPass;
    }

    public void setEnduranceRunningPass(Boolean enduranceRunningPass) {
        this.enduranceRunningPass = enduranceRunningPass;
    }

    public Boolean getOtherItemPass() {
        return otherItemPass;
    }

    public void setOtherItemPass(Boolean otherItemPass) {
        this.otherItemPass = otherItemPass;
    }
}
