package com.ruoyi.system.domain.Vo;

import com.ruoyi.common.annotation.Excel;

public class FitnessPassScoreVo {
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

}
