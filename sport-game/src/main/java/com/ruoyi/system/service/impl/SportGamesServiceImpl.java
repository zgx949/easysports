package com.ruoyi.system.service.impl;

import java.util.Date;
import java.util.List;

import com.ruoyi.common.constant.Constants;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.core.domain.Dict;
import com.ruoyi.common.utils.MessageUtils;
import com.ruoyi.framework.manager.AsyncManager;
import com.ruoyi.framework.manager.factory.AsyncFactory;
import com.ruoyi.system.domain.GameResultVo;
import com.ruoyi.system.mapper.SportItemMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
import java.util.TimerTask;
import java.util.concurrent.TimeUnit;

import com.ruoyi.common.utils.StringUtils;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.system.domain.SportItem;
import com.ruoyi.system.mapper.SportGamesMapper;
import com.ruoyi.system.domain.SportGames;
import com.ruoyi.system.service.ISportGamesService;
import org.springframework.util.CollectionUtils;

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

    @Autowired
    private SportItemMapper sportItemMapper;

    @Autowired
    private RedisCache redisCache;

    /**
     * 获取报名比赛的必要信息
     *
     * @return 比赛管理
     */
    @Override
    public List<Dict> selectSportGamesRegisterDict() {
        return sportGamesMapper.selectSportGamesRegisterDict();
    }

    /**
     * 查询比赛预决赛字典信息
     *
     * @return 比赛管理
     */
    @Override
    public List<Dict> selectSportGamesDict() {
        return sportGamesMapper.selectSportGamesDict();
    }

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
     * @Description 查询所有比赛管理列表
     * @Param sportGames
     * @Return {@link List< SportGames>}
     * @Author coder_jlt
     * @Date 2022/9/12 08:43
     */
    @Override
    public List<SportGames> selectSportGamesList(SportGames sportGames)
    {
        List<SportGames> sportGamess = sportGamesMapper.selectSportGamesList(sportGames);
        updateStatus(sportGamess);
        return sportGamess;
    }

    /**
     * @Description 异步更新数据库中的status
     * @Param sportGamess
     * @Return
     * @Author coder_jlt
     * @Date 2022/9/12 08:54
     */
    private void updateStatus(List<SportGames> sportGamess) {
        Date now = new Date();
        for (SportGames games : sportGamess) {
            if(games.getStartTime().after(now)){
                games.setStatus(0L);
            }
            else if (games.getEndTime().before(now)){
                games.setStatus(3L);
            }else {
                games.setStatus(2L);
            }
        }
        //异步更新
        AsyncManager.me().execute(anyscUpdateStatus(sportGamess));
    }

    /**
     * @Description 异步刷新status
     * @Param sportGamess
     * @Return {@link TimerTask}
     * @Author coder_jlt
     * @Date 2022/9/12 09:16
     */
    private TimerTask anyscUpdateStatus(List<SportGames> sportGamess){
        return new TimerTask() {
            @Override
            public void run() {
                for (SportGames games : sportGamess) {
                    sportGamesMapper.updateSportGames(games);
                }
            }
        };
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
        // 项目ID不为空
        Long itemId = sportGames.getItemId();
        if (itemId != null) {

            SportItem sportItem = sportItemMapper.selectSportItemById(itemId);

            String itemName = sportItem.getItemName();

            StringBuilder gameName = new StringBuilder("【")
                    .append(sportGames.getGender().equals(0)? "男": "女")
                    .append("子】")
                    .append(itemName)
                    .append(sportGames.getNextGame() == null || sportGames.getNextGame().equals(0L)? "(决赛)":"(预赛)");

            // 格式化比赛名字
            sportGames.setGameName(gameName.toString());
            // 设置创建时间
            sportGames.setCreateTime(DateUtils.getNowDate());

            // 决赛ID为空, 默认为决赛0
            if (sportGames.getNextGame() == null) {
                sportGames.setNextGame(0L);
            }
            int rows = sportGamesMapper.insertSportGames(sportGames);
            insertSportItem(sportGames);
            return rows;
        } else {
            return 0;
        }

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
//        sportGamesMapper.deleteSportItemByItemName(sportGames.getId());
//        insertSportItem(sportGames);
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
     * @Description 根据gameId查询比赛结果
     *
     * @Param gameId
     * @Return {@link List< GameResultVo>}
     * @Author coder_jlt
     * @Date 2022/9/12 08:38
     */
    @Override
    public List<GameResultVo> selectGameResultByGameId(Long gameId) {
        //根据id设置缓存key
        String redisKey = "sport:game:result:" + gameId;
        //若命中缓存，则取缓存返回
        if(!CollectionUtils.isEmpty(redisCache.getCacheList(redisKey))){
            return redisCache.getCacheList(redisKey);
        }
        List<GameResultVo> gameResultVos = sportGamesMapper.selectSportResultByGameId(gameId);
        if (CollectionUtils.isEmpty(gameResultVos)){
            throw new ServiceException("比赛还未结束或成绩暂未录入，请稍等");
        }
        //设置排名字段
        for (int i = 0; i < gameResultVos.size(); i++) {
            gameResultVos.get(i).setOrder(i+1);
        }
        //写缓存
        //如果写缓存失败则记录日志
        if(redisCache.setCacheList(redisKey, gameResultVos) == 0L){
            AsyncManager.me().execute(AsyncFactory.recordLogininfor("system","err","记录缓存失败"));
        }
        //如果设置缓存时间失败则删除缓存，防止脏数据
        if(!redisCache.expire(redisKey, 24 * 60, TimeUnit.HOURS)){
            redisCache.deleteObject(redisKey);
        }
        return gameResultVos;
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
