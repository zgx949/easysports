package com.ruoyi.system.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.FitnessTestGradeMapper;
import com.ruoyi.system.domain.FitnessTestGrade;
import com.ruoyi.system.service.IFitnessTestGradeService;

/**
 * 体测成绩Service业务层处理
 * 
 * @author leftHand
 * @date 2022-08-15
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
}
