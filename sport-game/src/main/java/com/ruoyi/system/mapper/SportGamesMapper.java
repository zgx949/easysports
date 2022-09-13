package com.ruoyi.system.mapper;

import java.util.List;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ruoyi.common.core.domain.Dict;
import com.ruoyi.system.domain.Vo.GameInsertVo;
import com.ruoyi.system.domain.Vo.GameResultVo;
import com.ruoyi.system.domain.SportGames;
import com.ruoyi.system.domain.SportItem;
import org.springframework.stereotype.Repository;

/**
 * 比赛管理Mapper接口
 *
 * @author ruoyi
 * @date 2022-07-05
 */
@Repository
public interface SportGamesMapper extends BaseMapper<SportGames>
{
    /**
     * 获取报名比赛的必要信息
     *
     * @return 结果
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

    /**
     * 获取比赛字典
     *
     * @return 结果
     */
    public List<Dict> selectSportGamesDict();

    public List<GameResultVo> selectSportResultByGameId(Long gameId);


    List<GameInsertVo> SelectGameInsertVoByGameId(Long gameId);
}
