package com.ruoyi.system.domain.Vo;


import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.annotation.Excel;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

@Data
public class GameResultVo implements Serializable {

    private String username;

    private int points;

    private int order;

    private String deptName;

    private String nickName;

    private int score;

    private int type;

    private String unit;

    /** 开始时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "开始时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date startTime;


}
