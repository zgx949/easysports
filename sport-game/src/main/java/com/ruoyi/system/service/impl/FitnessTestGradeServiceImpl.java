package com.ruoyi.system.service.impl;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.system.domain.FitnessTestActivity;
import com.ruoyi.system.domain.FitnessTestBaseInfo;
import com.ruoyi.system.domain.FitnessTestScore;
import com.ruoyi.system.domain.Vo.*;
import com.ruoyi.system.mapper.*;
import com.ruoyi.system.utils.PassFitnessUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.domain.FitnessTestGrade;
import com.ruoyi.system.service.IFitnessTestGradeService;
import org.springframework.util.CollectionUtils;
import org.springframework.util.ObjectUtils;

/**
 * 体测成绩Service业务层处理
 *
 * @author leftHand
 * @date 2022-08-23
 */
@Service
public class FitnessTestGradeServiceImpl implements IFitnessTestGradeService
{
    @Autowired
    private FitnessTestGradeMapper fitnessTestGradeMapper;

    @Autowired
    private FitnessTestBaseInfoMapper fitnessTestBaseInfoMapper;

    @Autowired
    private FitnessTestScoreMapper fitnessTestScoreMapper;

    @Autowired
    private FitnessTestActivityMapper fitnessTestActivityMapper;

    @Autowired
    private SysUserMapper sysUserMapper;

    @Autowired
    private RedisCache redisCache;

    @Autowired
    private PassFitnessUtils passFitnessUtils;

    /**
     * 查询体测成绩
     *
     * @param id 体测成绩主键
     * @return 体测成绩
     */
    @Override
    public FitnessTestGrade selectFitnessTestGradeById(Long id)
    {
        return fitnessTestGradeMapper.selectFitnessTestGradeById(id);
    }

    /**
     * 查询体测成绩列表
     *
     * @param fitnessTestGrade 体测成绩
     * @return 体测成绩
     */
    @Override
    public List<FitnessTestGrade> selectFitnessTestGradeList(FitnessTestGrade fitnessTestGrade)
    {
        return fitnessTestGradeMapper.selectFitnessTestGradeList(fitnessTestGrade);
    }

    /**
     * 新增体测成绩
     *
     * @param fitnessTestGrade 体测成绩
     * @return 结果
     */
    @Override
    public int insertFitnessTestGrade(FitnessTestGrade fitnessTestGrade)
    {
        fitnessTestGrade.setCreateTime(DateUtils.getNowDate());
        return fitnessTestGradeMapper.insertFitnessTestGrade(fitnessTestGrade);
    }

    /**
     * 修改体测成绩
     *
     * @param fitnessTestGrade 体测成绩
     * @return 结果
     */
    @Override
    public int updateFitnessTestGrade(FitnessTestGrade fitnessTestGrade)
    {
        fitnessTestGrade.setUpdateTime(DateUtils.getNowDate());
        return fitnessTestGradeMapper.updateFitnessTestGrade(fitnessTestGrade);
    }

    /**
     * 批量删除体测成绩
     *
     * @param ids 需要删除的体测成绩主键
     * @return 结果
     */
    @Override
    public int deleteFitnessTestGradeByIds(Long[] ids)
    {
        return fitnessTestGradeMapper.deleteFitnessTestGradeByIds(ids);
    }

    /**
     * 删除体测成绩信息
     *
     * @param id 体测成绩主键
     * @return 结果
     */
    @Override
    public int deleteFitnessTestGradeById(Long id)
    {
        return fitnessTestGradeMapper.deleteFitnessTestGradeById(id);
    }

    /**
     * @Description: 查询自身的成绩情况
     * @Param:
     * @return:
     * @Author: leftHand
     * @Date: 2022-08-25
     */
    @Override
    public List<FitnessTestGradeVo> queryMyRecord(SysUser user) {
        // 读取用户名
        String userName = user.getUserName();
        FitnessTestGrade condition = new FitnessTestGrade();
        condition.setUserId(userName);

        // 查询该用户的所有成绩记录
        List<FitnessTestGrade> list = selectFitnessTestGradeList(condition);

        // 返回的结果
        List<FitnessTestGradeVo> result = new LinkedList<>();
        for (FitnessTestGrade item : list) {
            FitnessTestGradeVo temp = new FitnessTestGradeVo();
            temp.setUserId(user.getUserId());
            temp.setUserName(user.getUserName());
            temp.setGender(user.getSex());
            temp.setDept(user.getDept());
            temp.setFta(item.getFta());
            temp.setItem(item.getItem());
            temp.setScore(item.getScore());
            temp.setCreateUser(item.getCreateUser());
            temp.setUpdateUser(item.getUpdateUser());
            temp.setCreateTime(item.getCreateTime());
            temp.setUpdateTime(item.getUpdateTime());
            result.add(temp);
        }
        return result;
    }

    /**
     * 根据用户名列表查询用户信息
     * @param userNameList
     * @return
     */
    @Override
    public List<SysUser> selectSysUserListByNames(List<String> userNameList) {
        List<SysUser>sysUserList=new ArrayList<>();
        for(String username:userNameList){
            SysUser sysUser = sysUserMapper.selectUserByUserName(username);
            if(ObjectUtils.isEmpty(sysUser)){
                continue;
            }
            sysUserList.add(sysUser);
        }
        return sysUserList;
    }

    /**
     * 批量插入成绩
     * @param fitnessTestGrades
     * @return
     */
    public InsertFitnessTestGradeVo insertGradeList(List<FitnessTestGrade> fitnessTestGrades){
        int successCount=0;//记录插入成功的数量
        List<FitnessTestGrade>failInsertList=new ArrayList<>();
        InsertFitnessTestGradeVo insertFitnessTestGradeVo=new InsertFitnessTestGradeVo();
        for (FitnessTestGrade fitnessTestGrade:fitnessTestGrades){
            //查询该成绩是否存在
            List<FitnessTestGrade> tempList = fitnessTestGradeMapper.selectFitnessTestGrades(fitnessTestGrade);

            //存在则更新 跳过此次循环
            if(!CollectionUtils.isEmpty(tempList)){
                //记录到插入失败的列表
//                failInsertList.add(fitnessTestGrade);
                // 更新数据
                if (fitnessTestGrade.getScore() != 0 && fitnessTestGrade.getScore() != null) {
                    fitnessTestGrade.setId(tempList.get(0).getId());
                    fitnessTestGrade.setUpdateUid(SecurityUtils.getUserId());
                    fitnessTestGradeMapper.updateFitnessTestGrade(fitnessTestGrade);
                } else {
                    failInsertList.add(fitnessTestGrade);
                }
                continue;
            }

            //不存在则插入成绩
            fitnessTestGrade.setCreateTime(DateUtils.getNowDate());
            SysUser sysUser = sysUserMapper.selectUserByUserName(fitnessTestGrade.getUserId());//根据用户名找用户信息
            if(!ObjectUtils.isEmpty(sysUser)){//如果该用户存在
                fitnessTestGrade.setCreateUid(sysUser.getUserId());
            }else{//如果该用户存不存在
                //记录到插入失败的列表
                failInsertList.add(fitnessTestGrade);
                continue;
            }
            int index=fitnessTestGradeMapper.insertFitnessTestGrade(fitnessTestGrade);
            if(index==1){
                successCount++;
            }
        }
        insertFitnessTestGradeVo.setFailInsertList(failInsertList);
        insertFitnessTestGradeVo.setSuccessCount(successCount);
        if(successCount==fitnessTestGrades.size() || failInsertList.size() == 0){//全部插入
            insertFitnessTestGradeVo.setAllInsertSuccess(true);
        }else{//存在插入失败
            insertFitnessTestGradeVo.setAllInsertSuccess(false);
        }
        return insertFitnessTestGradeVo;
    }

    /**
     * 查询成绩合格情况
     *
     * @param userId
     * @return
     */
    @Override
    public FitnessPassStatusVo queryPass(String userId) {
        // TODO：查询成绩合格情况
        // 出参
        FitnessPassStatusVo result = new FitnessPassStatusVo();
        FitnessTestBaseInfo baseInfo = fitnessTestBaseInfoMapper.selectBaseInfoByUserId(userId);
        // 成绩合格情况集合
        List<FitnessPassScoreVo> scorePassList = new ArrayList<>();
        // 用户基本信息
        FitnessBaseInfoVo baseInfoVo = new FitnessBaseInfoVo();

        if (baseInfo != null) {
            baseInfoVo.setDept(baseInfo.getDept());
            baseInfoVo.setUserId(baseInfo.getUserId());
            baseInfoVo.setUserName(baseInfo.getUserName());
            baseInfoVo.setSex(baseInfo.getSex());
            baseInfoVo.setClassNum(baseInfo.getClassNum());
        }

        result.setUserInfo(baseInfoVo);

        // 成绩查询条件
        FitnessTestScore condition = new FitnessTestScore();
        condition.setUserId(userId);
        List<FitnessTestScore> scores = fitnessTestScoreMapper.selectFitnessTestScoreList(condition);
        for (FitnessTestScore score : scores) {
            FitnessPassScoreVo tempPassScoreVo = new FitnessPassScoreVo();
            tempPassScoreVo.setScore(score);
            FitnessTestActivity activity = fitnessTestActivityMapper.selectFitnessTestActivityById(score.getFtaId());
            if (activity == null) {
                tempPassScoreVo.setActivityName("未知活动");
            } else {
                tempPassScoreVo.setActivityName(activity.getName());
            }

            tempPassScoreVo.setHeight(score.getHeight());
            tempPassScoreVo.setWeight(score.getWeight());
            tempPassScoreVo.setLeftEye(score.getLeftEye());
            tempPassScoreVo.setRightEye(score.getLeftEye());

            if (baseInfo != null && baseInfo.getSex() != null) {

                Long sex = baseInfo.getSex();
                // TODO: 设置补测们限值

                tempPassScoreVo.setEnduranceRunningPass(passFitnessUtils.longRun(sex, score.getEnduranceRunning()));
                tempPassScoreVo.setFiftyRunPass(passFitnessUtils.fifRun(sex, score.getFiftyRun()));
                tempPassScoreVo.setSittingBodyBendPass(passFitnessUtils.flex(sex, score.getSittingBodyBend()));
                tempPassScoreVo.setLongJumpPass(passFitnessUtils.jump(sex, score.getLongJump()));
                tempPassScoreVo.setOtherItemPass(passFitnessUtils.other(sex, score.getOtherItem()));
                tempPassScoreVo.setVitalCapacityPass(passFitnessUtils.lung(sex, score.getVitalCapacity()));
            }


            scorePassList.add(tempPassScoreVo);

        }

        result.setScores(scorePassList);
        return result;
    }
}
