package com.ruoyi.system.service.impl;

import com.ruoyi.common.core.domain.entity.SysDept;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.exception.ServiceException;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import java.util.*;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.system.domain.SportGames;
import com.ruoyi.system.domain.SportItem;
import com.ruoyi.system.domain.Vo.*;
import com.ruoyi.system.mapper.SportGamesMapper;
import com.ruoyi.system.utils.WordUtils;
import com.ruoyi.system.domain.dto.UpdateGamesScoreDto;
import com.ruoyi.system.domain.vo.CollegeVo;
import org.apache.commons.lang3.ObjectUtils;
import org.apache.commons.lang3.StringUtils;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.system.domain.SportGames;
import com.ruoyi.system.domain.SportItem;
import com.ruoyi.system.domain.Vo.UserSportGradeVo;
import com.ruoyi.system.service.ISportGamesService;
import com.ruoyi.system.service.ISportItemService;
import org.apache.commons.lang3.ObjectUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.SportRegistrationsMapper;
import com.ruoyi.system.domain.SportRegistrations;
import com.ruoyi.system.service.ISportRegistrationsService;

/**
 * 报名管理Service业务层处理
 *
 * @author leftHand
 * @date 2022-07-05
 */
@Service
public class SportRegistrationsServiceImpl implements ISportRegistrationsService {
    @Autowired
    private SportRegistrationsMapper sportRegistrationsMapper;

    @Autowired
    private SportItemServiceImpl sportItemService;

    @Autowired
    private SysUserServiceImpl sysUserService;

    @Autowired
    private SysDeptServiceImpl sysDeptService;

    @Autowired
    private SportGamesMapper sportGamesMapper;
    @Autowired
    private RedisCache redisCache;
    @Autowired
    private SportRegistrationsServiceImpl sportRegistrationsService;
    @Autowired
    private SportGamesServiceImpl sportGamesService;


    /**
     * 用户报名项目
     *
     * @param sportRegistrations 报名管理
     * @return 结果
     */
    @Override
    public int userInsertSportRegistrations(Map<String, String> sportRegistrations) {
        // TODO:用户报名项目
        // 学号
        Long idcard = Long.valueOf(sportRegistrations.get("idcard"));
        // 姓名
        String name = sportRegistrations.get("name");
        // 比赛ID
        Long gameId = Long.valueOf(sportRegistrations.get("gameId"));
        // 密码
        String passwd = sportRegistrations.get("password");

        return 0;
    }

    /**
     * 查询报名管理
     *
     * @param id 报名管理主键
     * @return 报名管理
     */
    @Override
    public SportRegistrations selectSportRegistrationsById(Long id) {
        return sportRegistrationsMapper.selectSportRegistrationsById(id);
    }

    /**
     * 查询报名管理列表
     *
     * @param sportRegistrations 报名管理
     * @return 报名管理
     */
    @Override
    public List<SportRegistrations> selectSportRegistrationsList(SportRegistrations sportRegistrations) {
        return sportRegistrationsMapper.selectSportRegistrationsList(sportRegistrations);
    }

    /**
     * 新增报名管理
     *
     * @param sportRegistrations 报名管理
     * @return 结果
     */
    @Override
    public int insertSportRegistrations(SportRegistrations sportRegistrations) {

        if (ObjectUtils.isNotEmpty(sportRegistrations.getScore()) || ObjectUtils.isNotEmpty(sportRegistrations.getPoints()) || ObjectUtils.isNotEmpty(sportRegistrations.getGameId())) {
            String redisKey = "sport:game:result:" + sportRegistrations.getGameId();
            redisCache.deleteObject(redisKey);
        }

        sportRegistrations.setCreateTime(DateUtils.getNowDate());
        return sportRegistrationsMapper.insertSportRegistrations(sportRegistrations);
    }

    /**
     * 修改报名管理
     *
     * @param sportRegistrations 报名管理
     * @return 结果
     */
    @Override
    public int updateSportRegistrations(SportRegistrations sportRegistrations) {

        String redisKey = "sport:game:result:" + sportRegistrationsService.selectSportRegistrationsById(sportRegistrations.getId()).getGameId();
        redisCache.deleteObject(redisKey);

        sportRegistrations.setUpdateTime(DateUtils.getNowDate());
        return sportRegistrationsMapper.updateSportRegistrations(sportRegistrations);
    }

    /**
     * 批量删除报名管理
     *
     * @param ids 需要删除的报名管理主键
     * @return 结果
     */
    @Override
    public int deleteSportRegistrationsByIds(Long[] ids) {
        // 删除涉及比赛的比赛缓存
        SportRegistrations sportRegistrations;
        String redisKey;
        for (Long id : ids) {
            sportRegistrations = sportRegistrationsMapper.selectSportRegistrationsById(id);

            redisKey = "sport:game:result:" + sportRegistrations.getGameId();

            redisCache.deleteObject(redisKey);
        }
        //删除数据
        return sportRegistrationsMapper.deleteSportRegistrationsByIds(ids);
    }

    /**
     * 删除报名管理信息
     *
     * @param id 报名管理主键
     * @return 结果
     */
    @Override
    public int deleteSportRegistrationsById(Long id) {
        return sportRegistrationsMapper.deleteSportRegistrationsById(id);
    }

    /**
     * 根据用户id和比赛id取消报名
     *
     * @param userId
     * @param gameId
     * @return
     */
    @Override
    public int deleteUserRegistrations(Long userId, Long gameId) {
        return sportRegistrationsMapper.deleteUserSportRegistrations(userId, gameId);
    }

    /**
     * 根据用户id查询比赛信息并排序
     *
     * @param sportRegistrations
     * @return
     */
    @Override
    public List<SportRegistrations> userRegisterationslist(SportRegistrations sportRegistrations) {
        return sportRegistrationsMapper.userRegisterationslist(sportRegistrations);
    }

    /**
     * 用户报名
     *
     * @param sportRegistrations
     * @return
     */
    @Override
    public int insertUserRegistrations(SportRegistrations sportRegistrations) {
        return sportRegistrationsMapper.insertUserRegistrations(sportRegistrations);
    }

    @Override
    public UserSportGradeVo selectUserSportGrade(Long gameId) {
        Long userId = SecurityUtils.getUserId();
        String redisKey = "userSportGrade:" + userId + ":" + gameId;
        UserSportGradeVo cacheObject = (UserSportGradeVo) redisCache.getCacheObject(redisKey);
        if (!ObjectUtils.isEmpty(cacheObject)) {
            return cacheObject;
        }
        SportRegistrations sportRegistrations = new SportRegistrations();
        sportRegistrations.setGameId(gameId);
        sportRegistrations.setStatus("1");
        //查询参加该比赛的所有报名并且审核通过的集合
        List<SportRegistrations> sportRegistrationsList = sportRegistrationsService.selectSportRegistrationsList(sportRegistrations);


        SportRegistrations userSportRegistrations = new SportRegistrations();//用于从集合中获得用户的报名信息
        //从中获取当前用户成绩
        for (SportRegistrations temp : sportRegistrationsList) {
            if (userId == temp.getUserId()) {
                userSportRegistrations = temp;
            }
        }

        UserSportGradeVo userSportGradeVo = new UserSportGradeVo();

        //根据比赛id查出比赛的item_id
        SportGames sportGames = sportGamesService.selectSportGamesById(gameId);
        Long itemId = sportGames.getItemId();
        //根据item_id查出降序还是升序
        SportItem sportItem = sportItemService.selectSportItemById(itemId);
        Long isDesc = sportItem.getIsDesc();

        sportGames.setItem(sportItem);
        userSportRegistrations.setGame(sportGames);
        userSportGradeVo.setSportRegistrations(userSportRegistrations);

        //根据升序降序对用户进行排名
        Long userOrder = 1L;
        for (SportRegistrations temp : sportRegistrationsList) {
            if (temp.getScore() != null) {
                if (isDesc == 1) {//降序
                    if (temp.getScore() != null && userSportRegistrations.getScore() < temp.getScore()) {
                        userOrder++;
                    }
                } else {//升序
                    if (temp.getScore() != null && userSportRegistrations.getScore() > temp.getScore()) {
                        userOrder++;
                    }
                }
            }
        }
        userSportGradeVo.setUserOrder(userOrder);
        //将用户当前成绩缓存，缓存时长设置为1h
        redisCache.setCacheObject(redisKey, userSportGradeVo, 1, TimeUnit.HOURS);
        return userSportGradeVo;
    }


    /**
     * 查询当前比赛报名人数
     *
     * @param gameId
     * @return
     */
    @Override
    public Long numOfRegistrationsGames(Long gameId) {
        return sportRegistrationsMapper.numOfRegistrationsGames(gameId);
    }

    /**
     * 判断该学院的该项目报名人数是否满额
     *
     * @param deptId
     * @param gameId
     * @param maxNum
     * @return
     */
    @Override
    public Boolean numOfCollegeRegistrationIsLegal(Long deptId, Long gameId, Long maxNum) {
        Long num = sportRegistrationsMapper.numOfCollegeRegistration(deptId, gameId);
        return num < maxNum ? true : false;
    }

    /**
     * 判断一个人报名田径比赛的预赛和预决赛是否合法
     *
     * @param userId
     * @param maxNum
     * @return
     */
    @Override
    public Boolean TrackFieldGameRegistrationIsLegal(Long userId, Long maxNum) {
        Long num = sportRegistrationsMapper.numOfPersonTrackFieldGame(userId);//用户已报名田径赛不包括接力赛的项数
        return num < maxNum ? true : false;
    }

    @Override
    public Boolean RelayGameRegistrationIsLegal(Long deptId, Long gameId, Long maxNum) {
        Long num = sportRegistrationsMapper.numOfCollectionRelayGame(deptId, gameId);
        return num < maxNum ? true : false;
    }


    /**
     * @Description: 获取用户报名信息的word行
     * @Param:
     * @return:
     * @Author: zgx
     * @Date: 2022-09-15
     */
    public String getUserRegisterRow(Long userId) {
        SportRegistrations register = new SportRegistrations();
        SysUser user = sysUserService.selectUserById(userId);

        register.setUserId(user.getUserId());
        register.setStatus("1");
        List<SportRegistrations> registerList = sportRegistrationsMapper.selectSportRegistrationsList(register);

        StringBuilder itemList = new StringBuilder();
        for (int i = 0, registerListSize = registerList.size(); i < registerListSize; i++) {
            SportRegistrations item = registerList.get(i);
            Long itemId = item.getGame().getItemId();
            SportItem sportItem = sportItemService.selectSportItemById(itemId);
            if (i == registerListSize - 1) {
                itemList.append(sportItem.getItemName());
            } else {
                itemList.append(String.format("%-7s\t", sportItem.getItemName()));
            }
        }
        RegisterReportVo registerReportVo = new RegisterReportVo();
        // TODO: 这里的号码临时先用用户名测试
        registerReportVo.setNum(user.getUserName());
        String nickName = user.getNickName();
        // 对齐表格，防止错位
        if (nickName.length() == 2) {
            nickName += "    ";
        }
        if (nickName.length() == 3) {
            nickName += "  ";
        }
        if (nickName.length() == 4) {
            nickName += "";
        }
        registerReportVo.setName(nickName);
        // TODO: 需要加一个查询岗位信息，判断是学生还是教工
        registerReportVo.setUserType("学生");
        registerReportVo.setGender(user.getSex().equals("0") ? "男" : "女");
        registerReportVo.setItemList(itemList.toString());

        StringBuilder rowText = new StringBuilder();
        rowText
                .append(registerReportVo.getNum())
                .append("    ")
                .append(registerReportVo.getName())
                .append("  ")
                .append(registerReportVo.getUserType())
                .append("   ")
                .append(registerReportVo.getGender())
                .append("   ")
                .append(registerReportVo.getItemList());

        return rowText.toString();
    }

    //String.format("%-6s", user.getNickName())

    /**
     * @Description: 获取学院代表队表格的word
     * @Param:
     * @return:
     * @Author: zgx
     * @Date: 2022-09-15
     */
    public String getDeptRegister(long deptId) {
        SysDept sysDept = sysDeptService.selectDeptById(deptId);
        String leader = sysDept != null ? sysDept.getLeader() : "未知";
        String deptName = sysDept != null ? sysDept.getDeptName() : "位置";
        // TODO: 教练暂时随便取个名
        String trainer = "张三教练";
        List<SportRegistrations> allRegister = selectSportRegistrationsList(null);
        // 标记一下已经查过的用户id
        Set<Long> set = new HashSet<>();


        List<String> rows = new LinkedList<>();
        for (SportRegistrations register : allRegister) {
            SysUser user = sysUserService.selectUserById(register.getUserId());
            // 人员属于该部门，并且还没生成数据
            if (user.getDeptId().equals(deptId) && !set.contains(user.getUserId())) {
                rows.add(getUserRegisterRow(user.getUserId()));
//                res.append(getUserRegisterRow(user.getUserId()));
                set.add(user.getUserId());
            }
        }
        String res = WordUtils.deptTable(deptName, leader, trainer, rows);
        return res;
    }

    /**
     * @Description: 获取比赛段Word
     * @Param:
     * @return:
     * @Author: leftHand
     * @Date: 2022-09-16
     */
    public String gameSlot(String startTime, String endTime, Long itemType) {
        SportGames games = new SportGames();
        games.setStartTime(DateUtils.parseDate(startTime));
        games.setEndTime(DateUtils.parseDate(endTime));
        SportItem item = new SportItem();
        item.setType(itemType);
        games.setItem(item);
        // 查询出所有该类别的比赛
        List<SportGames> gamesList = sportGamesMapper.selectSportGamesList(games);
        List<GameDescVo> gamesDescList = new LinkedList<>();
        for (SportGames sportGames : gamesList) {
            GameDescVo gd = new GameDescVo();
            String gameName = sportGames.getGameName();
            String st = DateUtils.parseDateToStr(DateUtils.YYYY_MM_DD_HH_MM_SS, sportGames.getStartTime());
            SportRegistrations registerCondition = new SportRegistrations();

            int totalPerson = sportRegistrationsMapper.count(sportGames.getId());
            // 单组人数限制
            Long groupLimit = sportGames.getMaxPerson();
            // 不允许报名的决赛
            int groupCount = 1;
            if (totalPerson == 0 && sportGamesMapper.selectCount(new QueryWrapper<SportGames>().eq("next_game", sportGames.getId())) > 0) {
                totalPerson = Math.toIntExact(groupLimit);
            } else {
                groupCount = (int) (totalPerson / groupLimit + (totalPerson % groupLimit > 0 ? 1 : 0));
            }

//            gd.setGameName(gameName);
//            gd.setGroupCount(String.valueOf(groupCount));
//            gd.setStartTime(st);
//            gd.setTotalPerson(String.valueOf(totalPerson));
//            gamesDescList.add(gd);
            gd.setGameName(String.format("%-20s\t%-15s\t%-15s\t%s",
                    gameName, groupCount + "组", totalPerson + "人", st.substring(10, 16)
            ));
            gamesDescList.add(gd);
        }
        String itemTypeName = null;
        if (itemType == 1) itemTypeName = "田赛";
        else if (itemType == 2) itemTypeName = "径赛";
        else itemTypeName = "集体项目";
        String res = WordUtils.gameList(gamesDescList, itemTypeName);
        return res;
    }

    /**
     * @Description: 获取日程表Word
     * @Param:
     * @return:
     * @Author: leftHand
     * @Date: 2022-09-16
     */
    public String getTimeOrder() {
        String startDate = sportGamesMapper.startDate();
        String endDate = sportGamesMapper.endDate();

        // 当前起点时间段
        Calendar curr = Calendar.getInstance();

        Calendar sd = Calendar.getInstance();
        sd.setTime(DateUtils.parseDate(sportGamesMapper.startDate()));
        sd.set(Calendar.HOUR_OF_DAY, 0);
        sd.set(Calendar.MINUTE, 0);
        sd.set(Calendar.SECOND, 0);

        curr.setTime(sd.getTime());

        Calendar ed = Calendar.getInstance();
        ed.setTime(DateUtils.parseDate(sportGamesMapper.endDate()));
        ed.set(Calendar.HOUR_OF_DAY, 23);
        ed.set(Calendar.MINUTE, 59);
        ed.set(Calendar.SECOND, 59);

        StringBuilder res = new StringBuilder();
        // 开始时间小于结束时间
        while (curr.before(ed)) {
            StringBuilder sb = new StringBuilder();
            sb.append(gameSlot(startDate, endDate, 1L));
            sb.append(gameSlot(startDate, endDate, 2L));
            sb.append(gameSlot(startDate, endDate, 3L));

            // 时间段标记
            String dateTag = new StringBuilder()
                    .append(curr.get(Calendar.MONTH))
                    .append("月")
                    .append(curr.get(Calendar.DAY_OF_MONTH))
                    .append("日")
                    .append(curr.get(Calendar.AM_PM) == Calendar.AM ? "上午" : "下午")
                    .toString();

            // 当前时间片段的比赛情况
            String slotGames = WordUtils.gameOrder(dateTag, sb.toString());
            // 组合到总日程中
            res.append(slotGames);

            // 如果已分片到下午
            if (curr.get(Calendar.HOUR_OF_DAY) == 12) {
                // 跳转到第二天早上
                curr.add(Calendar.DATE, 1);
                curr.set(Calendar.HOUR, 0);
                curr.set(Calendar.MINUTE, 0);
                curr.set(Calendar.SECOND, 0);
            } else {
                // 跳转到当天中午
                curr.set(Calendar.HOUR_OF_DAY, 12);
                curr.set(Calendar.MINUTE, 0);
                curr.set(Calendar.SECOND, 0);
            }
        }

        return res.toString();

    }

    /**
     * @Description: 分组安排（Word）
     * @Param:
     * @return:
     * @Author: zgx
     * @Date: 2022-09-17
     */
    public String groupAllocate(String startTime, String endTime, Long itemType) {
        SportGames games = new SportGames();
        games.setStartTime(DateUtils.parseDate(startTime));
        games.setEndTime(DateUtils.parseDate(endTime));
        SportItem item = new SportItem();
        item.setType(itemType);
        games.setItem(item);
        // 查询出所有该类别的比赛
        List<SportGames> gamesList = sportGamesMapper.selectSportGamesList(games);
        List<GameDescVo> gamesDescList = new LinkedList<>();
        // 遍历所有比赛
        for (SportGames sportGames : gamesList) {
            GameDescVo gd = new GameDescVo();
            String gameName = sportGames.getGameName();
            String st = DateUtils.parseDateToStr(DateUtils.YYYY_MM_DD_HH_MM_SS, sportGames.getStartTime());
            // 筛选报名条件
            SportRegistrations registerCondition = new SportRegistrations();
            registerCondition.setGameId(sportGames.getId());
            // 所有报名该比赛的报名表
            List<SportRegistrations> registerList = selectSportRegistrationsList(registerCondition);
            // 随机分组
            List<GameGroupDetail> gameGroupDetails = new LinkedList<>();
            Collections.shuffle(registerList);
            GameGroupDetail gameGroupDetail = null;
            for (int i = 0; i < registerList.size(); i++) {
                SportRegistrations register = registerList.get(i);
                if (i % 8 == 0) {
                    // 分完一组
                    if (i != 0) {
                        gameGroupDetails.add(gameGroupDetail);
                    }
                    gameGroupDetail = new GameGroupDetail();
                    gameGroupDetail.setGroupName(String.valueOf(i / 8 + 1));
                    gameGroupDetail.setGroupTitle("序号");
                }
                // 分组详细信息
                SysUser user = register.getUser();
                SysDept dept = sysDeptService.selectDeptById(user.getDeptId());
                if (dept.getDeptName() == null) {
                    dept.setDeptName("学院未知");
                }
                //TODO: 此处的号码直接获取了用户名
                // TODO: 需要宽度对齐
                gameGroupDetail.setNumsList(gameGroupDetail.getNumsList() + String.format("%-9s", user.getUserName().substring(0, 4)));
                if (user.getNickName().length() == 2) {
                    gameGroupDetail.setNameList(gameGroupDetail.getNameList() + String.format("%-7s", user.getNickName()));
                } else if (user.getNickName().length() == 4) {
                    gameGroupDetail.setNameList(gameGroupDetail.getNameList() + String.format("%-5s", user.getNickName()));
                } else {
                    gameGroupDetail.setNameList(gameGroupDetail.getNameList() + String.format("%-6s", user.getNickName()));
                }
                if (dept.getDeptName().length() == 4) {
                    gameGroupDetail.setDeptList(gameGroupDetail.getDeptList() + String.format("%-5s", dept.getDeptName()));
                } else {
                    gameGroupDetail.setDeptList(gameGroupDetail.getDeptList() + String.format("%-6s", dept.getDeptName()));
                }
            }

            int totalPerson = registerList.size();
            // 单组人数限制
            Long groupLimit = sportGames.getMaxPerson();
            // 不允许报名的决赛
            int groupCount = 1;
            if (totalPerson == 0 && sportGamesMapper.selectCount(new QueryWrapper<SportGames>().eq("next_game", sportGames.getId())) > 0) {
                totalPerson = Math.toIntExact(groupLimit);
            } else {
                groupCount = (int) (totalPerson / groupLimit + (totalPerson % groupLimit > 0 ? 1 : 0));
            }
            // 还有未被分组的人
            if (groupCount > gameGroupDetails.size()) {
                gameGroupDetails.add(gameGroupDetail);
            }

            gd.setGameName(gameName);
            gd.setGroupCount(String.valueOf(groupCount));
            gd.setStartTime(st);
            gd.setTotalPerson(String.valueOf(totalPerson));
            gd.setGroup(gameGroupDetails);

            gamesDescList.add(gd);
        }

        String itemTypeName = null;
        if (itemType == 1) itemTypeName = "田赛";
        else if (itemType == 2) itemTypeName = "径赛";
        else itemTypeName = "集体项目";
        String res = WordUtils.gameListDetail(gamesDescList, itemTypeName);
        return res;
    }

    /**
     * @Description: 获取分组表Word
     * @Param:
     * @return:
     * @Author: zgx
     * @Date: 2022-09-17
     */
    public String getGroupDetail() {
        String startDate = sportGamesMapper.startDate();
        String endDate = sportGamesMapper.endDate();

        // 当前起点时间段
        Calendar curr = Calendar.getInstance();

        Calendar sd = Calendar.getInstance();
        sd.setTime(DateUtils.parseDate(sportGamesMapper.startDate()));
        sd.set(Calendar.HOUR_OF_DAY, 0);
        sd.set(Calendar.MINUTE, 0);
        sd.set(Calendar.SECOND, 0);

        curr.setTime(sd.getTime());

        Calendar ed = Calendar.getInstance();
        ed.setTime(DateUtils.parseDate(sportGamesMapper.endDate()));
        ed.set(Calendar.HOUR_OF_DAY, 23);
        ed.set(Calendar.MINUTE, 59);
        ed.set(Calendar.SECOND, 59);

        StringBuilder res = new StringBuilder();
        // 开始时间小于结束时间
        while (curr.before(ed)) {
            StringBuilder sb = new StringBuilder();
            // TODO:
            sb.append(groupAllocate(startDate, endDate, 1L));
            sb.append(groupAllocate(startDate, endDate, 2L));
            sb.append(groupAllocate(startDate, endDate, 3L));

            // 时间段标记
            String dateTag = new StringBuilder()
                    .append(curr.get(Calendar.MONTH))
                    .append("月")
                    .append(curr.get(Calendar.DAY_OF_MONTH))
                    .append("日")
                    .append(curr.get(Calendar.AM_PM) == Calendar.AM ? "上午" : "下午")
                    .toString();

            // 当前时间片段的比赛情况 TODO:
            String slotGames = WordUtils.gameGroupDetail(dateTag, sb.toString());
            // 组合到总分组日程中 TODO:
            res.append(slotGames);

            // 如果已分片到下午
            if (curr.get(Calendar.HOUR_OF_DAY) == 12) {
                // 跳转到第二天早上
                curr.add(Calendar.DATE, 1);
                curr.set(Calendar.HOUR, 0);
                curr.set(Calendar.MINUTE, 0);
                curr.set(Calendar.SECOND, 0);
            } else {
                // 跳转到当天中午
                curr.set(Calendar.HOUR_OF_DAY, 12);
                curr.set(Calendar.MINUTE, 0);
                curr.set(Calendar.SECOND, 0);
            }
        }

        return res.toString();
    }


    /**
     * 生成秩序册XMl(WORD)
     *
     * @param
     * @return
     */
    @Override
    public String wordGeneration() {
        int[] deptIds = {
                104,
                105,
                106,
                107,
                108,
                109,
                200,
                201,
                202,
                203,
                204,
                205,
                206,
                208,
                209,
                210,
                211,
                212,
                213,
                214,
        };
        /* 代表队 */
        StringBuilder rows1 = new StringBuilder();
        for (int deptId : deptIds) {
            rows1.append(getDeptRegister(deptId));
        }
        HashMap<String, String> mp = new HashMap<>();
        //代表队模板
        mp.put("depthReport", rows1.toString());
        // 竞赛日程模板
        String timeOrder = getTimeOrder();
        mp.put("gamesOrders", timeOrder);
        // 竞赛分组模板
        String gamesGroups = getGroupDetail();
        mp.put("gamesGroups", gamesGroups);

        // 生成最终模板

        return WordUtils.process(mp, "/vm/sportMeeting/template.ftl").toString();
    }

    /**
     * @Description 处理更新成绩请求(删除对应成绩排名表缓存)
     * @Param updateGamesScoreDto
     * @Return
     * @Author coder_jlt
     * @Date 2022/9/13 13:18
     */
    @Override
    public boolean handleUpdateScore(UpdateGamesScoreDto updateGamesScoreDto) {

        if (!ObjectUtils.allNotNull(updateGamesScoreDto, updateGamesScoreDto.getScore(), updateGamesScoreDto.getGameId()
                , updateGamesScoreDto.getPoints(), updateGamesScoreDto.getUserId())) {
            throw new ServiceException("请输入完整数据");
        }

        if (StringUtils.isNoneBlank(updateGamesScoreDto.getComment()) && updateGamesScoreDto.getComment().length() > 255) {
            throw new ServiceException("备注信息过长");
        }

        if (updateGamesScoreDto.getScore() < 0 || updateGamesScoreDto.getPoints() < 0) {
            throw new ServiceException("成绩积分不能为负数");
        }

        SportRegistrations sportRegistrations = new SportRegistrations();
        sportRegistrations.setGameId(updateGamesScoreDto.getGameId());
        sportRegistrations.setUserId(updateGamesScoreDto.getUserId());
        sportRegistrations.setScore(updateGamesScoreDto.getScore());
        sportRegistrations.setPoints(updateGamesScoreDto.getPoints());
        sportRegistrations.setComment(updateGamesScoreDto.getComment());
        sportRegistrations.setUpdateTime(new Date());

        // 删除gameId对应比赛的排名表缓存
        redisCache.deleteObject("sport:game:result:" + updateGamesScoreDto.getGameId());

        return sportRegistrationsMapper.updateSportScoreData(sportRegistrations);
    }

    /**
     * @return
     * @Description 获取生成秩序册所需必要信息
     * @Param
     * @Return
     * @Author coder_jlt
     * @Date 2022/9/15 12:01
     */
    @Override
    public List<GameSequenceBookVO> exportGameSequenceBookVo() {
        //定义结果集
        ArrayList<GameSequenceBookVO> gameSequenceBookVOS = new ArrayList<>();

        List<CollegeVo> collegeVos = sysDeptService.selectCollegeList(new SysDept());

        for (CollegeVo collegeVo : collegeVos) {
            //mock 假数据
            GameSequenceBookVO gameSequenceBookVO = new GameSequenceBookVO();
            gameSequenceBookVO.setCoach("廖家栋");
            gameSequenceBookVO.setLeader("吕镇坤");
            gameSequenceBookVO.setPhoneNumber("18507093323");
            //设置学院
            gameSequenceBookVO.setDeptName(collegeVo.getDeptName());
            //根据学院查询秩序册信息
            ArrayList<GameSequenceItemVO> gameSequenceItemVOs = this.getGameSequenceItemVOsByDeptID(collegeVo.getDeptId());
            gameSequenceBookVO.setGameSequenceItem(gameSequenceItemVOs);
            //将数据加入结果集
            gameSequenceBookVOS.add(gameSequenceBookVO);
        }


        return gameSequenceBookVOS;
    }

    private ArrayList<GameSequenceItemVO> getGameSequenceItemVOsByDeptID(Long deptId) {
        if (ObjectUtils.isEmpty(deptId)) {
            return null;
        }
        //获取学生数据集合
        ArrayList<GameSequenceItemVO> gameSequenceItemVOs = sportRegistrationsMapper.selectGameSequenceItemVOsByDeptID(deptId);
        for (GameSequenceItemVO gameSequenceItemVO : gameSequenceItemVOs) {
            ArrayList<String> gameSequenceItemGamesName = this.getGameSequenceItemGamesVOsByUserId(gameSequenceItemVO.getUserId());
            //遍历每一条学生数据 给joinGame赋值
            gameSequenceItemVO.setJoinGames(gameSequenceItemGamesName);
        }

        return gameSequenceItemVOs;
    }

    /**
     * @Description 根据学号查询其参加比赛的数据
     * @Param userId
     * @Return {@link ArrayList<String>}
     * @Author coder_jlt
     * @Date 2022/9/15 13:38
     */
    private ArrayList<String> getGameSequenceItemGamesVOsByUserId(Long userId) {
        if (ObjectUtils.isEmpty(userId)) {
            return null;
        }
        return sportRegistrationsMapper.getGameSequenceItemGamesName(userId);
    }


}
