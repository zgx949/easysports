package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.SportGames;
import com.ruoyi.system.domain.SportItem;

/**
 * 比赛管理Mapper接口
 * 
 * @author ruoyi
 * @date 2022-07-05
 */
public interface SportGamesMapper 
{
    /**
     * 查询比赛管理
     * 
     * @param id 比赛管理主键
     * @return 比赛管理
     */
    public SportGames selectSportGamesById(Long id);

    /**
     * 查询比赛管理列表
     * 
     * @param sportGames 比赛管理
     * @return 比赛管理集合
     */
    public List<SportGames> selectSportGamesList(SportGames sportGames);

    /**
     * 新增比赛管理
     * 
     * @param sportGames 比赛管理
     * @return 结果
     */
    public int insertSportGames(SportGames sportGames);

    /**
     * 修改比赛管理
     * 
     * @param sportGames 比赛管理
     * @return 结果
     */
    public int updateSportGames(SportGames sportGames);

    /**
     * 删除比赛管理
     * 
     * @param id 比赛管理主键
     * @return 结果
     */
    public int deleteSportGamesById(Long id);

    /**
     * 批量删除比赛管理
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteSportGamesByIds(Long[] ids);

    /**
     * 批量删除项目管理
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteSportItemByItemNames(Long[] ids);
    
    /**
     * 批量新增项目管理
     * 
     * @param sportItemList 项目管理列表
     * @return 结果
     */
    public int batchSportItem(List<SportItem> sportItemList);
    

    /**
     * 通过比赛管理主键删除项目管理信息
     * 
     * @param id 比赛管理ID
     * @return 结果
     */
    public int deleteSportItemByItemName(Long id);
}
