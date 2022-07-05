package com.ruoyi.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 项目管理对象 sport_item
 * 
 * @author ruoyi
 * @date 2022-07-05
 */
public class SportItem extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 自增id */
    private Long id;

    /** 项目名称 */
    @Excel(name = "项目名称")
    private String itemName;

    /** 限制最多人数 */
    @Excel(name = "限制最多人数")
    private Long maxPerson;

    /** 项目类型（田赛、径赛、团体赛等） */
    @Excel(name = "项目类型", readConverterExp = "田=赛、径赛、团体赛等")
    private Long type;

    /** 成绩单位 */
    @Excel(name = "成绩单位")
    private String unit;

    /** 是否降序排序 */
    @Excel(name = "是否降序排序")
    private Long isDesc;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }
    public void setItemName(String itemName) 
    {
        this.itemName = itemName;
    }

    public String getItemName() 
    {
        return itemName;
    }
    public void setMaxPerson(Long maxPerson) 
    {
        this.maxPerson = maxPerson;
    }

    public Long getMaxPerson() 
    {
        return maxPerson;
    }
    public void setType(Long type) 
    {
        this.type = type;
    }

    public Long getType() 
    {
        return type;
    }
    public void setUnit(String unit) 
    {
        this.unit = unit;
    }

    public String getUnit() 
    {
        return unit;
    }
    public void setIsDesc(Long isDesc) 
    {
        this.isDesc = isDesc;
    }

    public Long getIsDesc() 
    {
        return isDesc;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("itemName", getItemName())
            .append("maxPerson", getMaxPerson())
            .append("type", getType())
            .append("unit", getUnit())
            .append("isDesc", getIsDesc())
            .toString();
    }
}
