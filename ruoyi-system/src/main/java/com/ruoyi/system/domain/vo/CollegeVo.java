package com.ruoyi.system.domain.vo;

import com.ruoyi.common.core.domain.BaseEntity;
import lombok.Data;

/**
 * 部门表 sys_dept
 * 
 * @author ruoyi
 */
@Data
public class CollegeVo extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 学院ID */
    private Long deptId;

    /** 学院名称 */
    private String deptName;


}
