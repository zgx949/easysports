package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.FitnessTestGrade;

/**
 * 体测成绩Service接口
 * 
 * @author leftHand
 * @date 2022-08-15
 */
public interface IFitnessTestGradeService 
{
    /**
     * 查询体测成绩
     * 
     * @param id 体测成绩主键
     * @return 体测成绩
     */
    public FitnessTestGrade selectFitnessTestGradeById(Long id);

    /**
     * 查询体测成绩列表
     * 
     * @param fitnessTestGrade 体测成绩
     * @return 体测成绩集合
     */
    public List<FitnessTestGrade> selectFitnessTestGradeList(FitnessTestGrade fitnessTestGrade);

    /**
     * 新增体测成绩
     * 
     * @param fitnessTestGrade 体测成绩
     * @return 结果
     */
    public int insertFitnessTestGrade(FitnessTestGrade fitnessTestGrade);

    /**
     * 修改体测成绩
     * 
     * @param fitnessTestGrade 体测成绩
     * @return 结果
     */
    public int updateFitnessTestGrade(FitnessTestGrade fitnessTestGrade);

    /**
     * 批量删除体测成绩
     * 
     * @param ids 需要删除的体测成绩主键集合
     * @return 结果
     */
    public int deleteFitnessTestGradeByIds(Long[] ids);

    /**
     * 删除体测成绩信息
     * 
     * @param id 体测成绩主键
     * @return 结果
     */
    public int deleteFitnessTestGradeById(Long id);
}
