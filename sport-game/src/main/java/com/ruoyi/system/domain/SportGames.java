package com.ruoyi.system.domain;

import java.util.List;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 比赛管理对象 sport_games
 *
 * @author ruoyi
 * @date 2022-07-05
 */
public class SportGames extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** id */
    private Long id;

    /** 项目 */
    @Excel(name = "项目")
    private Long itemId;

    /** 比赛名 */
    @Excel(name = "比赛名")
    private String gameName;

    /** 决赛 */
    @Excel(name = "决赛编码")
    private Long nextGame;

    /** 性别 */
    @Excel(name = "性别")
    private Integer gender;

    /** 场地 */
    @Excel(name = "场地编码")
    private Long fieldId;

    /** 限制人数 */
    @Excel(name = "限制人数")
    private Long maxPerson;

    /** 状态 */
    @Excel(name = "状态")
    private Long status;

    /** 开始时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "开始时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date startTime;

    /** 结束时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "结束时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date endTime;

    /** 项目管理信息 */
    private List<SportItem> sportItemList;

    /** 场地 */
//    @Excel(name = "")
    private SportFields field;

    /** 决赛 */
//    @Excel(name = "决赛")
    private SportGames game;

    public SportFields getField() {
        return field;
    }

    public void setField(SportFields field) {
        this.field = field;
    }

    public SportGames getGame() {
        return game;
    }

    public void setGame(SportGames game) {
        this.game = game;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    public Long getId()
    {
        return id;
    }
    public void setItemId(Long itemId)
    {
        this.itemId = itemId;
    }

    public Long getItemId()
    {
        return itemId;
    }
    public void setGameName(String gameName)
    {
        this.gameName = gameName;
    }

    public String getGameName()
    {
        return gameName;
    }
    public void setNextGame(Long nextGame)
    {
        this.nextGame = nextGame;
    }

    public Long getNextGame()
    {
        return nextGame;
    }
    public void setGender(Integer gender)
    {
        this.gender = gender;
    }

    public Integer getGender()
    {
        return gender;
    }
    public void setFieldId(Long fieldId)
    {
        this.fieldId = fieldId;
    }

    public Long getFieldId()
    {
        return fieldId;
    }
    public void setMaxPerson(Long maxPerson)
    {
        this.maxPerson = maxPerson;
    }

    public Long getMaxPerson()
    {
        return maxPerson;
    }
    public void setStatus(Long status)
    {
        this.status = status;
    }

    public Long getStatus()
    {
        return status;
    }
    public void setStartTime(Date startTime)
    {
        this.startTime = startTime;
    }

    public Date getStartTime()
    {
        return startTime;
    }
    public void setEndTime(Date endTime)
    {
        this.endTime = endTime;
    }

    public Date getEndTime()
    {
        return endTime;
    }

    public List<SportItem> getSportItemList()
    {
        return sportItemList;
    }

    public void setSportItemList(List<SportItem> sportItemList)
    {
        this.sportItemList = sportItemList;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("itemId", getItemId())
            .append("gameName", getGameName())
            .append("nextGame", getNextGame())
            .append("gender", getGender())
            .append("fieldId", getFieldId())
            .append("maxPerson", getMaxPerson())
            .append("status", getStatus())
            .append("startTime", getStartTime())
            .append("endTime", getEndTime())
            .append("createTime", getCreateTime())
            .append("sportItemList", getSportItemList())
            .toString();
    }
}
