package com.ruoyi.system.service.impl;

import java.util.*;

import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.core.domain.Dict;
import com.ruoyi.framework.manager.AsyncManager;
import com.ruoyi.framework.manager.factory.AsyncFactory;
import com.ruoyi.system.domain.Vo.GameInsertVo;
import com.ruoyi.system.domain.Vo.GameResultVo;
import com.ruoyi.system.mapper.SportItemMapper;
import com.ruoyi.system.service.ISportItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.concurrent.TimeUnit;

import com.ruoyi.common.utils.StringUtils;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.system.domain.SportItem;
import com.ruoyi.system.mapper.SportGamesMapper;
import com.ruoyi.system.domain.SportGames;
import com.ruoyi.system.service.ISportGamesService;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;

/**
 * 比赛管理Service业务层处理
 *
 * @author ruoyi
 * @date 2022-07-05
 */
@Service
public class SportGamesServiceImpl implements ISportGamesService {


    @Autowired
    private SportGamesMapper sportGamesMapper;

    @Autowired
    private SportItemMapper sportItemMapper;

    @Autowired
    private RedisCache redisCache;

    @Resource
    private ISportItemService sportItemService;

    @Resource
    private ISportGamesService sportGamesService;

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
    public SportGames selectSportGamesById(Long id) {
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
    public List<SportGames> selectSportGamesList(SportGames sportGames) {
        List<SportGames> sportGamess = sportGamesMapper.selectSportGamesList(sportGames);
        //updateStatus(sportGamess);
        return sportGamess;
    }

    /**
     * @Description 异步更新数据库中的status
     * @Param sportGamess
     * @Return
     * @Author coder_jlt
     * @Date 2022/9/12 08:54
     */
    @Deprecated
    private void updateStatus(List<SportGames> sportGamess) {
        Date now = new Date();
        boolean isUpdate = false;
        // TODO 此处可能NPE异常
        for (SportGames games : sportGamess) {
            //根据时间设置比赛状态
            //若需要修改，则标记isUpdate为true 异步更新数据库
            if (games.getStartTime() == null) continue;
            if (games.getStartTime().after(now)) {
                if (games.getStatus() != 0L) {
                    games.setStatus(0L);
                    isUpdate = true;
                }
            } else if (games.getEndTime().before(now)) {
                if (games.getStatus() != 3L) {
                    games.setStatus(3L);
                    isUpdate = true;
                }
            } else {
                if (games.getStatus() != 2L) {
                    games.setStatus(2L);
                    isUpdate = true;
                }
            }
        }
        //异步更新
        if (isUpdate) {
            AsyncManager.me().execute(anyscUpdateStatus(sportGamess));
        }
    }

    /**
     * @Description 异步刷新status
     * @Param sportGamess
     * @Return {@link TimerTask}
     * @Author coder_jlt
     * @Date 2022/9/12 09:16
     */
    private TimerTask anyscUpdateStatus(List<SportGames> sportGamess) {
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
    public int insertSportGames(SportGames sportGames) {
        // 项目ID不为空
        Long itemId = sportGames.getItemId();
        if (itemId != null) {

            SportItem sportItem = sportItemMapper.selectSportItemById(itemId);

            String itemName = sportItem.getItemName();

            StringBuilder gameName = new StringBuilder("【")
                    .append(sportGames.getGender().equals(0) ? "男" : "女")
                    .append("子】")
                    .append(itemName)
                    .append(sportGames.getNextGame() == null || sportGames.getNextGame().equals(0L) ? "(决赛)" : "(预赛)");

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
    public int updateSportGames(SportGames sportGames) {
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
    public int deleteSportGamesByIds(Long[] ids) {
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
    public int deleteSportGamesById(Long id) {
        sportGamesMapper.deleteSportItemByItemName(id);
        return sportGamesMapper.deleteSportGamesById(id);
    }


    /**
     * @Description 根据gameId查询比赛结果
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
        if (!CollectionUtils.isEmpty(redisCache.getCacheList(redisKey))) {
            return redisCache.getCacheList(redisKey);
        }
        List<GameResultVo> gameResultVos = sportGamesMapper.selectSportResultByGameId(gameId);
        if (CollectionUtils.isEmpty(gameResultVos)) {
            throw new ServiceException("比赛还未结束或成绩暂未录入，请稍等");
        }

        //根据比赛id查出比赛的item_id
        SportGames sportGames = sportGamesService.selectSportGamesById(gameId);
        Long itemId = sportGames.getItemId();
        //根据item_id查出降序还是升序
        SportItem sportItem = sportItemService.selectSportItemById(itemId);
        Long isDesc = sportItem.getIsDesc();

        //设置排名字段
        if (isDesc == 0L) {
            gameResultVos.sort(new Comparator<GameResultVo>() {
                @Override
                public int compare(GameResultVo o1, GameResultVo o2) {
                    return o1.getScore() - o2.getScore();
                }
            });
            setOrderToGameResultVo(gameResultVos);
        } else {
            setOrderToGameResultVo(gameResultVos);
        }

        //写缓存
        //如果写缓存失败则记录日志
        if (redisCache.setCacheList(redisKey, gameResultVos) == 0L) {
            AsyncManager.me().execute(AsyncFactory.recordLogininfor("system", "err", "记录缓存失败"));
        }
        //如果设置缓存时间失败则删除缓存，防止脏数据
        if (!redisCache.expire(redisKey, 2 * 60, TimeUnit.HOURS)) {
            redisCache.deleteObject(redisKey);
        }
        return gameResultVos;
    }

    /**
     * @Description 给已排序的结果集设置排名
     * @Param gameResultVos
     * @Return
     * @Author coder_jlt
     * @Date 2022/9/17 12:38
     */
    private void setOrderToGameResultVo(List<GameResultVo> gameResultVos) {
        for (int i = 0; i < gameResultVos.size(); i++) {
            if (i > 0 && gameResultVos.get(i - 1).getScore() == gameResultVos.get(i).getScore()) {
                gameResultVos.get(i).setOrder(gameResultVos.get(i-1).getOrder());
                //i++;
            } else {
                gameResultVos.get(i).setOrder(i + 1);
            }
        }
    }

    /**
     * @Description 根据比赛id查询待记录分数人员
     * @Param id
     * @Return {@link List< GameInsertVo>}
     * @Author coder_jlt
     * @Date 2022/9/13 08:55
     */
    @Override
    public List<GameInsertVo> SelectGameInsertVoByGameId(Long gameId) {
        //
        if (gameId == null) {
            throw new ServiceException("请选择比赛！！！");
        }

        List<GameInsertVo> gameInsertVos = sportGamesMapper.SelectGameInsertVoByGameId(gameId);

        if (CollectionUtils.isEmpty(gameInsertVos)) {
            throw new ServiceException("未查询到参加此比赛的运动员");
        }
        return gameInsertVos;
    }

    /**
     * @Description 根据用户学号查询待记录分数比赛
     * @Param id
     * @Return {@link List< GameInsertVo>}
     * @Author coder_jlt
     * @Date 2022/9/13 08:55
     */
    @Override
    public List<GameInsertVo> SelectGameInsertVoByUserId(Long userId) {
        //
        if (userId == null) {
            throw new ServiceException("请输入学号");
        }

        List<GameInsertVo> gameInsertVos = sportGamesMapper.SelectGameInsertVoByUserId(userId);

        if (CollectionUtils.isEmpty(gameInsertVos)) {
            throw new ServiceException("未查询到此运动员比赛信息");
        }
        return gameInsertVos;
    }

    /**
     * 新增项目管理信息
     *
     * @param sportGames 比赛管理对象
     */
    public void insertSportItem(SportGames sportGames) {
        List<SportItem> sportItemList = sportGames.getSportItemList();
        Long id = sportGames.getId();
        if (StringUtils.isNotNull(sportItemList)) {
            List<SportItem> list = new ArrayList<SportItem>();
            for (SportItem sportItem : sportItemList) {
                sportItem.setItemName(String.valueOf(id));
                list.add(sportItem);
            }
            if (list.size() > 0) {
                sportGamesMapper.batchSportItem(list);
            }
        }
    }
}
