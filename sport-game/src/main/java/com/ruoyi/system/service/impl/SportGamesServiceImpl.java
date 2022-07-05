package com.ruoyi.system.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
import com.ruoyi.common.utils.StringUtils;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.system.domain.SportItem;
import com.ruoyi.system.mapper.SportGamesMapper;
import com.ruoyi.system.domain.SportGames;
import com.ruoyi.system.service.ISportGamesService;

/**
 * 比赛管理Service业务层处理
 *
 * @author ruoyi
 * @date 2022-07-05
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
    @Transactional
    @Override
    public int insertSportGames(SportGames sportGames)
    {
        sportGames.setCreateTime(DateUtils.getNowDate());
        int rows = sportGamesMapper.insertSportGames(sportGames);
        insertSportItem(sportGames);
        return rows;
    }

    /**
     * 修改比赛管理
     *
     * @param sportGames 比赛管理
     * @return 结果
     */
    @Transactional
    @Override
    public int updateSportGames(SportGames sportGames)
    {
        sportGamesMapper.deleteSportItemByItemName(sportGames.getId());
        insertSportItem(sportGames);
        return sportGamesMapper.updateSportGames(sportGames);
    }

    /**
     * 批量删除比赛管理
     *
     * @param ids 需要删除的比赛管理主键
     * @return 结果
     */
    @Transactional
    @Override
    public int deleteSportGamesByIds(Long[] ids)
    {
        sportGamesMapper.deleteSportItemByItemNames(ids);
        return sportGamesMapper.deleteSportGamesByIds(ids);
    }

    /**
     * 删除比赛管理信息
     *
     * @param id 比赛管理主键
     * @return 结果
     */
    @Transactional
    @Override
    public int deleteSportGamesById(Long id)
    {
        sportGamesMapper.deleteSportItemByItemName(id);
        return sportGamesMapper.deleteSportGamesById(id);
    }

    /**
     * 新增项目管理信息
     *
     * @param sportGames 比赛管理对象
     */
    public void insertSportItem(SportGames sportGames)
    {
        List<SportItem> sportItemList = sportGames.getSportItemList();
        Long id = sportGames.getId();
        if (StringUtils.isNotNull(sportItemList))
        {
            List<SportItem> list = new ArrayList<SportItem>();
            for (SportItem sportItem : sportItemList)
            {
                sportItem.setItemName(String.valueOf(id));
                list.add(sportItem);
            }
            if (list.size() > 0)
            {
                sportGamesMapper.batchSportItem(list);
            }
        }
    }
}
