package com.ruoyi.system.service.impl;

import java.util.LinkedList;
import java.util.List;

import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.system.domain.Vo.FitnessTestGradeVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.FitnessTestGradeMapper;
import com.ruoyi.system.domain.FitnessTestGrade;
import com.ruoyi.system.service.IFitnessTestGradeService;

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
}
