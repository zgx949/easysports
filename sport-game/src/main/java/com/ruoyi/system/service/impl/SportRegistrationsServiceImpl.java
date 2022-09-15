package com.ruoyi.system.service.impl;

import java.util.*;

import com.ruoyi.common.core.domain.entity.SysDept;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.system.domain.SportItem;
import com.ruoyi.system.domain.Vo.RegisterReportVo;
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
     * 生成秩序册XMl(WORD)
     * @param user
     * @return
     */
    @Override
    public String wordGeneration(SysUser user) {
        //TODO:把用户参数去掉
        int[] deptIds = {
                100,
                101,
                102,
                103,
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

        mp.put("depthReport", rows1.toString());
        // 生成最终模板

        return WordUtils.process(mp, "/vm/sportMeeting/template.ftl").toString();
    }
}
