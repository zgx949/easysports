package com.ruoyi.system.service;

import java.util.List;

import com.ruoyi.system.domain.Dict;
import com.ruoyi.system.domain.SportGames;

/**
 * 比赛管理Service接口
 *
 * @author ruoyi
 * @date 2022-07-05
 */
public interface ISportGamesService
{
    /**
     * 查询比赛管理
     *
     * @param id 比赛管理主键
     * @return 比赛管理
     */
    public SportGames selectSportGamesById(Long id);

    /**
     * 查询比赛预决赛字典信息
     *
     * @return 比赛管理
     */
    public List<Dict> selectSportGamesDict();

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
     * 批量删除比赛管理
     *
     * @param ids 需要删除的比赛管理主键集合
     * @return 结果
     */
    public int deleteSportGamesByIds(Long[] ids);

    /**
     * 删除比赛管理信息
     *
     * @param id 比赛管理主键
     * @return 结果
     */
    public int deleteSportGamesById(Long id);
}
