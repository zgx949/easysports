package com.ruoyi.system.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.SportGamesMapper;
import com.ruoyi.system.domain.SportGames;
import com.ruoyi.system.service.ISportGamesService;

/**
 * 比赛管理Service业务层处理
 * 
 * @author ruoyi
 * @date 2022-06-30
 */
@Service
public class SportGamesServiceImpl implements ISportGamesService 
{
    @Autowired
    private SportGamesMapper sportGamesMapper;

    /**
     * 查询比赛管理
     * 
     * @param id 比赛管理主键
     * @return 比赛管理
     */
    @Override
    public SportGames selectSportGamesById(Long id)
    {
        return sportGamesMapper.selectSportGamesById(id);
    }

    /**
     * 查询比赛管理列表
     * 
     * @param sportGames 比赛管理
     * @return 比赛管理
     */
    @Override
    public List<SportGames> selectSportGamesList(SportGames sportGames)
    {
        return sportGamesMapper.selectSportGamesList(sportGames);
    }

    /**
     * 新增比赛管理
     * 
     * @param sportGames 比赛管理
     * @return 结果
     */
    @Override
    public int insertSportGames(SportGames sportGames)
    {
        sportGames.setCreateTime(DateUtils.getNowDate());
        return sportGamesMapper.insertSportGames(sportGames);
    }

    /**
     * 修改比赛管理
     * 
     * @param sportGames 比赛管理
     * @return 结果
     */
    @Override
    public int updateSportGames(SportGames sportGames)
    {
        return sportGamesMapper.updateSportGames(sportGames);
    }

    /**
     * 批量删除比赛管理
     * 
     * @param ids 需要删除的比赛管理主键
     * @return 结果
     */
    @Override
    public int deleteSportGamesByIds(Long[] ids)
    {
        return sportGamesMapper.deleteSportGamesByIds(ids);
    }

    /**
     * 删除比赛管理信息
     * 
     * @param id 比赛管理主键
     * @return 结果
     */
    @Override
    public int deleteSportGamesById(Long id)
    {
        return sportGamesMapper.deleteSportGamesById(id);
    }
}
