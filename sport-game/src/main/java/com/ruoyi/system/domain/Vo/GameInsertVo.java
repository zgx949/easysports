package com.ruoyi.system.domain.Vo;


import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;
import lombok.Data;

import java.util.Date;

@Data
public class GameInsertVo extends BaseEntity {

    private String username;

    private Integer userId;

    private Integer gameId;

    private Integer points;

//    private int order;

    private String gameName;

    private String deptName;

    private String nickName;

    private Integer score;

    private int type;

    private String unit;

    private String comment;
    /** 开始时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "开始时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date startTime;
}
