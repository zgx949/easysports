package com.ruoyi.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.TreeEntity;

/**
 * 场地管理对象 sport_fields
 * 
 * @author ruoyi
 * @date 2022-06-30
 */
public class SportFields extends TreeEntity
{
    private static final long serialVersionUID = 1L;

    /** id */
    private Long id;

    /** 场地名 */
    @Excel(name = "场地名")
    private String name;

    /** 人数限制 */
    @Excel(name = "人数限制")
    private Long maxPerson;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }
    public void setName(String name) 
    {
        this.name = name;
    }

    public String getName() 
    {
        return name;
    }
    public void setMaxPerson(Long maxPerson) 
    {
        this.maxPerson = maxPerson;
    }

    public Long getMaxPerson() 
    {
        return maxPerson;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("name", getName())
            .append("maxPerson", getMaxPerson())
            .append("parentId", getParentId())
            .toString();
    }
}
