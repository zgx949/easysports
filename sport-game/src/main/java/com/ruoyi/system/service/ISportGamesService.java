package com.ruoyi.system.service;

import java.util.List;

import com.ruoyi.common.core.domain.Dict;
import com.ruoyi.system.domain.Vo.GameInsertVo;
import com.ruoyi.system.domain.Vo.GameResultVo;
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
     * 查询比赛预决赛字典信息
     *
     * @return 比赛管理
     */
    public List<Dict> selectSportGamesRegisterDict();

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

    /**
     * 根据比赛id查询比赛结果
     */
    List<GameResultVo> selectGameResultByGameId(Long gameId);

    /**
     * @Description 根据比赛id查询待记录分数人员
     * @Param id
     * @Return {@link List<GameInsertVo>}
     * @Author coder_jlt
     * @Date 2022/9/13 08:12
     */
    List<GameInsertVo> SelectGameInsertVoByGameId(Long gameId);

    List<GameInsertVo> SelectGameInsertVoByUserId(Long userId);
}
