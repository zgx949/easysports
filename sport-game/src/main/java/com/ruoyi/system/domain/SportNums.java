package com.ruoyi.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 号码段管理对象 sport_nums
 *
 * @author ruoyi
 * @date 2022-07-06
 */
public class SportNums extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /**  */
    private Long id;

    /**  */
    @Excel(name = "")
    private Long idNum;

    /**  */
    @Excel(name = "")
    private Long userId;

    public void setId(Long id)
    {
        this.id = id;
    }

    public Long getId()
    {
        return id;
    }
    public void setIdNum(Long idNum)
    {
        this.idNum = idNum;
    }

    public Long getIdNum()
    {
        return idNum;
    }
    public void setUserId(Long userId)
    {
        this.userId = userId;
    }

    public Long getUserId()
    {
        return userId;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
                .append("id", getId())
                .append("idNum", getIdNum())
                .append("userId", getUserId())
                .toString();
    }
}
