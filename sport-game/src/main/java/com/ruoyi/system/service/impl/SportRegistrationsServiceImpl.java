package com.ruoyi.system.service.impl;

import java.util.*;

import com.ruoyi.common.core.domain.entity.SysDept;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.system.domain.SportGames;
import com.ruoyi.system.domain.SportItem;
import com.ruoyi.system.domain.Vo.GameDescVo;
import com.ruoyi.system.domain.Vo.RegisterReportVo;
import com.ruoyi.system.mapper.SportGamesMapper;
import com.ruoyi.system.mapper.SportItemMapper;
import com.ruoyi.system.utls.WordUtils;
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
public class SportRegistrationsServiceImpl implements ISportRegistrationsService
{
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
    public SportRegistrations selectSportRegistrationsById(Long id)
    {
        return sportRegistrationsMapper.selectSportRegistrationsById(id);
    }

    /**
     * 查询报名管理列表
     *
     * @param sportRegistrations 报名管理
     * @return 报名管理
     */
    @Override
    public List<SportRegistrations> selectSportRegistrationsList(SportRegistrations sportRegistrations)
    {
        return sportRegistrationsMapper.selectSportRegistrationsList(sportRegistrations);
    }

    /**
     * 新增报名管理
     *
     * @param sportRegistrations 报名管理
     * @return 结果
     */
    @Override
    public int insertSportRegistrations(SportRegistrations sportRegistrations)
    {
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
    public int updateSportRegistrations(SportRegistrations sportRegistrations)
    {
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
    public int deleteSportRegistrationsByIds(Long[] ids)
    {
        return sportRegistrationsMapper.deleteSportRegistrationsByIds(ids);
    }

    /**
     * 删除报名管理信息
     *
     * @param id 报名管理主键
     * @return 结果
     */
    @Override
    public int deleteSportRegistrationsById(Long id)
    {
        return sportRegistrationsMapper.deleteSportRegistrationsById(id);
    }

    /**
     * 根据用户id和比赛id取消报名
     * @param userId
     * @param gameId
     * @return
     */
    @Override
    public int deleteUserRegistrations(Long userId, Long gameId) {
        return sportRegistrationsMapper.deleteUserSportRegistrations(userId,gameId);
    }

    /**
     * 根据用户id查询比赛信息并排序
     * @param sportRegistrations
     * @return
     */
    @Override
    public List<SportRegistrations> userRegisterationslist(SportRegistrations sportRegistrations) {
        return sportRegistrationsMapper.userRegisterationslist(sportRegistrations);
    }

    /**
     * 用户报名
     * @param sportRegistrations
     * @return
     */
    @Override
    public int insertUserRegistrations(SportRegistrations sportRegistrations) {
        return sportRegistrationsMapper.insertUserRegistrations(sportRegistrations);
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
        for (SportRegistrations item : registerList) {
            Long itemId = item.getGame().getItemId();
            SportItem sportItem = sportItemService.selectSportItemById(itemId);

            itemList
                    .append(sportItem.getItemName())
                    .append("\t");
        }
        RegisterReportVo registerReportVo = new RegisterReportVo();
        // TODO: 这里的号码临时先用用户名测试
        registerReportVo.setNum(user.getUserName());
        String nickName = user.getNickName();
        // 对齐表格，防止错位
        if (nickName.length() == 2) {
            nickName += "  ";
        }
        registerReportVo.setName(user.getNickName());
        // TODO: 需要加一个查询岗位信息，判断是学生还是教工
        registerReportVo.setUserType("学生");
        registerReportVo.setGender(user.getSex().equals("0") ? "男": "女");
        registerReportVo.setItemList(itemList.toString());

        StringBuilder rowText = new StringBuilder();
        rowText
                .append(registerReportVo.getNum())
                .append("\t")
                .append(registerReportVo.getName())
                .append("\t")
                .append(registerReportVo.getUserType())
                .append("\t")
                .append(registerReportVo.getGender())
                .append("\t")
                .append(registerReportVo.getItemList());

        return rowText.toString();
    }

    /**
    * @Description: 获取学院代表队表格的word
    * @Param:
    * @return:
    * @Author: zgx
    * @Date: 2022-09-15
    */
    public String getDeptRegister(long deptId) {
        SysDept sysDept = sysDeptService.selectDeptById(deptId);
        String leader = sysDept.getLeader();
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
        String res = WordUtils.deptTable(sysDept.getDeptName(), leader, trainer, rows);
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
            int groupCount = (int) (totalPerson / groupLimit + (totalPerson % groupLimit > 0 ? 1 : 0));

            gd.setGameName(gameName);
            gd.setGroupCount(String.valueOf(groupCount));
            gd.setStrtTime(st);
            gd.setTotalPerson(String.valueOf(totalPerson));
            gamesDescList.add(gd);
        }
        String itemTypeName = null;
        if (itemType == 1) itemTypeName = "田赛";
        else if (itemType == 2) itemTypeName = "径赛";
        else  itemTypeName = "集体项目";
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
        sd.set(Calendar.HOUR, 0);
        sd.set(Calendar.MINUTE, 0);
        sd.set(Calendar.SECOND, 0);

        curr.setTime(sd.getTime());

        Calendar ed = Calendar.getInstance();
        ed.setTime(DateUtils.parseDate(sportGamesMapper.endDate()));
        ed.set(Calendar.HOUR, 23);
        ed.set(Calendar.MINUTE, 59);
        ed.set(Calendar.SECOND, 59);




        // 开始时间小于结束时间
        while(sd.before(ed)) {

            // 如果已分片到下午
            if (sd.get(Calendar.HOUR) == 12) {
                // 跳转到第二天早上
                sd.add(Calendar.DATE, 1);
                sd.set(Calendar.HOUR, 0);
                sd.set(Calendar.MINUTE, 0);
                sd.set(Calendar.SECOND, 0);
            } else {
                // 跳转到当天中午
                sd.set(Calendar.HOUR, 12);
                sd.set(Calendar.MINUTE, 0);
                sd.set(Calendar.SECOND, 0);
            }
        }


        String res = gameSlot(startDate, endDate,1L);
        return res;

//        WordUtils.
    }


    /**
     * 生成秩序册XMl(WORD)
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
        mp.put("gamesGroups", "");

        // 生成最终模板

        return WordUtils.process(mp, "/vm/sportMeeting/template.ftl").toString();
    }
}
