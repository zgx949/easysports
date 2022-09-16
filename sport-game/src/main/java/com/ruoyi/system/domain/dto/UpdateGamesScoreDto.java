package com.ruoyi.system.domain.dto;

import com.ruoyi.common.core.domain.BaseEntity;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * @Description 录入成绩 及 成绩校验
 * @Author coder_jlt
 * @Data 2022/9/13 10:25
 */
@Data
public class UpdateGamesScoreDto extends BaseEntity implements Serializable  {

    private static final long serialVersionUID = 1L;

    private Long userId;

    private Long gameId;

    private Long points;

    private Long score;

    private String unit;

    private String comment;

//    private Date updateTime;

}
